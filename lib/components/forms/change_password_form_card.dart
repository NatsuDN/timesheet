import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timesheet/components/buttons/layout/alternate_link_button.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/components/forms/layout/primary_textformfield.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/screens/register_oragnization_page.dart';

import '../../providers/auth_provider.dart';

class ChangePasswordFormCard extends ConsumerWidget {
  ChangePasswordFormCard({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  _onSubmit(ref) async {
    log('hi');
    await ref.read(authControllerProvider.notifier).logIn('aaa', 'bbb');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryFormCard(
        formKey: _formKey,
        title: 'Change Password',
        onSubmit: () => _onSubmit(ref),
        submitLabel: 'Submit',
        showBorder: false,
        children: [
          PrimaryTextFormField(title: 'Current Password', obscureText: true),
          PrimaryTextFormField(title: 'New Password', obscureText: true),
          PrimaryTextFormField(
              title: 'Confirm New Password', obscureText: true),
        ]);
  }
}
