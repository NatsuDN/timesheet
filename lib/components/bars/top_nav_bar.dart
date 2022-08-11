import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/primary_divider.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/providers/auth_provider.dart';

import '../../domains/company.dart';

class TopNavBar extends ConsumerWidget {
  const TopNavBar({Key? key, this.leading}) : super(key: key);
  final Widget? leading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company =
        ref.watch(authControllerProvider).user?.company ?? Company.mockUp();
    return Column(
      children: [
        Expanded(
          child: Container(
            color: kThemeFontColor,
            child: Row(
              children: [
                SizedBox(
                  width: kSideNavBarWidth,
                  child: leading ??
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: kThemeColor,
                          size: kXXLarge,
                        ),
                        onPressed: () {},
                      ),
                ),
                Expanded(
                  child: Container(
                    margin: kHorizontalSpaceXLarge,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: kLarge,
                          height: kLarge,
                        ),
                        const SizedBox(width: kSmall),
                        Text(
                          'Instant',
                          style: kHeader2TextStyle.copyWith(
                              color: kThemeColor,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      company.name,
                      style: kBodyTextStyle,
                    ),
                    const SizedBox(width: kMedium),
                    company.logoUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(company.logoUrl!),
                          )
                        : CircleAvatar(
                            backgroundColor: kThemeColor,
                            // Color((math.Random().nextDouble() * 0xFFFFFF)
                            //         .toInt())
                            //     .withOpacity(1.0),
                            child: Text(
                              company.name.substring(0, 1),
                              style: kBodyTextStyle.copyWith(
                                  color: kThemeFontColor),
                            ),
                          ),
                  ],
                ),
                const SizedBox(width: kXLarge),
              ],
            ),
          ),
        ),
        const PrimaryDivider(
          height: 1,
          thickness: 1,
          indent: 1,
        )
      ],
    );
  }
}
