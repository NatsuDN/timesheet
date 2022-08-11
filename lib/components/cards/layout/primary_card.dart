// Rounded Corner ListItem
import 'package:flutter/material.dart';

import '../../../constants.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard(
      {required this.child,
      Key? key,
      this.height,
      this.width,
      this.margin,
      this.padding,
      this.fillColor,
      this.showBorder = true})
      : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? kAllSpaceSmall,
        padding: padding ?? kAllSpaceSmall,
        height: height,
        width: width,
        decoration: showBorder
            ? BoxDecoration(
                color: fillColor ?? kThemeFontColor,
                border: Border.all(color: kBorderColor, width: 2.0),
                // borderRadius: BorderRadius.circular(15.0),
              )
            : null,
        child: Container(child: child));
  }
}
