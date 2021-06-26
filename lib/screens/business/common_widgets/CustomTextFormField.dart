import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key key,
      this.labelText,
      this.textInputType,
      this.textEditingController,
      this.focusNode,
      this.initialValue,
      this.onSaved})
      : super(key: key);
  final String labelText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String initialValue;
  final void Function(String value) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: textInputType,
      controller: textEditingController,
      focusNode: focusNode,
      initialValue: initialValue,
      onSaved: onSaved,
    );
  }
}
