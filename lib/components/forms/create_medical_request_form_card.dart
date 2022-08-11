import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/forms/layout/drag_and_drop_field.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';

import '../../providers/auth_provider.dart';
import '../../services/employees_data_controller.dart';
import 'layout/primary_textformfield.dart';

class CreateMedicalRequestFormCard extends ConsumerWidget {
  CreateMedicalRequestFormCard({Key? key}) : super(key: key);
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _onSubmit(ref, {required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      if (await createMedicalRequest(
          ref.watch(authControllerProvider).user!.employee.empCode,
          double.parse(_amountCtrl.text),
          _noteCtrl.text,
          "https://media.discordapp.net/attachments/995965611668672532/999254832718299216/unknown.png?width=960&height=411",
          context: context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryFormCard(
        showBorder: false,
        formKey: _formKey,
        title: 'Medical Request',
        onSubmit: () {
          _onSubmit(ref, context: context);
        },
        submitLabel: 'Create',
        children: [
          PrimaryTextFormField(
            title: 'Amount',
            controller: _amountCtrl,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            validator: (String? str) {
              if (str != null && str.isEmpty) {
                return "โปรดใส่จำนวนค่าใช้จ่าย";
              }
              return null;
            },
          ),
          PrimaryTextFormField(
            title: 'Note',
            controller: _noteCtrl,
            validator: (String? str) {
              if (str != null && str.isEmpty) {
                return "โปรดระบุรายละเอียด";
              }
              return null;
            },
          ),
          DragAndDropField(
            title: 'Attachment',
          )
        ]);
  }
}
