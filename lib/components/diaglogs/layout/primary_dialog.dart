import 'dart:developer';

import 'package:flutter/material.dart';

showPrimaryDialog(context, {required children}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //this right here
          child: SizedBox(
              width: 400, child: _buildDialogScrollable(children: children)),
        );
      });
}

SingleChildScrollView _buildDialogScrollable({required children}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ),
  );
}
