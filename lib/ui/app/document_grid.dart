import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentGrid extends StatelessWidget {
  const DocumentGrid({
    @required this.documentIds,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
    @required this.onViewExpense,
  });

  final List<String> documentIds;
  final Function(String) onUploadDocument;
  final Function(DocumentEntity) onDeleteDocument;
  final Function(DocumentEntity) onViewExpense;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final company = state.company;

    return ListView(
      children: [
        if (company.isEnterprisePlan)
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    iconData: Icons.camera_alt,
                    label: localization.takePicture,
                    onPressed: () async {
                      final image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      if (image != null) {
                        onUploadDocument(image.path);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: ElevatedButton(
                    iconData: Icons.insert_drive_file,
                    label: localization.uploadFile,
                    onPressed: () async {
                      final image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      onUploadDocument(image.path);
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
          children: documentIds
              .map((documentId) => DocumentTile(
                    document: state.documentState.map[documentId],
                    onDeleteDocument: onDeleteDocument,
                    onViewExpense: onViewExpense,
                    isFromExpense: onViewExpense != null &&
                        state.documentState.map[documentId].isExpenseDocument,
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
        barrierDismissible: true,
        builder: (BuildContext context) {
          final localization = AppLocalization.of(context);

          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10),
              FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      isFromExpense
                          ? ElevatedButton(
                              iconData: getEntityIcon(EntityType.expense),
                              label: localization.expense,
                              onPressed: () {
                                Navigator.of(context).pop();
                                onViewExpense(document);
                              },
                            )
                          : ElevatedButton(
                              color: Colors.red,
                              iconData: Icons.delete,
                              label: localization.delete,
                              onPressed: () {
                                confirmCallback(
                                    context: context,
                                    callback: () {
                                      onDeleteDocument(document);
                                      Navigator.pop(context);
                                    });
                              },
                            ),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        iconData: Icons.check_circle,
                        label: localization.done,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(document.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline),
                  Text(
                    '${formatDate(convertTimestampToDateString(document.createdAt), context)} • ${document.prettySize}',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  SizedBox(height: 20),
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
                          style: Theme.of(context).textTheme.headline,
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

    return document.preview != null && document.preview.isNotEmpty
        ? CachedNetworkImage(
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            key: ValueKey(document.preview),
            imageUrl: document.previewUrl(state.credentials.url),
            httpHeaders: {'X-API-TOKEN': state.credentials.token},
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
