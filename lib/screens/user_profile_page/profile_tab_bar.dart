import 'package:flutter/material.dart';
import 'package:timesheet/screens/user_profile_page/user_profile_page.dart';

import '../../constants.dart';

class ProfileTabBar extends StatefulWidget {
  const ProfileTabBar({Key? key, required this.onTabChanged}) : super(key: key);
  final Function(UserProfileTab) onTabChanged;
  @override
  State<ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  List<bool> isSelected = [
    true,
    false,
  ];
  final List<String> tabTitles = [
    'Time Sheets',
    'Medical Requests',
  ];
  final List<UserProfileTab> tab = [
    UserProfileTab.timeSheetDetails,
    UserProfileTab.meicalRequests,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kXXXLarge,
      color: kThemeSecondaryBackgroundColor,
      child: Padding(
        padding: kAllSpaceSuperSmall,
        child: ToggleButtons(
          selectedColor: Colors.black,
          fillColor: kThemeFontColor,
          color: Colors.grey,
          renderBorder: false,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
            widget.onTabChanged(tab[index]);
          },
          isSelected: isSelected,
          children: <Widget>[
            for (int i = 0; i < tabTitles.length; i++)
              Container(child: Center(child: Text(tabTitles[i])), width: 120),
          ],
        ),
      ),
    );
  }
}
