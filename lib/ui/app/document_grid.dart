// Flutter imports:
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dashed_rect.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:version/version.dart';

class DocumentGrid extends StatefulWidget {
  const DocumentGrid({
    required this.documents,
    required this.onUploadDocument,
    required this.onRenamedDocument,
    this.onViewExpense,
  });

  final List<DocumentEntity> documents;
  final Function(List<MultipartFile>, bool) onUploadDocument;
  final Function(DocumentEntity)? onViewExpense;
  final Function onRenamedDocument;

  @override
  State<DocumentGrid> createState() => _DocumentGridState();
}

class _DocumentGridState extends State<DocumentGrid> {
  bool _dragging = false;
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final state = StoreProvider.of<AppState>(context).state;

    final privateSwitch = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SwitchListTile(
        title: Row(
          children: [
            Icon(Icons.lock),
            SizedBox(width: 16),
            Text(localization.private),
          ],
        ),
        value: _isPrivate,
        onChanged: (value) {
          setState(() {
            _isPrivate = value;
          });
        },
      ),
    );

    return ScrollableListView(
      children: [
        if (state.isEnterprisePlan) ...[
          if (kIsWeb || isDesktopOS())
            LayoutBuilder(builder: (context, constraints) {
              final child = InkWell(
                onTap: () async {
                  final files = await pickFiles(
                    allowedExtensions: DocumentEntity.ALLOWED_EXTENSIONS,
                  );
                  if (files != null && files.isNotEmpty) {
                    widget.onUploadDocument(files, _isPrivate);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DropTarget(
                    onDragDone: (detail) async {
                      final List<MultipartFile> multipartFiles = [];
                      for (var index = 0;
                          index < detail.files.length;
                          index++) {
                        final file = detail.files[index];
                        final bytes = await file.readAsBytes();
                        final multipartFile = MultipartFile.fromBytes(
                            'documents[$index]', bytes,
                            filename: file.name);
                        multipartFiles.add(multipartFile);
                      }

                      widget.onUploadDocument(multipartFiles, _isPrivate);
                    },
                    onDragEntered: (detail) {
                      setState(() => _dragging = true);
                    },
                    onDragExited: (detail) {
                      setState(() => _dragging = false);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 75,
                          width: double.infinity,
                          child: Center(
                            child: Text(localization.clickOrDropFilesHere),
                          ),
                          color: _dragging
                              ? Colors.blue.withOpacity(0.4)
                              : Theme.of(context).scaffoldBackgroundColor,
                        ),
                        DashedRect(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (Version.parse(state.account.currentVersion) <
                      Version.parse('5.6.32') &&
                  kReleaseMode) {
                return child;
              } else if (constraints.maxWidth > 500) {
                return Row(
                  children: [
                    Expanded(
                      child: child,
                      flex: 3,
                    ),
                    Expanded(
                      child: privateSwitch,
                      flex: 2,
                    )
                  ],
                );
              } else {
                return Column(
                  children: [
                    privateSwitch,
                    child,
                  ],
                );
              }
            }),
          if (isMobileOS())
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: AppButton(
                      iconData: isIOS() ? null : Icons.camera_alt,
                      label: isIOS()
                          ? localization.camera
                          : localization.takePicture,
                      onPressed: () async {
                        final status = await Permission.camera.request();
                        if (status == PermissionStatus.granted) {
                          final multipartFiles = <MultipartFile>[];
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image != null) {
                            final croppedFile = (await ImageCropper()
                                .cropImage(sourcePath: image.path))!;
                            final bytes = await croppedFile.readAsBytes();
                            final multipartFile = MultipartFile.fromBytes(
                                'documents[0]', bytes,
                                filename: image.path.split('/').last);
                            multipartFiles.add(multipartFile);
                            widget.onUploadDocument(multipartFiles, _isPrivate);
                          }
                        } else {
                          openAppSettings();
                        }
                      },
                    ),
                  ),
                  if (isIOS()) ...[
                    SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: localization.gallery,
                        onPressed: () async {
                          final multipartFiles = await pickFiles(
                            allowedExtensions:
                                DocumentEntity.ALLOWED_EXTENSIONS,
                            fileType: FileType.image,
                          );

                          if (multipartFiles != null &&
                              multipartFiles.isNotEmpty) {
                            widget.onUploadDocument(multipartFiles, _isPrivate);
                          }
                        },
                      ),
                    ),
                  ],
                  SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      iconData: isIOS() ? null : Icons.insert_drive_file,
                      label: isIOS()
                          ? localization.files
                          : localization.uploadFiles,
                      onPressed: () async {
                        final files = await pickFiles(
                          allowedExtensions: DocumentEntity.ALLOWED_EXTENSIONS,
                        );
                        if (files != null && files.isNotEmpty) {
                          widget.onUploadDocument(files, _isPrivate);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
        ] else
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                localization.requiresAnEnterprisePlan,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ListDivider(),
        LayoutBuilder(builder: (context, constraints) {
          return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(6),
            childAspectRatio: ((constraints.maxWidth / 2) - 8) / 200,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: widget.documents
                .map((document) => DocumentTile(
                      documentId: document.id,
                      onViewExpense: widget.onViewExpense,
                      onRenamedDocument: widget.onRenamedDocument,
                      isFromExpense: false,
                    ))
                .toList(),
          );
        }),
      ],
    );
  }
}

