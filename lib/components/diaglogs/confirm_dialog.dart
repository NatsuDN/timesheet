// Write Confirm Dialog

import 'package:flutter/material.dart';
import 'package:timesheet/components/buttons/layout/secondary_button.dart';

showConfirmDialog(context, {required children, required title}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //this right here
          title: Text('Confirm'),
          content: Text('Are you sure you want to $title?'),
          actions: <Widget>[
            SecondaryButton(
              text: 'Cancle',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SecondaryButton(
              text: 'Confirm',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
