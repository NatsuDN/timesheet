import 'package:flutter/material.dart';
import 'package:timesheet/constants.dart';

class PrimaryCheckBoxField extends StatefulWidget {
  PrimaryCheckBoxField({Key? key}) : super(key: key);

  @override
  State<PrimaryCheckBoxField> createState() => _PrimaryCheckBoxFieldState();
}

class _PrimaryCheckBoxFieldState extends State<PrimaryCheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('CheckBox Field'),
    );
  }
}