class DocumentTile extends StatelessWidget {
  const DocumentTile({
    required this.documentId,
    required this.onViewExpense,
    required this.isFromExpense,
    required this.onRenamedDocument,
  });

  final String documentId;
  final Function(DocumentEntity)? onViewExpense;
  final bool isFromExpense;
  final Function onRenamedDocument;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final document = state.documentState.map[documentId];

    if (document == null) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: (document.isImage || document.isPdf)
                      ? () => handleDocumentAction(
                          context, [document], EntityAction.viewDocument)
                      : null,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      DocumentPreview(
                        document,
                        height: 110,
                      ),
                      if (!document.isPublic)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.lock),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Tooltip(
                            message: document.name,
                            child: Text(
                              document.name,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            '${formatDate(convertTimestampToDateString(document.createdAt), context)}\n${document.prettySize}',
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == localization!.view) {
                                handleDocumentAction(context, [document],
                                    EntityAction.viewDocument);
                              } else if (value == localization.download) {
                                handleDocumentAction(
                                    context, [document], EntityAction.download);
                              } else if (value == localization.delete) {
                                handleDocumentAction(
                                    context, [document], EntityAction.delete);
                              } else if (value == localization.viewExpense) {
                                onViewExpense!(document);
                              } else if (value == localization.rename) {
                                fieldCallback(
                                  context: context,
                                  title: localization.rename,
                                  field: localization.name,
                                  value: document.name,
                                  maxLength: 250,
                                  callback: (name) {
                                    store.dispatch(
                                      SaveDocumentRequest(
                                          completer:
                                              snackBarCompleter<DocumentEntity>(
                                                  localization.renamedDocument)
                                                ..future.then((value) {
                                                  onRenamedDocument();
                                                }),
                                          document: document
                                              .rebuild((b) => b..name = name)),
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                if (document.isImage || document.isPdf)
                                  PopupMenuItem<String>(
                                    child: IconText(
                                      text: localization!.view,
                                      icon: Icons.open_in_browser,
                                    ),
                                    value: localization.view,
                                  ),
                                PopupMenuItem<String>(
                                  child: IconText(
                                    text: localization!.download,
                                    icon: Icons.download,
                                  ),
                                  value: localization.download,
                                ),
                                PopupMenuItem<String>(
                                  child: IconText(
                                    text: localization.rename,
                                    icon: MdiIcons.renameBox,
                                  ),
                                  value: localization.rename,
                                ),
                                PopupMenuItem<String>(
                                  child: IconText(
                                    text: localization.delete,
                                    icon: Icons.delete,
                                  ),
                                  value: localization.delete,
                                ),
                              ];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DocumentPreview extends StatelessWidget {
  const DocumentPreview(this.document, {this.height});

  final DocumentEntity document;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final repoDocument = state.documentState.map[document.id];

    if (document.isImage) {
      if (repoDocument!.data != null) {
        return Image.memory(
          repoDocument.data!,
          height: height,
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
            '${cleanApiUrl(state.credentials.url)}/documents/${document.hash}',
            key: ValueKey(document.preview),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            headers: {'X-API-TOKEN': state.credentials.token});
      }
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Icon(getFileTypeIcon(document.type), size: 40),
    );
  }
}
