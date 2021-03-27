import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:step_to_goal/components/stepper_timeline_tile.dart';

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

      for (var stepItem in stepMapList) {
        // stepデータ全体のリストから一つずつ要素を取り出して子widgetに渡す
        final stepItemWidget = StepperTimelineTile(
          stepItem: stepItem,
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
