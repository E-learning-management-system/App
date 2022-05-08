
import 'package:flutter/material.dart';
import 'package:project/helpers/constants.dart';

class TextFormFieldWidget extends StatelessWidget {

  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final int maxLines;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String? value)? functionValidate;
  final String? Function(String? value)? funOnSubmitted;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final bool filled ;
  final int? maxLength;
  final Color? fillColor;
  final bool noneEnableBorder;
  final ValueChanged<String>? onChanged;


  const TextFormFieldWidget(
      {required this.hintText,
         this.controller,
        Key? key,
        this.filled=false,
        this.obscureText = false,
        this.noneEnableBorder=true,
        this.maxLines = 1,
        this.functionValidate,
        this.suffixIcon,
        this.focusNode,
        this.funOnSubmitted,
        this.textInputType,
        this.defaultText,
        this.parametersValidate,
        this.actionKeyboard = TextInputAction.next,
        this.maxLength ,
        this.fillColor,
        this.prefixIcon,
        this.onChanged,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme,
      child: TextFormField(
        maxLength: maxLength,
        cursorColor: theme.primaryColor,
        onChanged: onChanged,
        obscureText: obscureText,
        maxLines: maxLines,
        keyboardType: textInputType,
        textInputAction: actionKeyboard,
        focusNode: focusNode,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        initialValue: defaultText,
        onFieldSubmitted: funOnSubmitted,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          filled: filled,
          fillColor: fillColor,


          enabledBorder:  noneEnableBorder ?
          OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ):OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular
              (borderRadiusTxtField)
          ),
          focusedBorder:  noneEnableBorder ?
          OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          )  : OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular
              (borderRadiusTxtField)
        ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          contentPadding:  EdgeInsets.only(
              top: 12, bottom: noneEnableBorder?12:0, left: 8.0, right: 12.0),
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red,

          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),

          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        controller: controller,
        validator: functionValidate,


      ),
    );
  }
}










