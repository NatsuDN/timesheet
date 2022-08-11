// OutlinedButton

import 'package:flutter/material.dart';
import '../../../constants.dart';

class IconSecondaryButton extends StatelessWidget {
  const IconSecondaryButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.color = kThemeColor,
      required this.icon})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  final Color color;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(text, style: kBody2TextStyle.copyWith(color: color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        primary: kPrimaryFontColor,
        // backgroundColor: w,
        textStyle: kBody2TextStyle.copyWith(
          color: color,
        ),
      ),
    );
  }
}
