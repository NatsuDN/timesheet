import 'dart:developer';

import 'package:flutter/cupertino.dart';

String? Function(String?)? basicValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    if (value.length >= 50) {
      return "Please enter a value less than 50 characters";
    }

    return null;
  };
}

String? Function(String?)? nameValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    if (value.length >= 50) {
      return "Please enter a value less than 50 characters";
    }
    if (!value.contains(RegExp(r'^[a-zA-Z]*$'))) {
      return "Please enter only characters";
    }
    return null;
  };
}

String? Function(String?)? passwordValidatior() {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Please enter a password";
    }
    if (txt.length < 6) {
      return "Password must has at least 6 characters";
    }
    // if (!txt.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must has uppercase";
    // }
    // if (!txt.contains(RegExp(r'[0-9]'))) {
    //   return "Password must has digits";
    // }
    // if (!txt.contains(RegExp(r'[a-z]'))) {
    //   return "Password must has lowercase";
    // }
    // if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
    //   return "Password must has special characters";
    // }
    return null;
  };
}

String? Function(String?)? confirmPasswordValidatior(
    TextEditingController orginalPasswordController) {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Please enter a password";
    }
    if (txt.length < 6) {
      return "Password must has at least 6 characters";
    }
    // if (!txt.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must has uppercase";
    // }
    // if (!txt.contains(RegExp(r'[0-9]'))) {
    //   return "Password must has digits";
    // }
    // if (!txt.contains(RegExp(r'[a-z]'))) {
    //   return "Password must has lowercase";
    // }
    if (txt != orginalPasswordController.text) {
      return "Password does not match";
    }
    return null;
  };
}

String? Function(String?)? birthDateValidator(TextEditingController date) {
  return (txt) {
    DateTime now = DateTime.now();
    DateTime birthdate = DateTime.parse(date.text);

    int age = now.year - birthdate.year;
    log(age.toString());
    if (txt == null || txt.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  };
}

String? Function(String?)? userNameValidator() {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return 'Please enter a value';
    }
    if (txt.length < 6) {
      return "Username must has at least 6 characters";
    }
    if (txt.length >= 30) {
      return "Please enter a value less than 30 characters";
    }
    if (txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
      return "Username must not has any special characters";
    }
    return null;
  };
}

String getCapitalized(String str) {
  return str.isNotEmpty
      ? str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase()
      : str;
}

String getFormatDate(DateTime date) {
  String month = date.month < 10 ? '0${date.month}' : '${date.month}';
  String day = date.day < 10 ? '0${date.day}' : '${date.day}';

  return "${date.year}-$month-$day";
}

String getFormatDateWithTime(DateTime date) {
  return "${date.day}/${date.month}/${date.year} | ${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}";
}

const List<String> weekDays = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

String getWeekDay(DateTime date) {
  return weekDays[date.weekday - 1];
}

bool isValidTimeText(String text) {
  var time = text.split(':');
  if (time.length != 2) {
    return false;
  }
  var hour = int.tryParse(time[0]);
  var minute = int.tryParse(time[1]);

  return text.length == 5 &&
      hour != null &&
      minute != null &&
      hour >= 0 &&
      hour <= 23 &&
      minute >= 0 &&
      minute <= 59;
}

List<String> getListofYears(int range) {
  List<String> years = [];
  int currentYears = DateTime.now().year;

  for (int i = range + currentYears; i >= currentYears - range; i--) {
    years.add(i.toString());
  }

  return years;
}

List<String> getListofMonths() {
  return [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
}

String insertPriceComma(String price) {
  return price.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}
