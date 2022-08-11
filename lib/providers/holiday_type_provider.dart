import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/holiday_type.dart';
import '../services/employees_data_controller.dart';

final holidayTypeProvider =
    StateNotifierProvider<HolidayTypeNotifier, List<HolidayType>>(
  (ref) => HolidayTypeNotifier([]),
  // (ref) => holidayTypeNotifier(User.mockUp()),
);

class HolidayTypeNotifier extends StateNotifier<List<HolidayType>> {
  HolidayTypeNotifier(List<HolidayType> state) : super(state);

  Future<void> loadHolidayTypeLists(orgId, context) async {
    List<HolidayType> newholidayTypes =
        await getHolidayTypes(orgId, context: context);
    setCurrentholidayTypes(newholidayTypes);
  }

  setCurrentholidayTypes(List<HolidayType> holidayTypes) {
    state = holidayTypes;
  }

  List<String> getHolidayTypeNames() =>
      state.map((holidayType) => '${holidayType.name}').toList();
}
