// OutlinedButton

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';

import 'package:timesheet/components/forms/login_form_card.dart';
import 'package:timesheet/components/forms/manage_employee_form_card.dart';
import '../../../constants.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class MoreButton extends StatefulWidget {
  const MoreButton({
    Key? key,
    this.onDialogClosed,
  }) : super(key: key);
  final Function()? onDialogClosed;

  @override
  State<MoreButton> createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(

        // Callback that sets the selected popup menu item.
        onSelected: (Menu item) async {
          setState(() {
            _selectedMenu = item.name;
          });
          if (item == Menu.itemOne) {
            await showPrimaryDialog(context,
                children: [ManageEmployeeFormCard()]);
          } else if (item == Menu.itemTwo) {
            log('itemTwo');
          } else if (item == Menu.itemThree) {
            log('itemThree');
          } else if (item == Menu.itemFour) {
            log('itemFour');
          }
        },
        itemBuilder: (BuildContext menuItemContext) => <PopupMenuEntry<Menu>>[
              PopupMenuItem<Menu>(
                value: Menu.itemOne,
                child: Text('Item 1'),
                onTap: () async {
                  log('hi');
                },
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemTwo,
                child: Text('Item 2'),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemThree,
                child: Text('Item 3'),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemFour,
                child: Text('Item 4'),
              ),
            ]);
  }
}
