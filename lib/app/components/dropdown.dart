import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String labelText;
  final String? hintText;
  final void Function(T?)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? focusBorder;
  final FocusNode? focusNode;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.labelText,
    this.value,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.focusBorder,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      focusNode: focusNode,
      initialValue: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.white,
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
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: suffixIcon,
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
          borderSide: const BorderSide(color: AppColors.white, width: 2),
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusBorder ?? AppColors.blue,
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
      dropdownColor: AppColors.background,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      iconEnabledColor: AppColors.white,
      iconDisabledColor: AppColors.gray,
    );
  }
}
