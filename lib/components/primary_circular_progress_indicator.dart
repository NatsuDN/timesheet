import 'package:flutter/material.dart';

import '../constants.dart';

class PrimaryCircularProgressIndicator extends StatelessWidget {
  const PrimaryCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: kHeaderFontColor,
    );
  }
}
