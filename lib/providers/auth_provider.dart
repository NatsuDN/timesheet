import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/domains/employee.dart';
import 'package:timesheet/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domains/user.dart';
import '../services/repository/auth_repository.dart';

final authRepositoryProvider = Provider<APIAuthRepository>((ref) {
  return APIAuthRepository(); // This is nothing but a global instance of the repository
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(const AuthState.unauthenticated(),
      authRepository: ref.watch(authRepositoryProvider),
      sharedPrefs: ref.watch(sharedPrefsProvider).maybeWhen(
            data: (prefs) => prefs,
            orElse: () => null,
          ));
});

class AuthController extends StateNotifier<AuthState> {
  AuthController(AuthState state,
      {required this.sharedPrefs, required this.authRepository})
      : super(state);

  // sharedPrefs?.getString('user') != null
  //       ? AuthState.authenticated(
  //           User.fromJson(json.decode(sharedPrefs!.getString('user')!)))
  //       :state
  final APIAuthRepository authRepository;
  final SharedPreferences? sharedPrefs;

  _fetchUser() {
    final User? user = authRepository.user;
    if (user != null) {
      state = AuthState.authenticated(user);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  void logIn(String username, String password,
      {required BuildContext context}) async {
    state = const AuthState.loading();
    try {
      await authRepository.signInWithCredentials(username, password,
          context: context);
      _fetchUser();

      if (state.user != null) {
        log('Store User');
        log(json.encode(state.user!.toJson()));
        sharedPrefs?.setString('user', json.encode(state.user!.toJson()));
      }
    } catch (e) {
      print('Error: $e');
      state = const AuthState.unauthenticated();
    }
  }

  void deleteUserCache() {
    sharedPrefs?.remove('user');
  }

  void logOut() async {
    await authRepository.signOut();
    state = const AuthState.unauthenticated();
    sharedPrefs?.remove('user');
  }

  void signUpOrganization(
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
    await authRepository.signUpOrganization(
        username,
        password,
        orgNameTh,
        orgNameEng,
        shortName,
        orgAddress,
        orgPic,
        firstName,
        lastName,
        nickName,
        context: context);
    _fetchUser();
  }
}

enum AuthStatus { initial, authenticated, unauthenticated, loading }

class AuthState {
  final AuthStatus status;
  final User? user;
  const AuthState({required this.status, required this.user});
  const AuthState.initial() : this(status: AuthStatus.initial, user: null);
  const AuthState.authenticated(User user)
      : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated, user: null);
  const AuthState.loading() : this(status: AuthStatus.loading, user: null);
  AuthState.fromJson(Map<String, dynamic> json)
      : this(status: AuthStatus.values[json['status']], user: json['user']);
}
