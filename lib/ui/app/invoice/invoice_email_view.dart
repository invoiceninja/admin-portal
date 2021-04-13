import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/templates.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class InvoiceEmailView extends StatefulWidget {
  const InvoiceEmailView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EmailEntityVM viewModel;

  @override
  _InvoiceEmailViewState createState() => new _InvoiceEmailViewState();
}

class _InvoiceEmailViewState extends State<InvoiceEmailView>
    with SingleTickerProviderStateMixin {
  EmailTemplate selectedTemplate;
  String _bodyPreview = '';
  String _subjectPreview = '';
  bool _isLoading = false;

  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: kMillisecondsToDebounceSave);

  TabController _controller;
  List<TextEditingController> _controllers = [];

  static const kTabPreview = 0;

  //static const kTabEdit = 1;
  //static const kTabHistory = 2;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    _controller.addListener(_loadTemplate);
    _controllers = [
      _subjectController,
      _bodyController,
    ];

    final client = widget.viewModel.client;
    if (client.isStale) {
      widget.viewModel.loadClient();
    }

    switch (widget.viewModel.invoice.entityType) {
      case EntityType.invoice:
        selectedTemplate = EmailTemplate.invoice;
        break;
      case EntityType.quote:
        selectedTemplate = EmailTemplate.quote;
        break;
      case EntityType.credit:
        selectedTemplate = EmailTemplate.credit;
        break;
    }
  }

  @override
  void didChangeDependencies() {
    _loadTemplate();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadTemplate);
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {
      _loadTemplate();
    });
  }

  void _loadTemplate() {
    if (_isLoading || (isMobile(context) && _controller.index != kTabPreview)) {
      return;
    }

    final origSubject = _subjectController.text.trim();
    final origBody = _bodyController.text.trim();

    setState(() {
      _isLoading = true;
    });

    loadEmailTemplate(
        context: context,
        subject: origSubject,
        body: origBody,
        template: '$selectedTemplate',
        invoice: widget.viewModel.invoice,
        onComplete: (subject, body, rawSubject, rawBody) {
          if (!mounted) {
            return;
          }

          setState(() {
            _isLoading = false;
            _subjectPreview = subject.trim();
            _bodyPreview = body.trim();

            if (origSubject.isEmpty && origBody.isEmpty) {
              _subjectController.text = rawSubject.trim();
              _bodyController.text = rawBody.trim();
            }
          });
        });
  }

  Widget _buildTemplateDropdown(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = widget.viewModel.invoice;
    final client = viewModel.client;
    final state = viewModel.state;
    final settings = SettingsEntity(
      clientSettings: client.settings,
      groupSettings: state.groupState.get(client.groupId).settings,
      companySettings: state.company.settings,
    );
    final contacts = invoice.invitations
        .map((invitation) => client.contacts.firstWhere(
            (contact) => contact.id == invitation.contactId,
            orElse: () => null))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 2),
      child: Row(
        children: [
          Expanded(
              child: Text(localization.to +
                  ': ' +
                  contacts
                      .where((contact) => contact != null)
                      .map((contact) => contact.fullNameWithEmail)
                      .join(', '))),
          DropdownButtonHideUnderline(
            child: DropdownButton<EmailTemplate>(
              value: selectedTemplate,
              onChanged: (template) {
                setState(() {
                  _subjectController.text = '';
                  _bodyController.text = '';
                  selectedTemplate = template;
                  _loadTemplate();
                });
              },
              items: [
                DropdownMenuItem<EmailTemplate>(
                  child: Text(localization.initialEmail),
                  value: invoice.emailTemplate,
                ),
                if (invoice.isInvoice) ...[
                  DropdownMenuItem<EmailTemplate>(
                    child: Text(localization.firstReminder),
                    value: EmailTemplate.reminder1,
                  ),
                  DropdownMenuItem<EmailTemplate>(
                    child: Text(localization.secondReminder),
                    value: EmailTemplate.reminder2,
                  ),
                  DropdownMenuItem<EmailTemplate>(
                    child: Text(localization.thirdReminder),
                    value: EmailTemplate.reminder3,
                  ),
                ],
                if ((settings.emailSubjectCustom1 ?? '').isNotEmpty)
                  DropdownMenuItem<EmailTemplate>(
                    child: Text(localization.firstCustom),
                    value: EmailTemplate.custom1,
                  ),
                if ((settings.emailSubjectCustom2 ?? '').isNotEmpty)
                  DropdownMenuItem<EmailTemplate>(
                    child: Text(localization.secondCustom),
                    value: EmailTemplate.custom2,
                  ),
                if ((settings.emailSubjectCustom3 ?? '').isNotEmpty)
                  DropdownMenuItem<EmailTemplate>(
                    child: Text(localization.thirdCustom),
                    value: EmailTemplate.custom3,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    if (widget.viewModel.isLoading) {
      return LoadingIndicator(
        height: 210,
      );
    }

    return EmailPreview(
      isLoading: _isLoading,
      subject: _subjectPreview,
      body: _bodyPreview,
    );
  }

  Widget _buildEdit(BuildContext context) {
    final localization = AppLocalization.of(context);

    return SingleChildScrollView(
      child: FormCard(
        padding: EdgeInsets.only(
            left: 16, bottom: 16, right: 16, top: isMobile(context) ? 16 : 0),
        children: <Widget>[
          if (_isLoading &&
              _subjectController.text.isEmpty &&
              _bodyController.text.isEmpty)
            LoadingIndicator(height: 210)
          else ...[
            DecoratedFormField(
              controller: _subjectController,
              label: localization.subject,
              onChanged: (_) => _onChanged(),
            ),
            DecoratedFormField(
              controller: _bodyController,
              label: localization.body,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              onChanged: (_) => _onChanged(),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildHistory(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = widget.viewModel.invoice;
    final client = widget.viewModel.client;
    final activities = client.getActivities(
        invoiceId: invoice.id, typeId: kActivityEmailInvoice);

    if (activities.isEmpty) {
      return HelpText(localization.noHistory);
    }

    return ScrollableListViewBuilder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, index) {
        final ActivityEntity activity = activities.elementAt(index);
        return ActivityListTile(activity: activity, enableNavigation: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;

    if (isDesktop(context)) {
      return EditScaffold(
        entity: invoice,
        title: localization.sendEmail,
        onCancelPressed: (context) =>
            viewEntity(appContext: context.getAppContext(), entity: invoice),
        saveLabel: localization.send,
        onSavePressed: (context) {
          viewModel.onSendPressed(context, selectedTemplate,
              _subjectController.text, _bodyController.text);
        },
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTemplateDropdown(context),
                  _buildEdit(context),
                  Expanded(
                    child: Container(
                      child: _buildPreview(context),
                      color: Colors.white,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTabBar(
                      tabs: [
                        Tab(
                          child: Text(localization.pdf),
                        ),
                        Tab(
                          child: Text(localization.history),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          invoice.isCredit
                              ? CreditPdfScreen(showAppBar: false)
                              : invoice.isQuote
                                  ? QuotePdfScreen(showAppBar: false)
                                  : InvoicePdfScreen(showAppBar: false),
                          _buildHistory(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: EditScaffold(
        entity: invoice,
        title: localization.sendEmail,
        onCancelPressed: (context) =>
            viewEntity(appContext: context.getAppContext(), entity: invoice),
        appBarBottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(text: localization.preview),
            Tab(text: localization.customize),
            Tab(text: localization.pdf),
            Tab(text: localization.history),
          ],
        ),
        saveLabel: localization.send,
        onSavePressed: (context) {
          viewModel.onSendPressed(context, selectedTemplate,
              _subjectController.text, _bodyController.text);
        },
        body: TabBarView(
          controller: _controller,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTemplateDropdown(context),
                Expanded(child: _buildPreview(context)),
              ],
            ),
            _buildEdit(context),
            invoice.isCredit
                ? CreditPdfScreen(showAppBar: false)
                : invoice.isQuote
                    ? QuotePdfScreen(showAppBar: false)
                    : InvoicePdfScreen(showAppBar: false),
            _buildHistory(context),
          ],
        ),
      ),
    );
  }
}
