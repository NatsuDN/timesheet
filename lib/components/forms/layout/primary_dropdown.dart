import 'package:flutter/material.dart';
import 'package:timesheet/constants.dart';

class PrimaryDropDown extends StatefulWidget {
  const PrimaryDropDown(
      {Key? key,
      this.items = const [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
        'Item 5',
      ],
      this.defaultValue = 'Item 1',
      this.padding = kAllSpaceSmall,
      this.focusBorderColor = kThemeColor,
      this.onChanged,
      required this.title,
      this.decoration})
      : super(key: key);
  final List<String> items;
  final String title;
  final InputDecoration? decoration;
  final String defaultValue;
  final Function(String)? onChanged;
  final Color focusBorderColor;
  final EdgeInsetsGeometry padding;
  @override
  State<PrimaryDropDown> createState() => _PrimaryDropDownState();
}

class _PrimaryDropDownState extends State<PrimaryDropDown> {
  late String dropdownvalue;

  // List of items in our dropdown menu
  late List<String> items;
  late Function(String)? onChanged;
  late InputDecoration? decoration;
  late String title;
  late Color focusBorderColor;
  @override
  void initState() {
    dropdownvalue = widget.defaultValue;
    items = widget.items;
    onChanged = widget.onChanged;
    decoration = widget.decoration;
    title = widget.title;
    focusBorderColor = widget.focusBorderColor;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container();
    }
    return Padding(
      padding: widget.padding,
      child: DropdownButtonFormField(
        decoration: decoration ??
            kTextFieldDecorationWithLabelText(title, color: focusBorderColor),

        style: kBodyTextStyle,
        isExpanded: true,
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
          onChanged?.call(newValue!);
        },
      ),
    );
  }
}
