// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
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

class DocumentGrid extends StatelessWidget {
  const DocumentGrid({
    @required this.documents,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
    @required this.onRenamedDocument,
    this.onViewExpense,
  });

  final List<DocumentEntity> documents;
  final Function(MultipartFile) onUploadDocument;
  final Function(DocumentEntity, String, String) onDeleteDocument;
  final Function(DocumentEntity) onViewExpense;
  final Function onRenamedDocument;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    return ScrollableListView(
      children: [
        if (state.isEnterprisePlan)
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: Row(
              children: <Widget>[
                if (isMobileOS()) ...[
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: Text(localization.takePicture),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary)
                      ),
                      onPressed: () async {
                        final status = await Permission.camera.request();
                        if (status == PermissionStatus.granted) {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);

                          if (image != null && image.path != null) {
                            final croppedFile = await ImageCropper()
                                .cropImage(sourcePath: image.path);
                            final bytes = await croppedFile.readAsBytes();
                            final multipartFile = MultipartFile.fromBytes(
                                'documents[]', bytes,
                                filename: image.path.split('/').last);
                            onUploadDocument(multipartFile);
                          }
                        } else {
                          openAppSettings();
                        }
                      }

                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                ],
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.insert_drive_file),
                    label: Text(localization.uploadFile),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary)
                    ),
                    onPressed: () async {
                      final multipartFile = await pickFile(
                          fileIndex: 'documents[]',
                          allowedExtensions: DocumentEntity.ALLOWED_EXTENSIONS);

                      if (multipartFile != null) {
                        onUploadDocument(multipartFile);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        else
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
            primary: true,
            crossAxisCount: 2,
            children: documents
                .map((document) => DocumentTile(
                      document: document,
                      onDeleteDocument: onDeleteDocument,
                      onViewExpense: onViewExpense,
                      onRenamedDocument: onRenamedDocument,
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
    @required this.document,
    @required this.onDeleteDocument,
    @required this.onViewExpense,
    @required this.isFromExpense,
    @required this.onRenamedDocument,
  });

  final DocumentEntity document;
  final Function(DocumentEntity, String, String) onDeleteDocument;
  final Function(DocumentEntity) onViewExpense;
  final bool isFromExpense;
  final Function onRenamedDocument;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DocumentPreview(
                  document,
                  height: 110,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Tooltip(
                            message: document.name ?? '',
                            child: Text(
                              document.name ?? '',
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
                              if (value == localization.view) {
                                launchUrl(Uri.parse(state.account.defaultUrl +
                                    document.downloadUrl +
                                    '?inline=true'));
                              } else if (value == localization.download) {
                                if (kIsWeb ||
                                    (!Platform.isIOS && !Platform.isAndroid)) {
                                  launchUrl(Uri.parse(state.account.defaultUrl +
                                      document.downloadUrl));
                                } else {
                                  final directory =
                                      await getApplicationDocumentsDirectory();
                                  final String folder =
                                      '${directory.path}/documents';
                                  await Directory(folder)
                                      .create(recursive: true);
                                  final filePath = '$folder/${document.name}';

                                  final http.Response response =
                                      await WebClient().get(
                                          document.url, state.credentials.token,
                                          rawResponse: true);

                                  await File(filePath)
                                      .writeAsBytes(response.bodyBytes);
                                  await Share.shareXFiles([XFile(filePath)]);
                                }
                              } else if (value == localization.delete) {
                                confirmCallback(
                                    context: context,
                                    callback: (_) {
                                      passwordCallback(
                                          context: context,
                                          callback: (password, idToken) {
                                            onDeleteDocument(
                                                document, password, idToken);
                                          });
                                    });
                              } else if (value == localization.viewExpense) {
                                onViewExpense(document);
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
                                                  context,
                                                  localization.renamedDocument)
                                                ..future.then((value) {
                                                  onRenamedDocument();
                                                }),
                                          entity: document
                                              .rebuild((b) => b..name = name)),
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<String>(
                                  child: IconText(
                                    text: localization.view,
                                    icon: Icons.open_in_browser,
                                  ),
                                  value: localization.view,
                                ),
                                PopupMenuItem<String>(
                                  child: IconText(
                                    text: localization.download,
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
  final double height;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;

    if (['png', 'jpg', 'jpeg'].contains(document.type)) {
      return CachedNetworkImage(
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          key: ValueKey(document.preview),
          imageUrl: document.url,
          imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
          httpHeaders: {'X-API-TOKEN': state.credentials.token},
          placeholder: (context, url) => Container(
                height: height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          errorWidget: (context, url, Object error) => Text(
                '$error: $url',
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ));
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Icon(getFileTypeIcon(document.type), size: 40),
    );
  }
}
