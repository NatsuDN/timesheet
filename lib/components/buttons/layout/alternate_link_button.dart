import 'package:flutter/material.dart';

import '../../../constants.dart';

class AlternateLinkButton extends StatelessWidget {
  const AlternateLinkButton(
      {Key? key,
      required this.title,
      required this.linkName,
      required this.onPressed})
      : super(key: key);
  final String title;
  final String linkName;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: kBody2TextStyle,
        ),
        TextButton(
            style: TextButton.styleFrom(
              primary: kPrimaryFontColor,
            ),
            onPressed: onPressed,
            child: Text(linkName))
      ],
    );
  }
}
