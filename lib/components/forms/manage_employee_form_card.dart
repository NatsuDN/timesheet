import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/forms/layout/primary_dropdown.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/components/forms/layout/primary_textformfield.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/holiday_type_provider.dart';
import '../../services/employees_data_controller.dart';
import '../../utils.dart';

class ManageEmployeeFormCard extends ConsumerWidget {
  ManageEmployeeFormCard({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  _onSubmit(ref, {required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      final holidayTypes = ref.watch(holidayTypeProvider);
      final holidayTypesName =
          ref.read(holidayTypeProvider.notifier).getHolidayTypeNames();
      var holidayTypeDropdownItems = [...holidayTypesName];
      var holidayIndex = holidayTypeDropdownItems.indexOf(holidayTypeCtrl.text);

      if (await registerEmployee(
          ref.watch(authControllerProvider).user!.company.id,
          passwordCtrl.text,
          firstNameCtrl.text,
          lastNameCtrl.text,
          nickNameCtrl.text,
          double.parse(leaveDaysEntitlementCtrl.text),
          double.parse(medicalFeesEntitlementCtrl.text),
          holidayTypes[holidayIndex].id,
          roleTypeCtrl.text.toUpperCase(),
          userNameCtrl.text,
          dateOfFirstDateCtrl.text,
          context: context)) {
        Navigator.pop(context);
      }
    }
  }

  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final nickNameCtrl = TextEditingController();
  final leaveDaysEntitlementCtrl = TextEditingController();
  final medicalFeesEntitlementCtrl = TextEditingController();
  final holidayTypeCtrl = TextEditingController();
  final roleTypeCtrl = TextEditingController(text: "Employee");
  final dateOfFirstDateCtrl = TextEditingController(text: '1990-01-01');

  final isoFirstDate =
      TextEditingController(text: DateTime.utc(1990, 1, 1).toIso8601String());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidayTypes = ref.watch(holidayTypeProvider);
    final holidayTypesName =
        ref.read(holidayTypeProvider.notifier).getHolidayTypeNames();
    var holidayTypeDropdownItems = [...holidayTypesName];
    holidayTypeCtrl.text = holidayTypeDropdownItems.first;

    DateTime? firstDate = DateTime.utc(1990, 1, 1);

    setBirthDate(DateTime? selectedFirstDate) {
      firstDate = selectedFirstDate;
    }

    return PrimaryFormCard(
        showBorder: false,
        formKey: _formKey,
        title: 'Add Employee',
        onSubmit: () {
          _onSubmit(ref, context: context);
        },
        submitLabel: 'Add',
        children: [
          PrimaryTextFormField(
              title: 'Username',
              controller: userNameCtrl,
              validator: userNameValidator()),
          PrimaryTextFormField(
              title: 'Password',
              controller: passwordCtrl,
              validator: passwordValidatior()),
          PrimaryTextFormField(
              title: 'First Name',
              controller: firstNameCtrl,
              validator: nameValidator()),
          PrimaryTextFormField(
              title: 'Last Name',
              controller: lastNameCtrl,
              validator: nameValidator()),
          PrimaryTextFormField(
              title: 'Nick Name',
              controller: nickNameCtrl,
              validator: nameValidator()),
          PrimaryTextFormField(
            validator: basicValidator(),
            title: 'Leave Days Entitlement',
            controller: leaveDaysEntitlementCtrl,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          PrimaryTextFormField(
            validator: basicValidator(),
            title: 'Medical Fees Entitlement',
            controller: medicalFeesEntitlementCtrl,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          PrimaryDropDown(
            title: 'Holiday Type',
            defaultValue: holidayTypeDropdownItems.first,
            items: holidayTypeDropdownItems,
            onChanged: (value) {
              holidayTypeCtrl.text = value;
            },
          ),
          PrimaryDropDown(
              title: 'Role',
              defaultValue: 'Employee',
              items: const ['Admin', 'Employee'],
              onChanged: (value) {
                roleTypeCtrl.text = value;
              }
          ),
          PrimaryTextFormField(
            title: 'First date',
            controller: dateOfFirstDateCtrl,
            validator: birthDateValidator(isoFirstDate),
            readOnly: true,
            onTap: () {
              showDatePicker(
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: kThemeColor, // header background color
                              onPrimary: kThemeFontColor, // header text color
                              onSurface: kPrimaryFontColor, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: kThemeColor, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2050),
                      initialDatePickerMode: DatePickerMode.year)
                  .then((value) {
                if (value != null) {
                  firstDate = value;
                  setBirthDate(value);
                  dateOfFirstDateCtrl.text = getFormatDate(firstDate!);
                  isoFirstDate.text = firstDate!.toIso8601String();
                  log('FirstDate: ${isoFirstDate.text}');
                }
              });
            },
          ),
        ]);
  }
}
