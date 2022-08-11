import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/cards/layout/primary_card.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/employee.dart';
import 'package:timesheet/providers/auth_provider.dart';

import '../../utils.dart';

class ProfileBar extends ConsumerStatefulWidget {
  const ProfileBar({Key? key, this.employee}) : super(key: key);
  final Employee? employee;

  @override
  _ProfileBarState createState() => _ProfileBarState();
}

class _ProfileBarState extends ConsumerState<ProfileBar> {
  @override
  Widget build(BuildContext context) {
    print('ProfileBar build');
    print('ProfileBar build employee: ${widget.employee?.fullName}');
    Employee currentEmp =
        widget.employee ?? ref.watch(authControllerProvider).user!.employee;
    print(currentEmp.fullName);
    return SizedBox(
        width: k13Width(context),
        height: k90Height(context),
        child: PrimaryCard(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: kTopSpaceLarge,
              child: Center(
                child: Container(
                  height: k5Width(context),
                  child: CircleAvatar(
                    maxRadius: kHundred,
                    backgroundColor: kThemeColor,
                    // Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    //     .withOpacity(1.0),
                    child: Text(
                      currentEmp.firstName.substring(0, 1),
                      style: kBodyTextStyle.copyWith(color: kThemeFontColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kXLarge),
            Padding(
              padding: kTopHorizontalSpaceLarge,
              child: Text(
                currentEmp.fullName,
                style: kHeader3TextStyle,
              ),
            ),
            Padding(
              padding: kTopHorizontalSpaceLarge,
              child: Text(
                'Leave Days Used',
                style: kBody2TextStyle.copyWith(color: kHeaderFontColor),
              ),
            ),
            const SizedBox(
              height: kSmall,
            ),
            Padding(
              padding: kHorizontalSpaceLarge,
              child: Text(
                  '${currentEmp.leaveDaysUsed}/${currentEmp.leaveDaysEntitlement}',
                  style: kBody2TextStyle.copyWith(color: kHeaderFontColor)),
            ),
            const SizedBox(
              height: kSmall,
            ),
            Padding(
              padding: kHorizontalSpaceLarge,
              child: LinearProgressIndicator(
                value: currentEmp.leaveDaysEntitlement <= 0
                    ? 0
                    : currentEmp.leaveDaysUsed /
                        currentEmp.leaveDaysEntitlement,
                backgroundColor: kThemeTertitaryBackgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(kThemeColor),
              ),
            ),
            const SizedBox(
              height: kSmall,
            ),
            Padding(
              padding: kTopHorizontalSpaceLarge,
              child: Text('Medical Fees Used',
                  style: kBody2TextStyle.copyWith(color: kHeaderFontColor)),
            ),
            const SizedBox(
              height: kSmall,
            ),
            Padding(
              padding: kHorizontalSpaceLarge,
              child: Text(
                  '${insertPriceComma(currentEmp.medicalFeesUsed.toStringAsFixed(0))}/${insertPriceComma(currentEmp.medicalFeesEntitlement.toStringAsFixed(0))}',
                  style: kBody2TextStyle.copyWith(color: kHeaderFontColor)),
            ),
            const SizedBox(
              height: kSmall,
            ),
            Padding(
              padding: kHorizontalSpaceLarge,
              child: LinearProgressIndicator(
                value: currentEmp.medicalFeesEntitlement <= 0
                    ? 0
                    : currentEmp.medicalFeesUsed /
                        currentEmp.medicalFeesEntitlement,
                backgroundColor: kThemeTertitaryBackgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(kThemeColor),
              ),
            ),
          ],
        )));
  }
}
