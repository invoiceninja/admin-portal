// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class BlankScreen extends StatelessWidget {
  const BlankScreen([this.message]);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: isMobile(context),
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        child: HelpText(message ?? ''),
      ),
    );
  }
}
