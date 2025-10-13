import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class CustomTextAIField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final bool isPassword;
  final void Function()? onFocus;
  final void Function()? onSuffixIconTap;

  const CustomTextAIField({
    super.key,
    required this.controller,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.hintText,
    this.isPassword = false,
    this.maxLines = 1,
    this.minLines,
    this.fillColor,
    this.onFocus,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      onTap: () {
        Navigator.pushNamed(context, "/chat");
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.white.withAlpha((0.6 * 255).toInt()),
          fontSize: 18,
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 30,
        ),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIconTap, // Tap apenas no suffixIcon
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: suffixIcon,
                ),
              )
            : null,
        filled: true,
        fillColor: fillColor ?? AppColors.gray.withAlpha((0.08 * 255).toInt()),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 2),
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 2),
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 2),
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        color: AppColors.gray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
