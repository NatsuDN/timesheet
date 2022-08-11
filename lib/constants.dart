import 'package:flutter/material.dart';

const Color kThemeColor = Color(0xFF4DA1FF);
const Color kSecondaryThemeColor = Color(0xFFf5901a);
const Color kThemeFontColor = Color(0xFFFFFFFF);
const Color kThemeSecondaryBackgroundColor = Color(0xFFF4F8F9);
const Color kThemeTertitaryBackgroundColor = Color(0xFFFAFBFC);
const Color kHeaderFontColor = Color(0XFF323C47);
const Color kPrimaryFontColor = Color(0XFF323C47);
const Color kSecondaryFontColor = Color(0XFFA8A8A8);
const Color kBorderColor = Color(0XFFE9EFF4);
const Color kGreen = Color(0XFF009245);
const Color kRed = Color(0XFFFF4D4D);
const Color kOrange = Color(0XFFf5a623);
const double kBigHeaderFontSize = 36.0;
const double kHeader1FontSize = 24.0;
const double kHeader2FontSize = 20.0;
const double kHeader3FontSize = 16.0;
const double kHeader4FontSize = 14.0;
const double kHeader5FontSize = 12.0;

const double kBodyFontSize = 16.0;
const double kBody2FontSize = 14.0;
const double kBody3FontSize = 12.0;
const double kBody4FontSize = 10.0;

const double kTopNavBarHeight = 80;
const double kSideNavBarWidth = 80;

const TextStyle kBigHeaderTextStyle = TextStyle(
  fontSize: kBigHeaderFontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader1TextStyle = TextStyle(
  fontSize: kHeader1FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);
const TextStyle kHeader2TextStyle = TextStyle(
  fontSize: kHeader2FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader3TextStyle = TextStyle(
  fontSize: kHeader3FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader4TextStyle = TextStyle(
  fontSize: kHeader4FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader5TextStyle = TextStyle(
  fontSize: kHeader5FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);
const TextStyle kBodyTextStyle = TextStyle(
  fontSize: kBodyFontSize,
  fontWeight: FontWeight.w500,
  color: kPrimaryFontColor,
);
const TextStyle kBody2TextStyle = TextStyle(
  fontSize: kBody2FontSize,
  color: kSecondaryFontColor,
);
const TextStyle kBody3TextStyle = TextStyle(
  fontSize: kBody3FontSize,
  color: kSecondaryFontColor,
);
InputDecoration kTextFieldDecorationWithHintText(String hintText) =>
    InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: kThemeColor.withOpacity(0.5), width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: kBorderColor, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          // fontSize: kListItemSubTitleFontSize,
          color: kSecondaryFontColor,
        ));

InputDecoration kTextFieldDecorationWithLabelText(String label,
        {Color color = kThemeColor}) =>
    InputDecoration(
      label: Text(label),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        // fontSize: kListItemSubTitleFontSize,
        color: kSecondaryFontColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.withOpacity(0.5), width: 1.0),
        // borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: kBorderColor, width: 1.0),
      ),
      errorBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: kRed, width: 1.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: kRed, width: 1.0),
      ),
    );
InputDecoration kTopUpTextFieldDecorationWithHintText(String hintText,
        {Color color = kThemeColor}) =>
    InputDecoration(
      hintText: hintText,
      hintStyle: kBigHeaderTextStyle,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.withOpacity(0.5), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: kBorderColor, width: 1.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: kRed, width: 1.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: kRed, width: 1.0),
      ),
    );

double kWidth(context) => MediaQuery.of(context).size.width;
double kHeight(context) => MediaQuery.of(context).size.height;

double k10Width(context) => kWidth(context) * 0.1;
double k20Width(context) => kWidth(context) * 0.2;
double k30Width(context) => kWidth(context) * 0.3;
double k40Width(context) => kWidth(context) * 0.4;
double k50Width(context) => kWidth(context) * 0.5;
double k60Width(context) => kWidth(context) * 0.6;
double k70Width(context) => kWidth(context) * 0.7;
double k80Width(context) => kWidth(context) * 0.8;
double k90Width(context) => kWidth(context) * 0.9;
double k100Width(context) => kWidth(context) * 1.0;

double k10Height(context) => kHeight(context) * 0.1;
double k20Height(context) => kHeight(context) * 0.2;
double k30Height(context) => kHeight(context) * 0.3;
double k40Height(context) => kHeight(context) * 0.4;
double k50Height(context) => kHeight(context) * 0.5;
double k60Height(context) => kHeight(context) * 0.6;
double k70Height(context) => kHeight(context) * 0.7;
double k80Height(context) => kHeight(context) * 0.8;
double k90Height(context) => kHeight(context) * 0.9;
double k100Height(context) => kHeight(context) * 1.0;

