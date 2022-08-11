import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/providers/auth_provider.dart';
import 'package:timesheet/router/route_utils.dart';
import 'package:timesheet/screens/employees_data_grid_page/employees_datagrid_page.dart';
import 'package:timesheet/screens/login_page.dart';
import 'package:timesheet/screens/on_boarding_page.dart';
import 'package:timesheet/screens/register_oragnization_page.dart';
import 'package:timesheet/screens/user_profile_page/user_profile_page.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true, // For demo purposes
    refreshListenable: router, // This notifiies `GoRouter` for refresh events
    redirect: router._redirectLogic, // All the logic is centralized here
    routes: router._routes, // All the routes can be found there
    initialLocation: AppPage.userProfile.toRouteName, // The initial location
  );
});

/// My favorite approach: ofc there's room for improvement, but it works fine.
/// What I like about this is that `RouterNotifier` centralizes all the logic.
/// The reason we use `ChangeNotifier` is because it's a `Listenable` object,
/// as required by `GoRouter`'s `refreshListenable` parameter.
/// Unluckily, it is not possible to use a `StateNotifier` here, since it's
/// not a `Listenable`. Recall that `StateNotifier` is to be preferred over
/// `ChangeNotifier`, see https://riverpod.dev/docs/concepts/providers/#different-types-of-providers
/// There are other approaches to solve this, and they can
/// be found in the `/others` folder.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authControllerProvider, // In our case, we're interested in the log in / log out events.
      (_, __) => notifyListeners(), // Obviously more logic can be added here
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(GoRouterState state) {
    final auth = _ref.read(authControllerProvider);

    // From here we can use the state and implement our custom logic
    final isAtLoginPage = state.location == AppPage.login.toRouteName;
    final isAtAdminPage = state.location == AppPage.employeesData.toRouteName;
    final isAtRegisterPage = state.location == AppPage.register.toRouteName;
    final isAtOtherUserProfilePage =
        (state.location).contains('${AppPage.userProfile.toRouteName}/empId');
    final isAuthenticated =
        auth.user != null && auth.status != AuthStatus.initial;

    final isAdmin = auth.user?.employee.role == 'ADMIN';

    if (!isAuthenticated) {
      // log('Not authenticated, redirecting to login page');
      // We're not logged in
      // So, IF we aren't in the login page, go there.
      if (isAtRegisterPage) {
        return null;
      } else if (!isAtLoginPage) {
        return AppPage.login.toRouteName;
      }
      return null;
    } else {
      if (isAtAdminPage) {
        return isAdmin ? null : AppPage.userProfile.toRouteName;
      }
      if (isAtOtherUserProfilePage) {
        return isAdmin ? null : AppPage.userProfile.toRouteName;
      }
      // log('Authenticated, redirecting to home page');
      // We're logged in
      // So, IF we aren't in the home page, go there.
      return isAtLoginPage ? AppPage.userProfile.toRouteName : null;

      // There's no need for a redirect at this point.
    }
  }

  //  userprofile/empId/202207
  List<GoRoute> get _routes => [
        GoRoute(
            name: AppPage.userProfile.toName,
            path: AppPage.userProfile.toRouteName,
            builder: (context, _) => UserProfilePage(
                  empId: _ref.watch(authControllerProvider).user!.id,
                  fullName: _ref
                      .watch(authControllerProvider)
                      .user!
                      .employee
                      .fullName,
                ),
            routes: [
              GoRoute(
                  path: 'empId/:empId',
                  builder: (context, state) => UserProfilePage(
                        empId: state.params['empId']!,
                        isAdminView: true,
                      ),
                  routes: [
                    GoRoute(
                        path: 'at/:at',
                        builder: (context, state) {
                          log(state.params['at']!.substring(0, 4));
                          log(state.params['at']!.substring(4, 6));
                          return UserProfilePage(
                            isAdminView: true,
                            empId: state.params['empId']!,
                            year: state.params['at']!.length < 6
                                ? null
                                : int.parse(
                                    state.params['at']!.substring(0, 4)),
                            month: state.params['at']!.length < 6
                                ? null
                                : int.parse(
                                    state.params['at']!.substring(4, 6)),
                          );
                        }),
                  ]),
            ]),
        GoRoute(
          name: AppPage.login.toName,
          path: AppPage.login.toRouteName,
          builder: (context, _) => const LoginPage(),
        ),
        GoRoute(
          name: AppPage.onBoarding.toName,
          path: AppPage.onBoarding.toRouteName,
          builder: (context, _) => const OnBoardingPage(),
        ),
        GoRoute(
          name: AppPage.register.toName,
          path: AppPage.register.toRouteName,
          builder: (context, _) => const RegisterOrganizationPage(),
        ),
        GoRoute(
            name: AppPage.employeesData.toName,
            path: AppPage.employeesData.toRouteName,
            builder: (context, _) => EmployeesDataGridPage(
                  orgId: _ref.watch(authControllerProvider).user!.company.id,
                )),
      ];
}

// home/profile/timesheets
// home/profile/medical-requests
///home/employees-data/overview
///home/employees-data/timesheets
///home/employees-data/medical-requests
///home/employees-data/leaves
///home/employees-data/medical-fees
