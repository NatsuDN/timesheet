import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/forms/layout/primary_dropdown.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/components/forms/layout/primary_textformfield.dart';
import 'package:timesheet/domains/employee.dart';
import 'package:timesheet/providers/auth_provider.dart';
import 'package:timesheet/services/employees_data_controller.dart';

import '../../providers/holiday_type_provider.dart';
import '../../utils.dart';

class UpdateEmployeeFormCard extends ConsumerWidget {
  UpdateEmployeeFormCard(
      {Key? key, required this.employee, required this.empId})
      : super(key: key);
  final Employee employee;
  final String empId;
  final _formKey = GlobalKey<FormState>();
  _onSubmit(ref, {required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      final holidayTypes = ref.watch(holidayTypeProvider);
      final holidayTypesName =
          ref.read(holidayTypeProvider.notifier).getHolidayTypeNames();
      var holidayTypeDropdownItems = [...holidayTypesName];
      var holidayIndex = holidayTypeDropdownItems.indexOf(holidayTypeCtrl.text);
      ;
      if (await updateUserProfile(
          empId,
          firstNameCtrl.text,
          lastNameCtrl.text,
          nickNameCtrl.text,
          double.parse(leaveDaysEntitlementCtrl.text),
          double.parse(medicalFeesEntitlementCtrl.text),
          holidayTypes[holidayIndex].id,
          roleTypeCtrl.text.toUpperCase(),
          context: context)) {
        ref.read(authControllerProvider.notifier).deleteUserCache();
        Navigator.pop(context);
      }
    }
  }

  late TextEditingController firstNameCtrl =
      TextEditingController(text: employee.firstName);
  late TextEditingController lastNameCtrl =
      TextEditingController(text: employee.lastName);
  late TextEditingController nickNameCtrl =
      TextEditingController(text: employee.nickName);
  late TextEditingController leaveDaysEntitlementCtrl =
      TextEditingController(text: employee.leaveDaysEntitlement.toString());
  late TextEditingController medicalFeesEntitlementCtrl =
      TextEditingController(text: employee.medicalFeesEntitlement.toString());
  late TextEditingController holidayTypeCtrl = TextEditingController();
  late TextEditingController roleTypeCtrl =
      TextEditingController(text: employee.role);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidayTypes = ref.watch(holidayTypeProvider);
    final holidayTypesName =
        ref.read(holidayTypeProvider.notifier).getHolidayTypeNames();
    var holidayTypeDropdownItems = [...holidayTypesName];
    var holidayId = employee.holidayType;
    var currentHolidayType =
        holidayTypes.firstWhere((holiday) => holiday.id == holidayId);
    holidayTypeCtrl.text = currentHolidayType.name;
    return PrimaryFormCard(
        showBorder: false,
        formKey: _formKey,
        title: 'Update Employee',
        onSubmit: () {
          _onSubmit(ref, context: context);
        },
        submitLabel: 'Update',
        children: [
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
            defaultValue: currentHolidayType.name,
            items: holidayTypeDropdownItems,
            onChanged: (value) {
              holidayTypeCtrl.text = value;
            },
          ),
          PrimaryDropDown(
              title: 'Role',
              defaultValue: getCapitalized(employee.role),
              items: const ['Admin', 'Employee'],
              onChanged: (value) {
                roleTypeCtrl.text = value;
              }),
        ]);
  }
}
