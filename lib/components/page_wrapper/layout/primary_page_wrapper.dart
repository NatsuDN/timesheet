import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/bars/side_nav_bar.dart';
import 'package:timesheet/components/bars/top_nav_bar.dart';
import 'package:timesheet/components/cards/layout/primary_card.dart';
import 'package:timesheet/components/page_wrapper/layout/primary_scaffold.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/employee.dart';
import 'package:timesheet/providers/side_nav_bar_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../router/route_utils.dart';
import '../../bars/profile_bar.dart';
import '../../buttons/layout/secondary_button.dart';

//With have bar and With Profile bar
class PrimaryPageWrapper extends ConsumerStatefulWidget {
  const PrimaryPageWrapper(
      {Key? key,
      required this.body,
      required this.title,
      required this.moreButton,
      required this.tabBar,
      this.profileBar,
      this.onExport,
      required this.routeLocation})
      : super(key: key);
  final Widget body;
  final Widget moreButton;
  final Widget tabBar;
  final Function()? onExport;
  final String title;
  final Widget? profileBar;
  final String routeLocation;

  @override
  _PrimaryPageWrapperState createState() => _PrimaryPageWrapperState();
}

class _PrimaryPageWrapperState extends ConsumerState<PrimaryPageWrapper> {
  @override
  void initState() {
    super.initState();
  }

  void toggleSideNavBar() {
    log('hide side nav bar');
    ref.read(isExtendedSideNavProvider.notifier).update((state) => !state);
    log(ref.watch(isExtendedSideNavProvider).toString());
  }

  _buildMainContent({bool showProfile = false}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // SideNavBar(isExtended: isExtendSideNavBar),
      // const VerticalDivider(thickness: 1, width: 1),
      Expanded(
        child: _MainContent(
            title: widget.title,
            onExport: widget.onExport,
            moreButton: widget.moreButton,
            tabBar: widget.tabBar,
            body: widget.body),
      ),
      // if (showProfile) const ProfileBar()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        topNavBar: SizedBox(
          height: kTopNavBarHeight,
          child: TopNavBar(
              leading: IconButton(
                  onPressed: toggleSideNavBar,
                  icon: const Icon(
                    Icons.menu,
                    color: kThemeColor,
                    size: kLarge,
                  ))),
        ),
        // drawer: const SideNavBar(),
        leftSideNavBar: SideNavBar(
          currentRouteLocation: widget.routeLocation,
        ),
        rightSideNavBar: widget.profileBar,
        body: _buildMainContent());
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    Key? key,
    required this.title,
    required this.moreButton,
    required this.tabBar,
    this.onExport,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget moreButton;
  final Widget tabBar;
  final Widget body;
  final Function()? onExport;
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: kRed,
        child: Container(
      child: Column(
        children: [
          Container(
            margin: kTopHorizontalSpaceXXLarge,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    title,
                    style: kHeader1TextStyle,
                  ),
                ),
                moreButton
              ],
            ),
          ),
          const SizedBox(height: kXLarge),
          PrimaryCard(
              margin: kHorizontalSpaceXXLarge,
              child: Container(
                margin: kHorizontalSpaceMedium,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: kVerticalSpaceMedium,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tabBar,
                            SecondaryButton(
                              text: 'Export',
                              onPressed: () {
                                onExport?.call();
                              },
                            )
                          ]),
                    ),
                    body,
                    SizedBox(height: kXLarge),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
