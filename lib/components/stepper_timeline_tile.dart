import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:step_to_goal/components/detail_item_dialog.dart';
import 'package:step_to_goal/constants/constants.dart';
import 'package:step_to_goal/utils/hexcolor_helper.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperTimelineTile extends HookWidget {
  final Map<String, dynamic> stepItem;
  final String position;
  // final User user;
  StepperTimelineTile({@required this.stepItem, @required this.position});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('MM/dd').format(stepItem["targetDate"].toDate());

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
              color: HexColor(kBrandColor),
              width: 20,
              indicatorXY: 0.3,
              // indicator: Image.asset('images/nowStep.svg'),
            ),
            beforeLineStyle: LineStyle(color: HexColor(kSupplementalColor)),
            afterLineStyle: LineStyle(color: HexColor(kSupplementalColor)),
            alignment: TimelineAlign.manual,
            lineXY: 0.15,
            isFirst: position == "first",
            isLast: position == "last",
            startChild: Center(
              child: Container(
                // color: Colors.blue,
                child: Column(
                  children: [
                    // Container(
                    //   height: 16,
                    //   color: Colors.green,
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "$formattedDate",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            endChild: Container(
              // color: Colors.green,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // color: Colors.pink,
                        child: Text(
                          "${stepItem['step']}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: HexColor(kFontColorLight)),
                        ),
                        // color: Colors.blue,
                      ),
                      Container(
                        child: Text(
                          "hgoehogeaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                              fontSize: 16, color: HexColor(kFontColorLight)),
                        ),
                      ),
                      Container(
                        child: Text(
                          "hgoehogeaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                              fontSize: 16, color: HexColor(kFontColorLight)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
            // endChild: Row(
            //   children: [
            //     SizedBox(
            //       width: 10,
            //       height: 50,
            //     ),
            //     // widget.stepText,
            //     Column(
            //       children: [
            //         Text(
            //             "${stepItem['step']}, ${stepItem['isDone']}. ${stepItem['user']}"),
            //         Text("hogehoge")
            //       ],
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
