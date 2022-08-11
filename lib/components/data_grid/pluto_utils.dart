import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants.dart';

PlutoGridStyleConfig kGridStyle1 = PlutoGridStyleConfig(
    rowColor: kThemeSecondaryBackgroundColor,
    gridBorderColor: kHeaderFontColor.withOpacity(0.0),
    cellColorInEditState: kThemeSecondaryBackgroundColor,
    columnTextStyle: kHeader4TextStyle,
    cellTextStyle: kBody2TextStyle.copyWith(color: kPrimaryFontColor),
    activatedBorderColor: kThemeColor,
    activatedColor: kThemeTertitaryBackgroundColor,
    borderColor: kThemeFontColor);

PlutoGridColumnSizeConfig kColumnSizeConfig =
    const PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.scale);

PlutoGridConfiguration kGirdConfig = PlutoGridConfiguration(
    scrollbar: const PlutoGridScrollbarConfig(isAlwaysShown: true),
    columnSize: kColumnSizeConfig,
    style: kGridStyle1);

PlutoColumn textColumn(title, fieldName,
    {enableEditingMode = false,
    width = 100,
    enableSorting = false,
    enableDropToResize = false}) {
  return PlutoColumn(
      title: title,
      field: fieldName,
      width: width,
      enableContextMenu: false,
      enableDropToResize: enableDropToResize,
      enableColumnDrag: false,
      enableSorting: enableSorting,
      titlePadding: kHorizontalSpaceSmall,
      backgroundColor: kThemeSecondaryBackgroundColor,
      type: PlutoColumnType.text(),
      readOnly: !enableEditingMode,
      enableEditingMode: enableEditingMode);
}

PlutoColumn textColummFixed(title, fieldName,
    {width = 100,
    backgroundColor = kThemeSecondaryBackgroundColor,
    textAlign = PlutoColumnTextAlign.center,
    titleTextAlign = PlutoColumnTextAlign.center,
    enableDropToResize = false,
    hide = false}) {
  return PlutoColumn(
    title: title,
    field: fieldName,
    width: width,
    textAlign: textAlign,
    titleTextAlign: titleTextAlign,
    enableContextMenu: false,
    enableDropToResize: enableDropToResize,
    enableColumnDrag: false,
    enableEditingMode: false,
    enableSorting: false,
    hide: hide,
    titlePadding: kHorizontalSpaceSmall,
    backgroundColor: backgroundColor,
    type: PlutoColumnType.text(),
  );
}

PlutoColumn selectionColumn(title, fieldName, listItems, {width = 100}) {
  return PlutoColumn(
      width: width,
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      enableSorting: false,
      titlePadding: kHorizontalSpaceSmall,
      backgroundColor: kThemeSecondaryBackgroundColor,
      title: title,
      field: fieldName,
      type: PlutoColumnType.select(listItems));
}
