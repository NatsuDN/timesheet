import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timesheet/components/forms/layout/primary_dropdown.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/components/primary_circular_progress_indicator.dart';
import 'package:timesheet/domains/holiday_type.dart';
import 'package:timesheet/providers/auth_provider.dart';
import 'package:timesheet/providers/holiday_type_provider.dart';
import 'package:timesheet/services/employees_data_controller.dart';

import '../layout/primary_textformfield.dart';
import 'calendar/holiday_type_setting_calendar.dart';

class HolidaySettingTypeFormCard extends ConsumerStatefulWidget {
  const HolidaySettingTypeFormCard({Key? key}) : super(key: key);

  @override
  _HolidaySettingTypeFormCardState createState() =>
      _HolidaySettingTypeFormCardState();
}

class _HolidaySettingTypeFormCardState
    extends ConsumerState<HolidaySettingTypeFormCard> {
  final _formKey = GlobalKey<FormState>();
  bool isCreateNew = false;
  final TextEditingController _nameController = TextEditingController();
  HolidayType? _selectedHolidayType;

  // late Future<List<HolidayType>> _getHolidayTypes;

  @override
  void initState() {
    super.initState();
    // _getHolidayTypes = getHolidayTypes(context: context);
  }

  _onSubmit() async {
    print('UPDATE HOLIDAY');
    if (_selectedHolidayType != null) {
      if (isCreateNew) {
        await createHolidayType(
          ref.watch(authControllerProvider).user!.company.id,
          _nameController.text,
          _selectedHolidayType!.holidayDateTimes,
          context: context,
        );
        ref
            .read(holidayTypeProvider.notifier)
            .loadHolidayTypeLists(
                ref.watch(authControllerProvider).user!.company.id, context)
            .then((value) => {Navigator.maybePop(context)});
      } else {
        final holidayTypes = ref.watch(holidayTypeProvider);
        final orginalHolidayType = holidayTypes.firstWhere(
            (holidayType) => holidayType.name == _selectedHolidayType!.name);
        final updatedHolidayType = _selectedHolidayType!;
        print('UPDATE HOLIDAY');
        // Comapre OLd /New.

        // old [ 1 2 4 ]
        // new  [ 2 4 5 ]
        // send [ 1(Get Out) 5(Add) ]

//     The Δ in set theory is the symmetric difference of two sets.
//    A Δ B = (B−A)∪(A−B)
        // update
        print('UPDATE HOLIDAY');
        final newHolidayDateTimes = orginalHolidayType.holidayDateTimes
            .difference(updatedHolidayType.holidayDateTimes)
            .union(updatedHolidayType.holidayDateTimes
                .difference(orginalHolidayType.holidayDateTimes));

        await updateHolidayType(
          updatedHolidayType.id,
          newHolidayDateTimes,
          context: context,
        );
        print('UPDATE HOLIDAY');
        ref
            .read(holidayTypeProvider.notifier)
            .loadHolidayTypeLists(
                ref.watch(authControllerProvider).user!.company.id, context)
            .then((value) => {Navigator.maybePop(context)});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final holidayTypes = ref.watch(holidayTypeProvider);
    final holidayTypesName =
        ref.read(holidayTypeProvider.notifier).getHolidayTypeNames();
    var holidayTypeDropdownItems = [...holidayTypesName, 'Create New'];
    _selectedHolidayType ??= HolidayType.copy(holidayTypes.first);

    return PrimaryFormCard(
        showBorder: false,
        formKey: _formKey,
        title: 'Holiday Type Setting',
        onSubmit: _onSubmit,
        submitLabel: isCreateNew ? 'Create' : 'Update',
        children: [
          Column(
            children: [
              PrimaryDropDown(
                title: 'Holiday Type',
                items: holidayTypeDropdownItems,
                defaultValue: holidayTypeDropdownItems.first,
                onChanged: (value) {
                  setState(() {
                    isCreateNew = value == 'Create New';
                    if (isCreateNew) {
                      _selectedHolidayType = HolidayType.empty();
                    } else {
                      _selectedHolidayType = HolidayType.copy(
                          holidayTypes.firstWhere(
                              (holidayType) => holidayType.name == value));
                    }
                  });
                },
              ),
              isCreateNew
                  ? PrimaryTextFormField(
                      title: 'New Holiday Type',
                      controller: _nameController,
                    )
                  : Container(),
              // Text('${_selectedHolidayType?.name ?? 'null'}'),
              HolidayTypeSettingCalendar(
                holidayType: _selectedHolidayType ?? holidayTypes.first,
              )
            ],
          )
          // FutureBuilder(
          //     future: _getHolidayTypes,
          //     builder: (context, AsyncSnapshot<List<HolidayType>> snapshot) {
          //       if (snapshot.hasData) {
          //         var holidayTypes = snapshot.data;
          //         var holidayTypeDropdownItems =
          //             holidayTypes!.map((holidayType) {
          //           return holidayType.name;
          //         }).toList();
          //         holidayTypeDropdownItems = [
          //           ...holidayTypeDropdownItems,
          //           'Create New'
          //         ];
          //         _selectedHolidayType ??= holidayTypes.first;
          //         // this._selectedHolidayType = holidayTypes!.first;
          //         return Column(
          //           children: [
          //             PrimaryDropDown(
          //               title: 'Holiday Type',
          //               items: holidayTypeDropdownItems,
          //               defaultValue: holidayTypeDropdownItems.first,
          //               onChanged: (value) {
          //                 setState(() {
          //                   isCreateNew = value == 'Create New';
          //                   if (isCreateNew) {
          //                     _selectedHolidayType = HolidayType.empty();
          //                   } else {
          //                     _selectedHolidayType = holidayTypes.firstWhere(
          //                         (holidayType) => holidayType.name == value);
          //                   }
          //                   log(value);
          //                   log(_selectedHolidayType!.name);
          //                 });
          //               },
          //             ),
          //             isCreateNew
          //                 ? const PrimaryTextFormField(
          //                     title: 'New Holiday Type')
          //                 : Container(),
          //             // Text('${_selectedHolidayType?.name ?? 'null'}'),
          //             HolidayTypeSettingCalendar(
          //               holidayType: _selectedHolidayType ?? holidayTypes.first,
          //             )
          //           ],
          //         );
          //       } else {
          //         return const PrimaryCircularProgressIndicator();
          //       }
          //     }),
        ]);
  }
}
