import 'dart:convert';
import 'dart:developer';

import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domains/user.dart';
import '../base_controller.dart';

abstract class AuthRepository {
  User? get user;
  Future<void> signUpOrganization(
      String username,
      String password,
      String orgNameTh,
      String orgNameEng,
      String shortName,
      String orgAddress,
      String orgPic,
      String firstName,
      String lastName,
      String nickName,
      {required BuildContext context});
  Future<void> signInWithCredentials(String username, String password,
      {required BuildContext context});
  Future<void> signOut();
}

class APIAuthRepository implements AuthRepository {
  User? _user;
  @override
  User? get user => _user;
  @override
  Future<void> signInWithCredentials(String username, String password,
      {required BuildContext context}) async {
    if (kIsMockup) {
      _user = User.mockUp();
      return;
    }
    // BrowserClient browserClient = BrowserClient()..withCredentials = true;
    // // print(kDioAuth.options.baseUrl + '/web/authen/login');
    // // print('http://54.254.157.156:50801/vault-auth-ws' );
    // final response = await browserClient.post(
    //     Uri.parse(
    //         'http://54.254.157.156:50801/vault-auth-ws/secure/web/authen/login'),
    //     headers: {
    //       "Content-Type": "application/json",
    //       // "accept": "/",
    //       "Access-Control-Allow-Origin": "*",
    //       // 'Content-Type': 'application/json',
    //       'vaultkey': '/ffsg8saspkwMnhwe/UTCkAlFE0JKT2d961mb2f/4MI='
    //     },
    //     body: json.encode({
    //       "user": username,
    //       "key": password,
    //       "org": "test",
    //       "applicationID": "timesheet"
    //     }));

    // // final response2 = await browserClient.post(
    // //     Uri.parse('$kBaseUrl/timesheet-ws/secure/employee/loginEmp'),
    // //     headers: {
    // //       "Content-Type": "application/json",
    // //       // "accept": "/",
    // //       "Access-Control-Allow-Origin": "*",
    // //       // 'Content-Type': 'application/json'
    // //     },
    // //     body: json.encode({
    // //       "username": username,
    // //       "password": password,
    // //     }));
    try {
      var authAdapter = BrowserHttpClientAdapter();
      authAdapter.withCredentials = true;
      kDioAuth.httpClientAdapter = authAdapter;
      kDioEmployee.httpClientAdapter = authAdapter;
      kDioAdmin.httpClientAdapter = authAdapter;

      // options: Options(headers: {
      //   'Content-Type': 'application/json',
      //   'vaultkey': '/ffsg8saspkwMnhwe/UTCkAlFE0JKT2d961mb2f/4MI='
      // }),
// http://54.254.157.156:50801/vault-auth-ws/secure/web/authen/loginClient
      final authResponse = await kDioAuth.post('/web/authen/login',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'vaultkey': '/ffsg8saspkwMnhwe/UTCkAlFE0JKT2d961mb2f/4MI='
          }),
          data: {
            "user": username,
            "key": password,
            "org": "test",
            "applicationID": "timesheet"
          });

      // print(response.data);
      final dbResponse = await kDioEmployee.post('/loginEmp',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: {
            "username": username,
            "password": password,
          });
      var body = dbResponse.data;
      print('body: $body');
      _user = User.fromJsonWithOutUsername(body, username);
      return;
    } on DioError catch (e) {
      print(e.response?.statusMessage ?? '');
      // print(e.response?.statusMessage ?? '');
      await showErrorDialog(context, e.message);

      return;
    }
  }

  @override
  Future<void> signOut() async {
    _user = null;
  }

  @override
  Future<void> signUpOrganization(
      String username,
      String password,
      String orgNameTh,
      String orgNameEng,
      String shortName,
      String orgAddress,
      String orgPic,
      String firstName,
      String lastName,
      String nickName,
      {required BuildContext context}) async {
    try {
      var authAdapter = BrowserHttpClientAdapter();
      authAdapter.withCredentials = true;
      kDioAuth.httpClientAdapter = authAdapter;
      kDioEmployee.httpClientAdapter = authAdapter;
      kDioAdmin.httpClientAdapter = authAdapter;

      final vaultAddUser = await kDioAuth.post('/authen/register',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'vaultkey': '/ffsg8saspkwMnhwe/UTCkAlFE0JKT2d961mb2f/4MI='
          }),
          data: {
            "user": "testtesttest1",
            "key": "123456789",
            "orgName": "test",
            "accountRole": "ADMIN",
            "applicationID": "timesheet"
          });

      // final dbAddUser = await kDioAdmin.post('/registerOrganize', data: {
      //   "orgNameTh": orgNameTh,
      //   "orgNameEng": orgNameEng,
      //   "shortName": shortName,
      //   "orgAdress": orgAddress,
      //   "orgPic": orgPic,
      //   "firstName": firstName,
      //   "lastName": lastName,
      //   "nickName": nickName,
      //   "password": password,
      //   "username": username
      // });
      // await signInWithCredentials(username, password, context: context);
    } on DioError catch (e) {
      print(e.toString());
      await showErrorDialog(context, e.message);

      return;
    }
  }
}
