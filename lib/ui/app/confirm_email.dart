// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/confirm_email_vm.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ConfirmEmailVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = viewModel.state!;

    return Material(
      color: Theme.of(context).cardColor,
      child: state.isLoading || state.isSaving
          ? LoadingIndicator()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon.png',
                    height: 80,
                  ),
                  SizedBox(height: 60),
                  Text(
                    localization!.confirmYourEmailAddress,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 80),
                    child: HelpText(state.user.email),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: kTableColumnGap),
                        child: TextButton(
                          onPressed:
                              viewModel.onResendPressed as void Function()?,
                          child: Text(localization.resendEmail.toUpperCase()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: kTableColumnGap),
                        child: TextButton(
                          onPressed: () {
                            passwordCallback(
                              context: context,
                              callback: (password, idToken) {
                                fieldCallback(
                                  callback: (value) {
                                    viewModel.onChangeEmail!(
                                        context, value, password, idToken);
                                  },
                                  field: localization.email,
                                  context: context,
                                  title: localization.changeEmail,
                                );
                              },
                            );
                          },
                          child: Text(localization.changeEmail.toUpperCase()),
                        ),
                      ),
                      /*
                      if (state.user.lastEmailAddress.isNotEmpty) ...[
                        TextButton(
                          onPressed: () => viewModel.onUseLastPressed(context),
                          child: Text(localization.useLastEmail.toUpperCase()),
                        ),
                        SizedBox(
                          width: kTableColumnGap,
                        ),
                      ],
                      */
                      Padding(
                        padding: const EdgeInsets.only(bottom: kTableColumnGap),
                        child: TextButton(
                          onPressed:
                              viewModel.onRefreshPressed as void Function()?,
                          child: Text(localization.refreshData.toUpperCase()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: kTableColumnGap),
                        child: TextButton(
                          onPressed:
                              viewModel.onLogoutPressed as void Function()?,
                          child: Text(localization.logout.toUpperCase()),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
