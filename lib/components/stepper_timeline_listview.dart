import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/components/stepper_timeline_tile.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class StepperTimelineListView extends StatelessWidget {
  final User loggedInUser;
  final FirebaseFirestore _firestore;

  const StepperTimelineListView(
      {@required this.loggedInUser, @required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('steps').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final stepItems = snapshot.data.docs;

          List<StepperTimelineTile> stepListWidgets = [];
          // TODO; loggedInUserのdataだけを取得する
          // TODO: リファクター
          for (var stepItem in stepItems) {
            final stepItemTitle = stepItem.data()[FirebaseDataMap.step];
            final stepDifficultyLevel =
                stepItem.data()[FirebaseDataMap.difficultyLevel];
            final stepTargetDate =
                stepItem.data()[FirebaseDataMap.targetDate].toDate();
            final stepIsDone = stepItem.data()[FirebaseDataMap.isDone];

            final stepItemWidget = StepperTimelineTile(
                stepText: Text(
                    '$stepItemTitle, $stepDifficultyLevel, $stepTargetDate, $stepIsDone'));
            stepListWidgets.add(stepItemWidget);
          }
          return ListView(
            children: stepListWidgets,
          );
        }
        // TODO; Firebaseからのデータ取得時のエラーハンドリング
        return Container(
          child: Text("data fetch is failed"),
        );
      },
    );
  }
}
