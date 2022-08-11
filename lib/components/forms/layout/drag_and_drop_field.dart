import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:timesheet/components/buttons/layout/alternate_link_button.dart';
import 'package:timesheet/components/buttons/layout/primary_button.dart';
import 'package:timesheet/components/buttons/layout/secondary_button.dart';
import 'package:timesheet/components/cards/layout/primary_card.dart';
import 'package:timesheet/constants.dart';

class DragAndDropField extends StatefulWidget {
  const DragAndDropField({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<DragAndDropField> createState() => _DragAndDropFieldState();
}

class _DragAndDropFieldState extends State<DragAndDropField> {
  bool highlightColor = false;
  String message = 'Drop file here';
  late DropzoneViewController fileCtrl;

  Widget buildZone(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => fileCtrl = ctrl,
          onLoaded: () => log('Zone 1 loaded'),
          onError: (ev) => log('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlightColor = true);
            log('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlightColor = false);
            log('Zone 1 left');
          },
          onDrop: (ev) async {
            log('Zone 1 drop: ${ev.name}');
            setState(() {
              message = '${ev.name}';
              highlightColor = false;
            });
            final bytes = await fileCtrl.getFileData(ev);
            log(bytes.sublist(0, 20).toString());
          },
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Text(
          widget.title,
          textAlign: TextAlign.start,
        ),
      ),
      if (kIsWeb)
        PrimaryCard(
          height: 100,
          fillColor: highlightColor
              ? kThemeTertitaryBackgroundColor
              : Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              buildZone(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message),
                  AlternateLinkButton(
                      title: 'or',
                      linkName: 'Pick File',
                      onPressed: () async {
                        var file = await fileCtrl
                            .pickFiles(mime: ['image/jpeg', 'image/png']);
                        setState(() {
                          message = '${file.first.name}';
                          highlightColor = false;
                        });
                        // });
                      })
                ],
              ),
            ],
          ),
        ),
    ]);
  }
}
