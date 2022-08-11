import 'package:flutter/material.dart';
import 'package:timesheet/components/forms/register_organization_form_card.dart';
import 'package:timesheet/components/page_wrapper/authentication_page_wrapper.dart';

class RegisterOrganizationPage extends StatelessWidget {
  const RegisterOrganizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationPageWrapper(child: RegisterOrganizationFormCard());
  }
}
