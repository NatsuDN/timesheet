import 'package:flutter/material.dart';
import 'package:timesheet/components/buttons/layout/alternate_link_button.dart';
import 'package:timesheet/components/buttons/layout/primary_button.dart';
import 'package:timesheet/components/cards/layout/primary_card.dart';

import '../../../constants.dart';

class PrimaryFormCard extends StatelessWidget {
  const PrimaryFormCard({
    Key? key,
    required this.formKey,
    required this.children,
    required this.title,
    required this.submitLabel,
    required this.onSubmit,
    this.buttonWidth = 200,
    this.buttonHeight = 50,
    this.showBorder = true,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.alternateLinkButton,
    this.titleTextStyle,
    this.width,
    this.titleSpacing,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final String title;
  final TextStyle? titleTextStyle;
  final EdgeInsets? titleSpacing;
  final double? width;
  final String submitLabel;
  final Function() onSubmit;
  final AlternateLinkButton? alternateLinkButton;
  final bool showBorder;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final double buttonWidth;
  final double buttonHeight;
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      showBorder: showBorder,
      width: width ?? k40Width(context),
      child: Form(
          key: formKey,
          child: Container(
            child: Column(children: [
              Container(
                margin: titleSpacing ?? kVerticalSpaceMedium,
                child: Text(
                  '$title',
                  style: titleTextStyle ?? kHeader2TextStyle,
                ),
              ),
              Column(
                  mainAxisAlignment:
                      mainAxisAlignment ?? MainAxisAlignment.start,
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.center,
                  children: [...children]),
              Padding(
                padding: kVerticalSpaceLarge,
                child: SizedBox(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: PrimaryButton(
                    text: submitLabel,
                    onPressed: onSubmit,
                  ),
                ),
              ),
              alternateLinkButton ?? Container()
            ]),
          )),
    );
  }
}
