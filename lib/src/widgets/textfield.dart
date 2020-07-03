import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/textfields.dart';

class AppTextField extends StatelessWidget {
  final bool isIOS;
  final String hintText;
  final IconData materialIcon;
  final IconData cupertinoIcon;
  final TextInputType textInputType;
  final bool obscureText;

  AppTextField({
    @required this.isIOS,
    @required this.hintText,
    @required this.materialIcon,
    @required this.cupertinoIcon,
    this.textInputType,
    this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS){
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: TextFieldStyles.textBoxHorizontal, 
                  vertical: TextFieldStyles.textBoxVertical),
              child: CupertinoTextField(
                keyboardType: (textInputType != null) ? textInputType : TextInputType.text,
                padding: EdgeInsets.all(13.0),
                placeholder: hintText,
                placeholderStyle: TextFieldStyles.placeholder,
                style: TextFieldStyles.text,
                textAlign: TextFieldStyles.textAlign,
                cursorColor: TextFieldStyles.cursorColor,
                decoration: TextFieldStyles.cupertinoDecoration,
                prefix: TextFieldStyles.iconPrefix(cupertinoIcon),
                obscureText: (obscureText != null) ? obscureText : false,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: TextFieldStyles.textBoxHorizontal, 
                  vertical: TextFieldStyles.textBoxVertical),
              child: TextField(
                keyboardType: (textInputType != null) ? textInputType : TextInputType.text,
                cursorColor: TextFieldStyles.cursorColor,
                style: TextFieldStyles.text,
                textAlign: TextFieldStyles.textAlign,
                decoration: TextFieldStyles.materialDecoration(hintText, materialIcon),
                obscureText: (obscureText != null) ? obscureText : false,
              ),
            );
          }
  }
}