import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {

  const CustomField({
    @required this.controller,
    @required this.labelText,
    @required this.options,
    this.initialValue,
  });

  final TextEditingController controller;
  final String labelText;
  final List<String> options;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    if (labelText.isEmpty) {
      return Container();
    }

    if (options.isEmpty) {
      return TextFormField(
        autocorrect: false,
        controller: controller,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      );
    } else {
      final menuItems = options.map((option) => PopupMenuItem<String>(
        value: option,
        child: Text(option),
      )).toList();

      return PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        initialValue: initialValue,
        itemBuilder: (BuildContext context) => menuItems,
        onSelected: (value) => controller.text = value,
        child: InkWell(
          child: IgnorePointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
        ),
      );
    }
  }
}
