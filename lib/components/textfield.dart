import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class UiTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final bool readOnly;
  final Icon? suffixIcon;
  final Icon? preffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final List<String>? autoFillHints;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmit;
  final void Function(String?)? onChange;
  final void Function()? onTap;
  final Widget? label;

  final Color? borderColor;
  final TextStyle? hintStyle;
  const UiTextField({
    Key? key,
    this.focusNode,
    this.onTap,
    this.label,
    this.controller,
    this.preffixIcon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.onSubmit,
    this.onChange,
    this.hintText,
    this.suffixIcon,
    this.borderColor,
    this.autoFillHints,
    this.hintStyle,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        enabled: true,
        toolbarOptions:
            ToolbarOptions(paste: true, copy: true, selectAll: true),
        focusNode: focusNode,
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        autofillHints: autoFillHints,
        validator: validator,
        decoration: InputDecoration(
          label: label,
          suffixIcon: suffixIcon,
          prefixIcon: preffixIcon,
          isCollapsed: false,
          isDense: false,
          contentPadding: EdgeInsets.only(left: 20),
          filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyles.bodySm.copyWith(
                color: Color(0xFFAEAEAE),
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade100),
          ),
        ),
      ),
    );
  }
}

class UiTextBoxField extends StatelessWidget {
  final FocusNode? focusNode;
  final bool readOnly;
  final Icon? suffixIcon;
  final Icon? preffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final List<String>? autoFillHints;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmit;
  final void Function(String?)? onChange;
  final void Function()? onTap;
  final Widget? label;

  final Color? borderColor;
  final TextStyle? hintStyle;
  const UiTextBoxField({
    Key? key,
    this.focusNode,
    this.onTap,
    this.label,
    this.controller,
    this.preffixIcon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.onSubmit,
    this.onChange,
    this.hintText,
    this.suffixIcon,
    this.borderColor,
    this.autoFillHints,
    this.hintStyle,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        maxLines: 5,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        enabled: true,
        toolbarOptions:
            ToolbarOptions(paste: true, copy: true, selectAll: true),
        focusNode: focusNode,
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        autofillHints: autoFillHints,
        validator: validator,
        decoration: InputDecoration(
          label: label,
          suffixIcon: suffixIcon,
          prefixIcon: preffixIcon,
          isCollapsed: false,
          isDense: false,
          contentPadding: EdgeInsets.only(left: 20, top: 20),
          filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyles.bodySm.copyWith(
                color: Color(0xFFAEAEAE),
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade100),
          ),
        ),
      ),
    );
  }
}

class UiPasswordTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final List<String>? autoFillHints;
  final String? Function(String?)? validator;
  const UiPasswordTextField({
    Key? key,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.autoFillHints,
    this.validator,
  }) : super(key: key);

  @override
  __UiPasswordTextFieldState createState() => __UiPasswordTextFieldState();
}

class __UiPasswordTextFieldState extends State<UiPasswordTextField> {
  bool passwordVisible = false;
  bool _obsureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  padding: EdgeInsets.all(20),
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: _obsureText,
        obscuringCharacter: "*",
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        autofillHints: widget.autoFillHints,
        validator: widget.validator,
        decoration: InputDecoration(
          suffixIcon: _obsureText
              ? IconButton(
                  icon: Icon(Icons.visibility_off_rounded),
                  onPressed: () {
                    setState(() => _obsureText = false);
                  })
              : IconButton(
                  icon: Icon(Icons.visibility_rounded),
                  onPressed: () {
                    setState(() => _obsureText = true);
                  },
                ),
          contentPadding: EdgeInsets.only(left: 20),
          filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: widget.hintText,
          errorStyle: TextStyles.bodySm,
          hintStyle: TextStyles.bodySm.copyWith(
            color: Color(0xFFAEAEAE),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.3),
          ),
        ),
      ),
    );
  }
}
