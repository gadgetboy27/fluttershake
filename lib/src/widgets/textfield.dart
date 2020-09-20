import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/text.dart';
import 'package:fluttershake/src/styles/textfields.dart';

class AppTextField extends StatefulWidget {
  final bool isIOS;
  final String hintText;
  final IconData materialIcon;
  final IconData cupertinoIcon;
  final TextInputType textInputType;
  final bool obscureText;
  final void Function(String) onChanged;
  final String errorText;
  final String initialText;

  AppTextField({
    @required this.isIOS,
    @required this.hintText,
    @required this.materialIcon,
    @required this.cupertinoIcon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
    this.initialText,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode _node;
  bool displayCuppertinoErrorBorder;
  TextEditingController _controller;

  @override
  void initState() {
    _node = FocusNode();
    _controller = TextEditingController();
    if (widget.initialText != null) _controller.text = widget.initialText;
    _node.addListener(_handleFocusChange);
    displayCuppertinoErrorBorder = false;
    super.initState();
  }

  void _handleFocusChange() {
    if (_node.hasFocus == false && widget.errorText != null) {
      displayCuppertinoErrorBorder = true;
    } else {
      displayCuppertinoErrorBorder = false;
    }
    //Tells Flutter that widget has changed state
    widget.onChanged(_controller.text);
  }

  @override
  void dispose() {
    _node.removeListener(_handleFocusChange);
    _node.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isIOS) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: TextFieldStyles.textBoxHorizontal,
            vertical: TextFieldStyles.textBoxVertical),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              keyboardType: widget.textInputType,
              padding: EdgeInsets.all(13.0),
              placeholder: widget.hintText,
              placeholderStyle: TextFieldStyles.placeholder,
              style: TextFieldStyles.text,
              textAlign: TextFieldStyles.textAlign,
              cursorColor: TextFieldStyles.cursorColor,
              decoration: (displayCuppertinoErrorBorder)
                  ? TextFieldStyles.cupertinoErrorDecoration
                  : TextFieldStyles.cupertinoDecoration,
              prefix: TextFieldStyles.iconPrefix(widget.cupertinoIcon),
              obscureText: widget.obscureText,
              onChanged: widget.onChanged,
              focusNode: _node,
              controller: _controller,
            ),
            (widget.errorText != null)
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.errorText,
                          style: TextStyles.error,
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: TextFieldStyles.textBoxHorizontal,
            vertical: TextFieldStyles.textBoxVertical),
        child: TextField(
          keyboardType: widget.textInputType,
          cursorColor: TextFieldStyles.cursorColor,
          style: TextFieldStyles.text,
          textAlign: TextFieldStyles.textAlign,
          decoration: TextFieldStyles.materialDecoration(
              widget.hintText, widget.materialIcon, widget.errorText),
          obscureText: widget.obscureText,
          controller: _controller,
          onChanged: widget.onChanged,
        ),
      );
    }
  }
}
