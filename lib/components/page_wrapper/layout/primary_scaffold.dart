import 'package:flutter/material.dart';
import 'package:timesheet/components/page_wrapper/layout/common_wrapper.dart';

import '../../../constants.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold({
    Key? key,
    required this.body,
    this.appbar,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.leftSideNavBar,
    this.rightSideNavBar,
    this.topNavBar,
  }) : super(key: key);
  final Widget body;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? leftSideNavBar;
  final Widget? rightSideNavBar;
  final SizedBox? topNavBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      // drawer: drawer,
      body: SafeArea(
        child: CommonWrapper(
          leftSideNavigationMenu: leftSideNavBar,
          rightSideNavigationMenu: rightSideNavBar,
          header: topNavBar,
          // header: SizedBox(height: k10Height(context), child: Text('Header')),
          child: body,
        ),
        //   child: CustomScrollView(
        // slivers: [
        //   SliverFillRemaining(
        //     hasScrollBody: false,
        //     child: body,
        //   ),
        // ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
