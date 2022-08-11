import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/components/forms/layout/primary_textformfield.dart';
import 'package:timesheet/domains/employee.dart';
import 'package:timesheet/services/employees_data_controller.dart';

import '../../constants.dart';
import '../../domains/medical_request.dart';
import '../../utils.dart';
import '../buttons/layout/alternate_link_button.dart';

enum MedicalRequestDialogType { approve, view }

class MedicalRequestFormCard extends ConsumerWidget {
  MedicalRequestFormCard(
      {Key? key,
      required this.dialogType,
      required this.medicalRequest,
      required this.employee})
      : super(key: key);
  final MedicalRequestDialogType dialogType;
  final MedicalRequest medicalRequest;
  final Employee employee;
  final _formKey = GlobalKey<FormState>();

  _onSubmit(ref, {required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      if (dialogType == MedicalRequestDialogType.approve) {
        if (await updateMedicalRequestsStatus(medicalRequest.id, "APPROVE",
            context: context)) {
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
      }
    }
  }

  late final TextEditingController _amountCtrl =
      TextEditingController(text: medicalRequest.amount.toString());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryFormCard(
      showBorder: false,
      formKey: _formKey,
      title: 'Medical Request',
      onSubmit: () {
        _onSubmit(ref, context: context);
      },
      crossAxisAlignment: CrossAxisAlignment.start,
      submitLabel:
          dialogType == MedicalRequestDialogType.view ? 'Done' : 'Approve',
      alternateLinkButton: dialogType == MedicalRequestDialogType.view
          ? null
          : AlternateLinkButton(
              title: '',
              linkName: 'Reject',
              onPressed: () async {
                if (await updateMedicalRequestsStatus(
                    medicalRequest.id, "NOTAPPROVE",
                    context: context)) {
                  Navigator.pop(context);
                }
              }),
      children: [
        PrimaryTextFormField(
          title: "Date",
          readOnly: true,
          initialValue: '${getFormatDateWithTime(medicalRequest.date)}',
        ),
        PrimaryTextFormField(
          title: 'Name',
          readOnly: true,
          initialValue: employee.fullName,
        ),
        PrimaryTextFormField(
          title: 'Nickname',
          readOnly: true,
          initialValue: employee.nickName,
        ),
        PrimaryTextFormField(
          title: 'Amount',
          readOnly: true,
          initialValue: medicalRequest.amount.toString(),
        ),
        PrimaryTextFormField(
          title: 'Note',
          readOnly: true,
          initialValue: medicalRequest.note,
        ),
      ],
    );
  }
}
