import 'package:flutter/material.dart';
import 'package:timesheet/components/page_wrapper/layout/primary_scaffold.dart';
import 'package:timesheet/constants.dart';

class AuthenticationPageWrapper extends StatelessWidget {
  const AuthenticationPageWrapper({Key? key, required this.child})
      : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: k20Width(context)),
            child: child));
  }
}
