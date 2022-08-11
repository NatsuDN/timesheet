import '../../screens/login_page.dart';

enum AppPage {
  login,
  register,
  home,
  userProfile,
  employeesData,
  error,
  onBoarding,
}

extension AppPageExtension on AppPage {
  String get toRouteName {
    switch (this) {
      case AppPage.home:
        return '/';
      case AppPage.login:
        return '/login';
      case AppPage.register:
        return '/register';
      case AppPage.userProfile:
        return '/user-profile';
      case AppPage.employeesData:
        return '/employees-data';
      case AppPage.error:
        return '/error';
      case AppPage.onBoarding:
        return '/on-boarding';
    }
  }

  //ToName method UPPERCASE NAME OF THE PAGE
  String get toName {
    switch (this) {
      case AppPage.home:
        return 'HOME';
      case AppPage.login:
        return 'LOGIN';
      case AppPage.register:
        return 'REGISTER';
      case AppPage.userProfile:
        return 'USER-PROFILE';
      case AppPage.employeesData:
        return 'EMPLOYEES-DATA';
      case AppPage.error:
        return 'ERROR';
      case AppPage.onBoarding:
        return 'ON-BOARDING';
    }
  }

  String get toTitle {
    switch (this) {
      case AppPage.home:
        return 'Home';
      case AppPage.login:
        return 'Login';
      case AppPage.register:
        return 'Register';
      case AppPage.userProfile:
        return 'User Profile';
      case AppPage.employeesData:
        return 'Employees Data';
      case AppPage.error:
        return 'Error';
      case AppPage.onBoarding:
        return 'On Boarding';
    }
  }
}
