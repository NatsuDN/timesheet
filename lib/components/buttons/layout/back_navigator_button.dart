import 'package:flutter/material.dart';

import '../../../constants.dart';

class BackNavigatorButton extends StatelessWidget {
  const BackNavigatorButton({
    Key? key,
    this.color = kThemeFontColor,
    this.onPressed,
  }) : super(key: key);
  final Function()? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
            onPressed: () {
              onPressed?.call();
              Navigator.maybePop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: color,
              size: kBodyFontSize,
            ),
            label: Text('Back', style: kBody2TextStyle.copyWith(color: color))),
      ],
    );
  }
}
