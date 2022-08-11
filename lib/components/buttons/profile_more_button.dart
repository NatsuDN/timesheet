// OutlinedButton

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/components/forms/change_password_form_card.dart';
import 'package:timesheet/components/forms/create_medical_request_form_card.dart';
import 'package:timesheet/providers/auth_provider.dart';

import '../forms/create_leave_request_form_card.dart';

enum ProfileMenu { addMedicalRequest, addLeaveRequest, changePassword, logOut }

class ProfileMoreButton extends ConsumerStatefulWidget {
  const ProfileMoreButton({
    Key? key,
    this.onDialogClosed,
  }) : super(key: key);
  final Function()? onDialogClosed;

  @override
  _ProfileMoreButtonState createState() => _ProfileMoreButtonState();
}

class _ProfileMoreButtonState extends ConsumerState<ProfileMoreButton> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ProfileMenu>(

        // Callback that sets the selected popup menu item.
        onSelected: (ProfileMenu item) async {
          setState(() {
            _selectedMenu = item.name;
          });
          if (item == ProfileMenu.addMedicalRequest) {
            await showPrimaryDialog(context,
                children: [CreateMedicalRequestFormCard()]);
            widget.onDialogClosed?.call();
          } else if (item == ProfileMenu.addLeaveRequest) {
            await showPrimaryDialog(context,
                children: [CreateLeaveRequestFormCard()]);
            widget.onDialogClosed?.call();
          } else if (item == ProfileMenu.changePassword) {
            await showPrimaryDialog(context,
                children: [ChangePasswordFormCard()]);
            widget.onDialogClosed?.call();
          } else if (item == ProfileMenu.logOut) {
            ref.read(authControllerProvider.notifier).logOut();
          }
        },
        itemBuilder: (BuildContext menuItemContext) =>
            <PopupMenuEntry<ProfileMenu>>[
              const PopupMenuItem<ProfileMenu>(
                value: ProfileMenu.addMedicalRequest,
                child: Text('Add Medical Request'),
              ),
              const PopupMenuItem<ProfileMenu>(
                value: ProfileMenu.addLeaveRequest,
                child: Text('Add Leave Request'),
              ),
              const PopupMenuItem<ProfileMenu>(
                value: ProfileMenu.changePassword,
                child: Text('Change Password'),
              ),
              const PopupMenuItem<ProfileMenu>(
                value: ProfileMenu.logOut,
                child: Text('Log Out'),
              ),
            ]);
  }
}
