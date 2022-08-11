import 'package:flutter/material.dart';
import 'package:timesheet/components/page_wrapper/layout/primary_scaffold.dart';
import 'package:timesheet/constants.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: kXXXXLarge,
          height: kXXXXLarge,
        ),
      ),
    );
  }
}
