import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/components/forms/layout/primary_textformfield.dart';
import 'package:timesheet/router/route_utils.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../router/route_utils.dart';
import '../../utils.dart';
import '../buttons/layout/alternate_link_button.dart';

class LoginFormCard extends ConsumerWidget {
  LoginFormCard({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  _onSubmit(ref, {required BuildContext context}) async {
    // print(User.fromJson(json.decode(json.encode(User.mockUp().toJson())))
    //     .toJson());
    if (_formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).logIn(
          employeeController.text, passwordController.text,
          context: context);
    }
  }

  final employeeController = TextEditingController(text: 'adminuser');
  final passwordController = TextEditingController(text: '123456789');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: kVerticalSpaceMedium,
          child: SizedBox(
            width: 196,
            height: 158,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        PrimaryFormCard(
            width: k50Width(context),
            formKey: _formKey,
            title: 'Login',
            titleTextStyle: kBigHeaderTextStyle,
            titleSpacing: kVerticalSpaceXXLarge,
            onSubmit: () {
              _onSubmit(ref, context: context);
            },
            submitLabel: 'Log In',
            alternateLinkButton: AlternateLinkButton(
                title: 'Don\'t have company yet?',
                linkName: 'Register',
                onPressed: () {
                  context.go(AppPage.register.toRouteName);
                }),
            children: [
              Padding(
                padding: kTopHorizontalSpaceMedium,
                child: PrimaryTextFormField(
                  title: 'Username',
                  controller: employeeController,
                  // validator: userNameValidator(),
                ),
              ),
              Padding(
                padding: kTopHorizontalSpaceMedium,
                child: PrimaryTextFormField(
                    title: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: passwordValidatior()),
              ),
            ]),
      ],
    );
  }
}
