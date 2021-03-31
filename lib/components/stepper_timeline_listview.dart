import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:step_to_goal/components/stepper_timeline_tile.dart';

class StepperTimelineListView extends HookWidget {
  final List<Map<String, dynamic>> stepMapList;
  final Map<String, dynamic> goalMap;
  StepperTimelineListView({
    @required this.stepMapList,
    @required this.goalMap,
  });

  @override
  Widget build(BuildContext context) {
    if (goalMap != null) {
      List<Widget> stepListWidgets = [];
      String position;

      if (stepMapList.length > 0) {
        for (var stepItem in stepMapList) {
          // stepMapListはプロバイダから情報を取得する際に日付順にソートされるので、最初（=0）の値を識別する
          // TODO: enumでやったほうが良さそうだしもっといい書き方がある気がする
          if (stepItem == stepMapList[0]) {
            print("this is first step, ${stepItem['step']}");
            position = "first";
          } else {
            print("this is mid step");
            position = "mid";
          }

          // stepデータ全体のリストから一つずつ要素を取り出して子widgetに渡す
          final stepItemWidget = StepperTimelineTile(
            stepItem: stepItem,
            position: position,
          );
          stepListWidgets.add(stepItemWidget);
        }
      }
      // ステップリストの末尾にゴールタイルも追加する
      final finalStepItemWidget = StepperTimelineTile(
        goalItem: goalMap,
        position: "last",
      );
      stepListWidgets.add(finalStepItemWidget);

      return ListView(
        children: stepListWidgets,
      );
    }

    // TODO; Firebaseからのデータ取得時のエラーハンドリング
    return Container(
      child: Text("data fetch is failed or no data is registered."),
    );
  }
}
