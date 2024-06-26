import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/app_border_radius.dart';
import '../../config/app_size_config.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String labelText;
  final String? errorText;
  final Widget? icon;
  final bool? obscureText;
  final Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final Function(String? value)? onChanged;
  final FocusNode? focusNode;
  final int? maxlength;
  final List<TextInputFormatter>? inputformatter;
  final Color? errorColor;
  final String? prefixText;
  final String? suffixText;
  final int? maxLines;
  final EdgeInsetsGeometry? contentpadding;
  const CustomTextField({
    required this.textEditingController,
    this.validator,
    this.readOnly,
    required this.labelText,
    this.icon,
    this.obscureText,
    this.onTap,
    this.onTapOutside,
    this.focusNode,
    this.keyboardType,
    this.maxlength,
    this.inputformatter,
    this.errorText,
    this.errorColor,
    this.onChanged,
    this.prefixText,
    this.suffixText,
    this.maxLines = 1,
    this.contentpadding,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    HeightWidth(context);
    return TextFormField(
      onTapOutside: onTapOutside,
      maxLines: maxLines,
      maxLength: maxlength,
      inputFormatters: inputformatter,
      keyboardType: keyboardType,
      controller: textEditingController,
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText ?? false,
      cursorColor: theme.onPrimary,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixText: prefixText,
        suffixText: suffixText,
        prefixStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: theme.onPrimary),
        suffixStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: theme.onPrimary),
        contentPadding: contentpadding ?? const EdgeInsets.only(left: 15, right: 15, top: 5),
        isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor ?? Colors.transparent,
          ),
          borderRadius: AppBorderRadius.circularBorderNormal,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: AppBorderRadius.circularBorderNormal),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: AppBorderRadius.circularBorderNormal,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor ?? Colors.transparent,
          ),
          borderRadius: AppBorderRadius.circularBorderNormal,
        ),
        suffixIcon: IconButton(
          icon: icon ?? const SizedBox.shrink(),
          onPressed: onTap,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: AppBorderRadius.circularBorderNormal,
        ),
        fillColor: Colors.transparent,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 11,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: labelText,
        hintStyle: TextStyle(color: theme.onSecondary, fontSize: 16.0),
        filled: false,
        errorText: errorText,
      ),
    );
  }
}
