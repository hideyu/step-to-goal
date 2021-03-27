import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:step_to_goal/components/detail_item_dialog.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperTimelineTile extends HookWidget {
  final Map<String, dynamic> stepItem;
  // final User user;
  StepperTimelineTile({@required this.stepItem});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy/MM/dd').format(stepItem["targetDate"].toDate());

    return Container(
      // color: Colors.blue.shade50,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          highlightColor: Colors.redAccent,
          splashColor: Colors.red,
          onTap: () {
            showDialog(
              context: context,
              // barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return PopupDetailDialog(
                  stepItem: stepItem,
                );
              },
            );
          },
          child: TimelineTile(
            indicatorStyle: IndicatorStyle(
              color: Colors.red,
              width: 20,
            ),
            endChild: Row(
              children: [
                SizedBox(
                  width: 10,
                  height: 50,
                ),
                // widget.stepText,
                Text(
                    "${stepItem['step']}, ${stepItem['isDone']}, $formattedDate. ${stepItem['user']}"),
              ],
            ),
            // endChild: Container(
            //   height: 85.0,
            //   child: Text('hogehgoe'),
            //   color: Colors.green,
            // ),
          ),
        ),
      ),
    );
  }
}
