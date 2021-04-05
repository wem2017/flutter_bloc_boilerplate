import 'package:envato/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.focusNode,
  });

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  _AppTextInputState createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  String? validateField(String? text) {
    if (widget.keyboardType == TextInputType.phone) {
      return UtilValidator.validate(
        text!,
        type: ValidateType.phone,
      );
    }
    if (widget.keyboardType == TextInputType.emailAddress) {
      return UtilValidator.validate(
        text!,
        type: ValidateType.email,
      );
    }
    return null;
  }

  Widget? buildSuffixIcon() {
    if (widget.obscureText) {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
      );
    }
    if (widget.controller!.text.isNotEmpty) {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: () {
          widget.controller!.text = '';
        },
        child: Icon(Icons.clear),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        key: widget.fieldKey,
        controller: widget.controller,
        obscureText: obscureText,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        validator: validateField,
        onFieldSubmitted: widget.onFieldSubmitted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        onChanged: (text) {
          widget.onChanged!(text);
          setState(() {});
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          suffixIcon: buildSuffixIcon(),
          isDense: true,
        ),
      ),
    );
  }
}
