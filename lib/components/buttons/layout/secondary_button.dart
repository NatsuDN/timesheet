// OutlinedButton

import 'package:flutter/material.dart';
import '../../../constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key, required this.text, this.onPressed, this.color = kThemeColor})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: kPrimaryFontColor,
          // backgroundColor: w,
          textStyle: kBody2TextStyle.copyWith(
            color: color,
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: kBody2TextStyle.copyWith(color: color)));
  }
}
