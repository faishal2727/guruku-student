import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.marginBottom = 0,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.enabled = true,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    required this.hintText,
    this.maxLines = 1,
    required this.lable,
  });

  final double marginBottom;
  final String labelText;
  final String hintText;
  final bool enabled;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final Widget? suffixIcon;
  final int? maxLines;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: AppTextStyle.body3.setSemiBold(),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            enabled: enabled,
            maxLines: maxLines,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: pr13),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: pr13),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
