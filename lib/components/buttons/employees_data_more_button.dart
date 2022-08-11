// OutlinedButton

import 'package:flutter/material.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/components/forms/holiday_setting_form/holiday_setting_type_form_card.dart';
import 'package:timesheet/components/forms/manage_employee_form_card.dart';
import 'package:timesheet/domains/employee.dart';

import '../../domains/medical_request.dart';
import '../../services/employees_data_controller.dart';
import '../forms/manage_medical_request_form_card.dart';

enum EmployeesDataMenu { addEmployee, holidayTypeSetting, test1 }

class EmployeesDataMoreButton extends StatefulWidget {
  const EmployeesDataMoreButton({
    Key? key,
    this.onDialogClosed,
  }) : super(key: key);
  final Function()? onDialogClosed;

  @override
  State<EmployeesDataMoreButton> createState() =>
      _EmployeesDataMoreButtonState();
}

class _EmployeesDataMoreButtonState extends State<EmployeesDataMoreButton> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<EmployeesDataMenu>(

        // Callback that sets the selected popup menu item.
        onSelected: (EmployeesDataMenu item) async {
          setState(() {
            _selectedMenu = item.name;
          });
          if (item == EmployeesDataMenu.addEmployee) {
            await showPrimaryDialog(context,
                children: [ManageEmployeeFormCard()]);
            widget.onDialogClosed?.call();
          } else if (item == EmployeesDataMenu.holidayTypeSetting) {
            await showPrimaryDialog(context,
                children: [HolidaySettingTypeFormCard()]);
            widget.onDialogClosed?.call();
          } else if (item == EmployeesDataMenu.test1) {
            var medId = "ZHweOYIBa0CUUmxeDwGx";
            MedicalRequest medicalRequest =
                await getMedicalRequestDetails(medId, context: context);
            Employee employee =
                await getUserProfile(medicalRequest.empId, context: context);
            await showPrimaryDialog(context, children: [
              MedicalRequestFormCard(
                dialogType: MedicalRequestDialogType.approve,
                medicalRequest: medicalRequest,
                employee: employee,
              )
            ]);
          }
        },
        itemBuilder: (BuildContext menuItemContext) =>
            <PopupMenuEntry<EmployeesDataMenu>>[
              const PopupMenuItem<EmployeesDataMenu>(
                value: EmployeesDataMenu.addEmployee,
                child: Text('Add Employee'),
              ),
              const PopupMenuItem<EmployeesDataMenu>(
                value: EmployeesDataMenu.holidayTypeSetting,
                child: Text('Holiday Type Setting'),
              ),
            ]);
  }
}