const EdgeInsets kAllSpaceSmall = EdgeInsets.all(kSmall);
const EdgeInsets kAllSpaceMedium = EdgeInsets.all(kMedium);
const EdgeInsets kAllSpaceLarge = EdgeInsets.all(kLarge);
const EdgeInsets kAllSpaceXLarge = EdgeInsets.all(kXLarge);
const EdgeInsets kAllSpaceXXLarge = EdgeInsets.all(kXXLarge);
const EdgeInsets kAllSpaceXXXLarge = EdgeInsets.all(kXXXLarge);
const EdgeInsets kAllSpaceXXXXLarge = EdgeInsets.all(kXXXXLarge);

const EdgeInsets kHorizontalSpaceSmall =
    EdgeInsets.symmetric(horizontal: kSmall);
const EdgeInsets kHorizontalSpaceMedium =
    EdgeInsets.symmetric(horizontal: kMedium);
const EdgeInsets kHorizontalSpaceLarge =
    EdgeInsets.symmetric(horizontal: kLarge);
const EdgeInsets kHorizontalSpaceXLarge =
    EdgeInsets.symmetric(horizontal: kXLarge);
const EdgeInsets kHorizontalSpaceXXLarge =
    EdgeInsets.symmetric(horizontal: kXXLarge);
const EdgeInsets kHorizontalSpaceXXXLarge =
    EdgeInsets.symmetric(horizontal: kXXXLarge);
const EdgeInsets kHorizontalSpaceXXXXLarge =
    EdgeInsets.symmetric(horizontal: kXXXXLarge);

const EdgeInsets kVerticalSpaceSmall = EdgeInsets.symmetric(vertical: kSmall);
const EdgeInsets kVerticalSpaceMedium = EdgeInsets.symmetric(vertical: kMedium);
const EdgeInsets kVerticalSpaceLarge = EdgeInsets.symmetric(vertical: kLarge);
const EdgeInsets kVerticalSpaceXLarge = EdgeInsets.symmetric(vertical: kXLarge);
const EdgeInsets kVerticalSpaceXXLarge =
    EdgeInsets.symmetric(vertical: kXXLarge);
const EdgeInsets kVerticalSpaceXXXLarge =
    EdgeInsets.symmetric(vertical: kXXXLarge);
const EdgeInsets kVerticalSpaceXXXXLarge =
    EdgeInsets.symmetric(vertical: kXXXXLarge);

const EdgeInsets kTopSpaceSmall = EdgeInsets.only(top: kSmall);
const EdgeInsets kTopSpaceMedium = EdgeInsets.only(top: kMedium);
const EdgeInsets kTopSpaceLarge = EdgeInsets.only(top: kLarge);
const EdgeInsets kTopSpaceXLarge = EdgeInsets.only(top: kXLarge);
const EdgeInsets kTopSpaceXXLarge = EdgeInsets.only(top: kXXLarge);
const EdgeInsets kTopSpaceXXXLarge = EdgeInsets.only(top: kXXXLarge);
const EdgeInsets kTopSpaceXXXXLarge = EdgeInsets.only(top: kXXXXLarge);

const EdgeInsets kBottomSpaceSmall = EdgeInsets.only(bottom: kSmall);
const EdgeInsets kBottomSpaceMedium = EdgeInsets.only(bottom: kMedium);
const EdgeInsets kBottomSpaceLarge = EdgeInsets.only(bottom: kLarge);
const EdgeInsets kBottomSpaceXLarge = EdgeInsets.only(bottom: kXLarge);
const EdgeInsets kBottomSpaceXXLarge = EdgeInsets.only(bottom: kXXLarge);
const EdgeInsets kBottomSpaceXXXLarge = EdgeInsets.only(bottom: kXXXLarge);
const EdgeInsets kBottomSpaceXXXXLarge = EdgeInsets.only(bottom: kXXXXLarge);

const double kSmall = 8;
const double kMedium = 16;
const double kLarge = 24;
const double kXLarge = 32;
const double kXXLarge = 40;
const double kXXXLarge = 48;
const double kXXXXLarge = 56;

const EdgeInsets kTopHorizontalSpaceSmall =
    EdgeInsets.only(left: 8, right: 8, top: 8);
const EdgeInsets kTopHorizontalSpaceMedium =
    EdgeInsets.only(left: 16, right: 16, top: 16);
const EdgeInsets kTopHorizontalSpaceLarge =
    EdgeInsets.only(left: 24, right: 24, top: 24);
const EdgeInsets kTopHorizontalSpaceXLarge =
    EdgeInsets.only(left: 32, right: 32, top: 32);
const EdgeInsets kTopHorizontalSpaceXXLarge =
    EdgeInsets.only(left: 40, right: 40, top: 40);
const EdgeInsets kTopHorizontalSpaceXXXLarge =
    EdgeInsets.only(left: 48, right: 48, top: 48);
const EdgeInsets kTopHorizontalSpaceXXXXLarge =
    EdgeInsets.only(left: 56, right: 56, top: 56);

double k5Width(context) => kWidth(context) * 0.05;
double k8Width(context) => kWidth(context) * 0.08;
double k13Width(context) => kWidth(context) * 0.13;
EdgeInsets kAllSpaceSuperSmall = EdgeInsets.all(6);

const double kHundred = 100;
