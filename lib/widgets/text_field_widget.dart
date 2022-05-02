
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {

  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
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

  get value=>this.value;

  const TextFormFieldWidget(
      {required this.hintText,
         this.controller,
        Key? key,
        this.filled=false,
        this.obscureText = false,
        this.noneEnableBorder=true,
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
    const colorBlack = Colors.black;
    return Theme(
      data: theme,
      child: TextFormField(
        maxLength: maxLength,
        cursorColor: theme.primaryColor,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: textInputType,
        textInputAction: actionKeyboard,
        focusNode: focusNode,
        style: const TextStyle(
          color: colorBlack,
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


          enabledBorder:  noneEnableBorder ?OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ):null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          contentPadding: const EdgeInsets.only(
              top: 12, bottom: 12, left: 8.0, right: 8.0),
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










