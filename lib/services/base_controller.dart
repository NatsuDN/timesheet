import 'dart:async';
import 'dart:convert';

import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../components/buttons/layout/primary_button.dart';
import '../constants.dart';

const bool kIsMockup = false;
// const String kBaseUrl = "http://192.168.86.80:8081";
const String kBaseUrl = "http://localhost:8081";

var optionsAdmin = BaseOptions(
  baseUrl: '$kBaseUrl/timesheet-ws/secure/admin', //WITH VAULT AUTH SERVER
  // baseUrl: '$kBaseUrl/timesheet-ws/api/v1/admin', //WITHOUT VAULT AUTH SERVER
);
Dio kDioAdmin = Dio(optionsAdmin);

var optionsEmployee = BaseOptions(
  baseUrl: '$kBaseUrl/timesheet-ws/secure/employee', //WITH VAULT AUTH SERVER
  // baseUrl: '$kBaseUrl/timesheet-ws/api/v1/employee', //WITHOUT VAULT AUTH SERVER
);
Dio kDioEmployee = Dio(optionsEmployee);

var optionsAuth = BaseOptions(
  baseUrl: 'http://localhost:50801/vault-auth-ws/secure',
);
Dio kDioAuth = Dio(optionsAuth);

const String kMockUpUrl = "json";

Future<void> showErrorDialog(context, body, {bool isPop = true}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Error",
            style: kHeader1TextStyle,
          ),
          content: Text(
            body ?? 'Something went wrong',
            style: kBodyTextStyle,
          ),
          actions: <Widget>[
            PrimaryButton(
              color: kHeaderFontColor,
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future jsonFromMockUpApi(String apiPath,
    {required BuildContext context}) async {
  final AssetBundle rootBundle = DefaultAssetBundle.of(context);
  final mockUpRespond = await rootBundle.loadString('$kMockUpUrl/$apiPath');
  return jsonDecode(mockUpRespond);
}
