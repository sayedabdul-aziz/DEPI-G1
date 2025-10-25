import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final bool readOnly;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      validator: validator,
      inputFormatters: inputFormatters,
      onTap: onTap,
    );
  }
}
