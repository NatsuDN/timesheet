import 'package:flutter/material.dart';
import 'package:timesheet/screens/employees_data_grid_page/employees_datagrid_page.dart';

import '../../constants.dart';

class EmployeesDataTabBar extends StatefulWidget {
  const EmployeesDataTabBar({Key? key, required this.onTabChanged})
      : super(key: key);
  final Function(EmployeesDataGridPageTab) onTabChanged;
  @override
  State<EmployeesDataTabBar> createState() => _EmployeesDataTabBarState();
}

class _EmployeesDataTabBarState extends State<EmployeesDataTabBar> {
  List<bool> isSelected = [true, false, false, false, false];
  final List<String> tabTitles = [
    'Overview',
    'Time Sheets',
    'Leave Days',
    'Medical Fees',
    'Medical Requests'
  ];
  final List<EmployeesDataGridPageTab> tab = [
    EmployeesDataGridPageTab.overview,
    EmployeesDataGridPageTab.timeSheets,
    EmployeesDataGridPageTab.leaveDays,
    EmployeesDataGridPageTab.medicalFees,
    EmployeesDataGridPageTab.medicalRequests
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kXXXLarge,
      color: kThemeSecondaryBackgroundColor,
      child: Padding(
        padding: kAllSpaceSuperSmall,
        child: ToggleButtons(
          selectedColor: Colors.black,
          fillColor: kThemeFontColor,
          color: Colors.grey,
          renderBorder: false,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
            widget.onTabChanged(tab[index]);
          },
          isSelected: isSelected,
          children: <Widget>[
            for (int i = 0; i < tabTitles.length; i++)
              Container(child: Center(child: Text(tabTitles[i])), width: 120),
          ],
        ),
      ),
    );
  }
}
