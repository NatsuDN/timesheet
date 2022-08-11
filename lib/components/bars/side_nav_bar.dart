import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/providers/auth_provider.dart';
import 'package:timesheet/providers/side_nav_bar_provider.dart';
import 'package:timesheet/router/route_utils.dart';
import 'package:timesheet/screens/employees_data_grid_page/employees_datagrid_page.dart';
import 'package:timesheet/screens/user_profile_page/user_profile_page.dart';

import '../../constants.dart';

class SideNavBar extends ConsumerStatefulWidget {
  const SideNavBar({Key? key, required this.currentRouteLocation})
      : super(key: key);

  final String currentRouteLocation;
  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends ConsumerState<SideNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> pagesList = [
      if (ref.watch(authControllerProvider).user!.employee.isAdmin)
        AppPage.employeesData.toRouteName,
      AppPage.userProfile.toRouteName,
      AppPage.userProfile.toRouteName
    ];

    _selectedIndex = pagesList.indexOf(widget.currentRouteLocation);

    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        GoRouter.of(context).go(
          pagesList[index],
        );
        // Navigator.pushNamed(context, _pagesOption[index]);
      },
      selectedLabelTextStyle: kHeader3TextStyle,
      unselectedLabelTextStyle: kBodyTextStyle,
      minWidth: kSideNavBarWidth,
      extended: ref.watch(isExtendedSideNavProvider),
      labelType: NavigationRailLabelType.none,
      destinations: <NavigationRailDestination>[
        if (ref.watch(authControllerProvider).user!.employee.isAdmin)
          const NavigationRailDestination(
            icon: Icon(
              Icons.person_outline,
              color: kThemeColor,
            ),
            selectedIcon: Icon(
              Icons.person,
              color: kThemeColor,
            ),
            label: Text('Employees Data'),
          ),
        const NavigationRailDestination(
          icon: Icon(
            Icons.contact_page_outlined,
            color: kThemeColor,
          ),
          selectedIcon: Icon(
            Icons.contact_page,
            color: kThemeColor,
          ),
          label: Text('My Profile'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.medical_information_outlined,
            color: kThemeColor,
          ),
          selectedIcon: Icon(
            Icons.medical_information,
            color: kThemeColor,
          ),
          label: Text('My Medical'),
        ),
      ],
    );
  }
}
