import 'package:flutter/material.dart';
import 'package:timesheet/components/forms/login_form_card.dart';
import 'package:timesheet/components/page_wrapper/authentication_page_wrapper.dart';
import 'package:timesheet/components/page_wrapper/layout/primary_scaffold.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationPageWrapper(child: LoginFormCard());
  }
}
