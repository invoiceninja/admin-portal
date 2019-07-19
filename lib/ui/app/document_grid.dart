import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentGrid extends StatelessWidget {
  const DocumentGrid({
    @required this.documents,
    @required this.onFileUpload,
    @required this.onDeleteDocument,
  });

  final List<int> documents;
  final Function(String) onFileUpload;
  final Function(DocumentEntity) onDeleteDocument;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  icon: Icons.camera_alt,
                  label: localization.takePicture,
                  onPressed: () async {
                    final image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    onFileUpload(image.path);
                  },
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Expanded(
                child: ElevatedButton(
                  icon: Icons.insert_drive_file,
                  label: localization.uploadFile,
                  onPressed: () async {
                    final image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    onFileUpload(image.path);
                  },
                ),
              ),
            ],
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
              .map((documentId) => DocumentTile(
                    document: state.documentState.map[documentId],
                    onDeleteDocument: onDeleteDocument,
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
  });

  final DocumentEntity document;
  final Function(DocumentEntity) onDeleteDocument;

  void showDocumentModal(BuildContext context) {
    showDialog<Column>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          final localization = AppLocalization.of(context);

          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10),
              FormCard(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        color: Colors.red,
                        icon: Icons.delete,
                        label: localization.delete,
                        onPressed: () {
                          showDialog<AlertDialog>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              semanticLabel: localization.areYouSure,
                              title: Text(localization.areYouSure),
                              actions: <Widget>[
                                FlatButton(
                                    child:
                                        Text(localization.cancel.toUpperCase()),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                FlatButton(
                                    child: Text(localization.ok.toUpperCase()),
                                    onPressed: () {
                                      onDeleteDocument(document);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        icon: Icons.check_circle,
                        label: localization.done,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  DocumentPreview(document),
                ],
              )
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
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document.name ?? '',
                          style: Theme.of(context).textTheme.subhead,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          formatDate(
                              convertTimestampToDateString(document.createdAt),
                              context) + ' • ' + document.prettySize,
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
    return document.preview != null && document.preview.isNotEmpty
        ? CachedNetworkImage(
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            key: ValueKey(document.preview),
            imageUrl: document.previewUrl(state.authState.url),
            httpHeaders: {'X-Ninja-Token': state.selectedCompany.token},
            placeholder: (context, url) => Container(
                  height: height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            errorWidget: (context, url, error) => Text(
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
