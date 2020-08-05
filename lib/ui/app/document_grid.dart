import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:path_provider/path_provider.dart';

class DocumentGrid extends StatelessWidget {
  const DocumentGrid({
    @required this.documents,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
    this.onViewExpense,
  });

  final List<DocumentEntity> documents;
  final Function(String) onUploadDocument;
  final Function(DocumentEntity) onDeleteDocument;
  final Function(DocumentEntity) onViewExpense;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    return ListView(
      shrinkWrap: true,
      children: [
        if (state.isEnterprisePlan)
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: <Widget>[
                if (!kIsWeb)
                  Expanded(
                    child: AppButton(
                      iconData: Icons.camera_alt,
                      label: localization.takePicture,
                      onPressed: () async {
                        final image = await ImagePicker()
                            .getImage(source: ImageSource.camera);
                        if (image != null && image.path != null) {
                          onUploadDocument(image.path);
                        }
                      },
                    ),
                  ),
                if (!kIsWeb)
                  SizedBox(
                    width: 14,
                  ),
                Expanded(
                  child: AppButton(
                    iconData: Icons.insert_drive_file,
                    label: localization.uploadFile,
                    onPressed: () async {
                      String path;
                      if (kIsWeb) {
                        path = await webFilePicker();
                      } else {
                        final image = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        if (image != null) {
                          path = image.path;
                        }
                      }
                      if (path != null) {
                        onUploadDocument(path);
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
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(6),
          shrinkWrap: true,
          primary: true,
          crossAxisCount: 2,
          children: documents
              .map((document) => DocumentTile(
                    document: document,
                    onDeleteDocument: onDeleteDocument,
                    onViewExpense: onViewExpense,
                    isFromExpense: false,
                  ))
              .toList(),
        ),
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
  });

  final DocumentEntity document;
  final Function(DocumentEntity) onDeleteDocument;
  final Function(DocumentEntity) onViewExpense;
  final bool isFromExpense;

  void showDocumentModal(BuildContext context) {
    showDialog<Column>(
        context: context,
        builder: (BuildContext context) {
          final localization = AppLocalization.of(context);

          return AlertDialog(
            title: Text(document.name),
            actions: [
              /*
              FlatButton(
                child: Text(localization.download.toUpperCase()),
                onPressed: () {
                  launch(document.url,
                      forceWebView: false, forceSafariVC: false);
                },
              ),
               */
              isFromExpense && onViewExpense != null
                  ? FlatButton(
                      child: Text(localization.expense.toUpperCase()),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onViewExpense(document);
                      },
                    )
                  : FlatButton(
                      child: Text(localization.delete.toUpperCase()),
                      onPressed: () {
                        confirmCallback(
                            context: context,
                            callback: () {
                              onDeleteDocument(document);
                              Navigator.pop(context);
                            });
                      },
                    ),
              if (!kIsWeb)
                FlatButton(
                  child: Text(localization.download.toUpperCase()),
                  onPressed: () async {
                    Directory directory;
                    if (Platform.isAndroid) {
                      directory = await getExternalStorageDirectory();
                    } else {
                      directory = await getApplicationDocumentsDirectory();
                    }

                    final String folder = '${directory.path}/documents';
                    await Directory(folder).create(recursive: true);
                    final filePath = '$folder/${document.name}';
                    final store = StoreProvider.of<AppState>(context);

                    final http.Response response = await WebClient().get(
                        document.url, store.state.credentials.token,
                        rawResponse: true);

                    await File(filePath).writeAsBytes(response.bodyBytes);
                    await FlutterShare.shareFile(
                      title: '${localization.name}',
                      filePath: filePath,
                    );
                  },
                ),
              FlatButton(
                child: Text(localization.close.toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InkWell(
          onTap: () => showDocumentModal(context),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DocumentPreview(
                    document,
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document.name ?? '',
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${formatDate(convertTimestampToDateString(document.createdAt), context)} • ${document.prettySize}',
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
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

    return ['png', 'jpg', 'jpeg'].contains(document.type)
        ? CachedNetworkImage(
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            key: ValueKey(document.preview),
            imageUrl: document.url,
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
                ))
        : SizedBox(
            height: height,
            width: double.infinity,
            child: Icon(getFileTypeIcon(document.type), size: 40),
          );
  }
}
