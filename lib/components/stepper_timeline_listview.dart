import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:step_to_goal/components/stepper_timeline_tile.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class StepperTimelineListView extends HookWidget {
  final List stepMapList;
  StepperTimelineListView({@required this.stepMapList});

  @override
  Widget build(BuildContext context) {
    if (stepMapList.length > 0) {
      print("stepMapList is ${stepMapList.runtimeType}");
      print("stepMapList length is ${stepMapList.length}");

      List<Widget> stepListWidgets = [
        // Divider(),
        // Text("デバッグ"),
        // Text("${snapshotUser.data}"),
        // Divider(),
      ];
      String position;

      for (var stepItem in stepMapList) {
        // stepMapListはプロバイダから情報を取得する際に日付順にソートされるので、
        // ここでは最初（=0）と最後（=stepMapList.length-1）の値を識別する
        // TODO: enumでやったほうが良さそうだしループ文ももっといい書き方がある気がする
        if (stepItem == stepMapList[0]) {
          print("this is first step, ${stepItem['step']}");
          position = "first";
        } else if (stepItem == stepMapList[stepMapList.length - 1]) {
          print("this is last step, which mean the goal!! ${stepItem['step']}");
          position = "last";
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
