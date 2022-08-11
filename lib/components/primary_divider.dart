import 'package:flutter/material.dart';

import '../constants.dart';

class PrimaryDivider extends StatelessWidget {
  const PrimaryDivider(
      {Key? key, this.indent, this.thickness, this.endIndent, this.height})
      : super(key: key);
  final double? indent;
  final double? thickness;
  final double? endIndent;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kBorderColor,
      thickness: 1,
      height: height,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
