import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/colors.dart';
// import '../styles/icon_broken.dart';

Widget defaultButton({
  double? width,
  double height = 40,
  bool isUpperCase = true,
  double radius = 20,
  BuildContext? context,
  required Function function,
  required String text,
}) => Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed: () {
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(color: Colors.white),
    ),
  ),
  decoration: BoxDecoration(
    color: AppColors.sidebar,
    borderRadius: BorderRadius.circular(radius),
  ),
);

Widget defaultTextButton({
  required Function function,
  required String text,
  // Color? color = defaultColor,
  double? size = 18.0,
}) => TextButton(
  onPressed: () {
    function();
  },
  child: Text(style: TextStyle(fontSize: size), text.toString()),
);

class defaultFormField extends StatelessWidget {
  final BuildContext context;
  final bool isClickable = true;
  final TextInputType type;
  final TextEditingController controller;
  final dynamic label;
  final String? hintText;
  final String? errorText;
  final TextDirection? textDirection;
  final IconData? prefix;
  final Widget? textFormFieldIcon;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final Function()? onTap;
  final String? Function(String?) validate;
  final bool isPassword;
  final bool? enabled;
  final IconData? suffix;
  final Function()? suffixPressed;
  final BoxConstraints? constraints;
  final TextAlign? textAlign;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final double radius;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final String? prefixText;
  final Color? filledColor;
  final Color? cursorColor;
  final Color outsideColor;

  const defaultFormField({
    super.key,
    required this.context,
    required this.controller,
    required this.validate,
    // this.radius,
    this.radius = 0.0,
    this.focusNode,
    this.textDirection,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.label,
    this.textFormFieldIcon,
    this.autofocus = false,
    this.prefix,
    this.initialValue,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.enabled,
    this.suffix,
    this.suffixPressed,
    this.constraints,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.hintText,
    this.isPassword = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.words,
    t,
    required this.type,
    this.borderColor = Colors.black,
    this.textColor = Colors.black,
    this.height = 60,
    this.prefixText,
    this.filledColor,
    this.cursorColor,
    required this.outsideColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textDirection: textDirection,
      textAlign: textAlign!,
      onFieldSubmitted: onSubmit,
      enabled: isClickable,
      autofocus: autofocus,
      onChanged: onChange,
      focusNode: focusNode,
      onTap: onTap,
      // maxLines: maxLines,
      validator: validate,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      textAlignVertical: TextAlignVertical.center,
      initialValue: initialValue,
      cursorColor: cursorColor,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        filled: true,
        fillColor: filledColor,
        hintText: hintText,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: prefixText,
        // prefixStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(width: 0, color: outsideColor),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, color: textColor),
        prefixIcon: Icon(prefix),

        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix),
              )
            : null,
      ),
    );
  }
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) {
    return false;
  },
);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget MultipleChoice({
  required String title,
  double? radius = 7.0,
  Color? textColor = Colors.grey,
  Color? borderColor = Colors.grey,
  Color? iconColor = Colors.grey,
  Function? function,
}) => Container(
  height: 60,
  decoration: BoxDecoration(
    border: Border.all(color: borderColor ?? Colors.grey),
    borderRadius: BorderRadius.circular(radius!),
  ),
  width: double.infinity,
  child: Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(title, style: TextStyle(color: textColor)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: iconColor,
          size: 30,
        ),
      ),
    ],
  ),
);

double calculateTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.width;
}

Widget settingSection({
  required String label,
  required IconData icon,
  Function? function,
}) => GestureDetector(
  onTap: () {
    function!();
  },
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      // Icon(IconBroken.Arrow___Right_2, color: Colors.white,)
    ],
  ),
);
