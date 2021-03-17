import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';

import '../app.export.dart';
import 'math_utils.dart';

class CommonTextfield extends StatefulWidget {
  final TextFieldOption textOption;
  final Function(String text) textCallback;
  final VoidCallback tapCallback;
  final VoidCallback onNextPress;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final bool showUnderLine;
  final bool enable;
  final bool autoFocus;
  final bool autoCorrect;
  final bool alignment;
  final Function(String text) validation;
  TextStyle hintStyleText;

  CommonTextfield(
      {@required this.textOption,
      @required this.textCallback,
      this.tapCallback,
      this.onNextPress,
      this.inputAction,
      this.autoFocus,
      this.focusNode,
      this.alignment,
      this.showUnderLine = true,
      this.enable = true,
      this.validation,
      this.autoCorrect = true,
      this.hintStyleText});

  @override
  _CommonTextfieldState createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  bool obscureText = false;
  IconData obscureIcon = Icons.visibility;

  @override
  void initState() {
    super.initState();

    obscureText = widget.textOption.isSecureTextField ?? false;
  }

  @override
  void didUpdateWidget(CommonTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(widget.focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        textAlignVertical: TextAlignVertical(y: -1),
        autocorrect: widget.autoCorrect,
        enabled: widget.enable,
        maxLines: widget.textOption.maxLine,
        textInputAction: widget.inputAction ?? TextInputAction.done,
        focusNode: widget.focusNode ?? null,
        autofocus: widget.autoFocus ?? false,
        controller: widget.textOption.inputController ?? null,
        obscureText: this.obscureText,
        //onTap: _requestFocus,
        style: appTheme.getLabelStyle,
        keyboardType: widget.textOption.keyboardType ?? TextInputType.text,
        cursorColor: appTheme.colorPrimary,
        inputFormatters: widget.textOption.formatter ?? [],
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabledBorder: widget.showUnderLine == true
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme.dividerColor))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: widget.showUnderLine == true
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                  color: appTheme.textBlackColor,
                  width: getSize(1.2),
                ))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
          labelText: widget.textOption.hintText,
          hintStyle: widget.textOption.hintStyleText ??=
              appTheme.getHintTextCommonTextStyle,
          contentPadding: EdgeInsets.only(
            top: getSize(4),
          ),

//          hintText: widget.textOption.hintText,
          labelStyle: appTheme.getLabelStyle,
          prefixIcon: widget.textOption.prefixWid,
          suffix: widget.textOption.postfixWidOnFocus,
          suffixIcon: (widget.textOption.isSecureTextField != null &&
                  widget.textOption.isSecureTextField)
              ? IconButton(
                  icon: Icon(
                    obscureIcon,
                    color: appTheme.colorPrimary,
                  ),
                  onPressed: () {
                    setState(() {
                      this.obscureText = !this.obscureText;

                      if (this.obscureText) {
                        this.obscureIcon = Icons.visibility;
                      } else {
                        this.obscureIcon = Icons.visibility_off;
                      }
                      if (!widget.focusNode.hasPrimaryFocus)
                        widget.focusNode.canRequestFocus = false;
                      widget.focusNode.unfocus();
                    });
                    //TextInputConnection;
                  },
                )
              : widget.textOption.type == TextFieldType.DropDown
                  ? Container()
                  : widget.textOption.postfixWid,
        ),
        /*onSubmitted: (String text) {
          this.widget.textCallback(text);
          FocusScope.of(context).unfocus();
          if (widget.onNextPress != null) {
            widget.onNextPress();
          }
        },*/
        onFieldSubmitted: (String text) {
          this.widget.textCallback(text);
          FocusScope.of(context).unfocus();
          if (widget.onNextPress != null) {
            widget.onNextPress();
          }
        },
        validator: widget.validation,
        onChanged: (String text) {
          this.widget.textCallback(text);
        },
        onEditingComplete: () {
          this.widget.textCallback(widget.textOption.inputController.text);
        },
      ),
    );
  }
}

class TextFieldOption {
  String text = "";
  String labelText;
  String hintText;
  bool isSecureTextField = false;
  TextInputType keyboardType;
  TextFieldType type;
  int maxLine;
  TextStyle hintStyleText;
  Widget prefixWid;
  Widget postfixWidOnFocus;
  Widget postfixWid;
  bool autoFocus;
  Color fillColor;
  InputBorder errorBorder;
  List<TextInputFormatter> formatter;
  TextEditingController inputController;

  TextFieldOption(
      {this.text,
      this.labelText,
      this.hintText,
      this.isSecureTextField,
      this.keyboardType,
      this.type,
      this.maxLine = 1,
      this.autoFocus,
      this.formatter,
      this.hintStyleText,
      this.inputController,
      this.prefixWid,
      this.postfixWidOnFocus,
      this.fillColor,
      this.postfixWid,
      this.errorBorder});
}

enum TextFieldType {
  Normal,
  DropDown,
}
