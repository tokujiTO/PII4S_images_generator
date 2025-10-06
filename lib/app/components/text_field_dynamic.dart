import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final bool isPassword;
  final void Function()? onSuffixIconTap;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.hintText,
    this.isPassword = false,
    this.maxLines = 1,
    this.minLines,
    this.fillColor,
    this.onSuffixIconTap, // Renomeado
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      // REMOVIDO: onTap daqui (não pertence mais ao TextField inteiro)
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColors.gray,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.gray.withAlpha((0.6 * 255).toInt()),
          fontSize: 14,
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
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
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).primaryColor.withAlpha((0.3 * 255).toInt()),
            width: 2,
          ),
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
