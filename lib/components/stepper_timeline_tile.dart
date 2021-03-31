import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:step_to_goal/components/detail_goal_dialog.dart';
import 'package:step_to_goal/components/detail_step_dialog.dart';
import 'package:step_to_goal/components/stepper_icon.dart';
import 'package:step_to_goal/constants/constants.dart';
import 'package:step_to_goal/utils/hexcolor_helper.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperTimelineTile extends HookWidget {
  final Map<String, dynamic> stepItem;
  final Map<String, dynamic> goalItem;
  final String position;
  // ステップかゴールのどちらかの引数をとる
  StepperTimelineTile({this.stepItem, this.goalItem, @required this.position});

  @override
  Widget build(BuildContext context) {
    // 受け取る引数がゴールなのかステップなのかによって変数の中身を変える
    // TODO: リファクター（useState？）
    bool isGoal = goalItem != null;
    DateTime date = isGoal
        ? goalItem['goalDate'].toDate()
        : stepItem['targetDate'].toDate();
    String formattedDate = DateFormat('MM/dd').format(date);
    bool isDone = isGoal ? goalItem['goalIsDone'] : stepItem['isDone'];
    String title = isGoal ? goalItem['goalTitle'] : stepItem['step'];

    return Container(
      // color: Colors.blue.shade50,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          // highlightColor: Colors.redAccent,
          // splashColor: Colors.red,
          onTap: () {
            showDialog(
              context: context,
              // barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return isGoal
                    ? PopupGoalDetailDialog(goalItem: goalItem)
                    : PopupStepDetailDialog(stepItem: stepItem);
              },
            );
          },
          child: TimelineTile(
            indicatorStyle: IndicatorStyle(
                color: HexColor(kBrandColor),
                width: 30,
                height: 30,
                indicatorXY: 0.3,
                indicator: StepperIcon(
                  isDone: isDone,
                  // targetDate: stepItem['targetDate'].toDate(),
                  targetDate: date,
                  stepSize: 0,
                ),
                padding: EdgeInsets.symmetric(vertical: 5)),
            beforeLineStyle:
                LineStyle(color: HexColor(kSupplementalColor), thickness: 3),
            afterLineStyle:
                LineStyle(color: HexColor(kSupplementalColor), thickness: 3),
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
                          title,
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
          ),
        ),
      ),
    );
  }
}
