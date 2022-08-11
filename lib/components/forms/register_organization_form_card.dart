import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../router/route_utils.dart';
import '../../utils.dart';
import '../buttons/layout/alternate_link_button.dart';
import 'layout/primary_textformfield.dart';

class RegisterOrganizationFormCard extends ConsumerWidget {
  RegisterOrganizationFormCard({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final companyNameThController = TextEditingController(text: 'เทส');
  final companyNameEngController = TextEditingController(text: 'Test Company');
  final companyNameShortController = TextEditingController(text: 'TEST');
  final companyAddressController = TextEditingController(text: 'abc');
  final companyPicController = TextEditingController(text: 'imgUrl');
  final adminNickNameController = TextEditingController(text: 'Jo');
  final adminPasswordController = TextEditingController(text: '123456');
  final adminFirstnameController = TextEditingController(text: 'John');
  final adminLastnameController = TextEditingController(text: 'Doe');
  final adminUsernameController = TextEditingController(text: 'johndoe');

  _onSubmit(ref, {required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).signUpOrganization(
          adminUsernameController.text,
          adminPasswordController.text,
          companyNameThController.text,
          companyNameEngController.text,
          companyNameShortController.text,
          companyAddressController.text,
          companyPicController.text,
          adminFirstnameController.text,
          adminLastnameController.text,
          adminNickNameController.text,
          context: context);
    }
  }

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
            title: 'Register Organization',
            titleTextStyle: kBigHeaderTextStyle,
            titleSpacing: kVerticalSpaceXXLarge,
            onSubmit: () {
              _onSubmit(ref, context: context);
            },
            submitLabel: 'Sign up',
            alternateLinkButton: AlternateLinkButton(
                title: 'Already have account?',
                linkName: 'Log in',
                onPressed: () {
                  context.go(AppPage.login.toRouteName);
                }),
            children: [
              Padding(
                padding: kBottomSpaceMedium,
                child: Text("Company section", style: kHeader1TextStyle),
              ),
              Row(
                children: [
                  Expanded(
                      child: PrimaryTextFormField(
                    title: 'Name (English)',
                    controller: companyNameEngController,
                    validator: basicValidator(),
                  )),
                  Expanded(
                      child: PrimaryTextFormField(
                    title: 'Name (Thai)',
                    controller: companyNameThController,
                    validator: basicValidator(),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: PrimaryTextFormField(
                    title: 'Name (Short)',
                    controller: companyNameShortController,
                    validator: basicValidator(),
                  )),
                  Expanded(
                      child: PrimaryTextFormField(
                    title: 'Picture',
                    controller: companyPicController,
                    validator: basicValidator(),
                  )),
                ],
              ),
              PrimaryTextFormField(
                title: 'Address',
                controller: companyAddressController,
                validator: basicValidator(),
              ),
              Padding(
                padding: kVerticalSpaceMedium,
                child: Text("Admin section", style: kHeader1TextStyle),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: PrimaryTextFormField(
                        title: 'Firstname',
                        controller: adminFirstnameController,
                        validator: nameValidator()),
                  ),
                  Expanded(
                    flex: 3,
                    child: PrimaryTextFormField(
                        title: 'Lastname',
                        controller: adminLastnameController,
                        validator: nameValidator()),
                  ),
                  Expanded(
                      flex: 1,
                      child: PrimaryTextFormField(
                        title: 'Nickname',
                        controller: adminNickNameController,
                        validator: nameValidator(),
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: PrimaryTextFormField(
                    title: 'Username',
                    controller: adminUsernameController,
                    validator: userNameValidator(),
                  )),
                  Expanded(
                      child: PrimaryTextFormField(
                    title: 'Password',
                    obscureText: true,
                    controller: adminPasswordController,
                    validator: passwordValidatior(),
                  )),
                ],
              ),
            ]),
      ],
    );
  }
}
