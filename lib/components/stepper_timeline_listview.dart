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

          // List<StepperTimelineTile> stepListWidgets = [];
          List<Widget> stepListWidgets = [
            Divider(),
            Text("デバッグ"),
            // Text("$loggedInUser"),
            Divider(),
          ];
          // TODO; loggedInUserのdataだけを取得する
          for (var stepItem in stepItems) {
            // TODO: Firestoreからデータの各値を取得、もっといい書き方がある気がする、後でリファクター
            final stepSnapshot = stepItem.data();
            final stepItemTitle = stepSnapshot[FirebaseDataMap.step];
            final stepDifficultyLevel =
                stepSnapshot[FirebaseDataMap.difficultyLevel];
            final stepTargetDate =
                stepSnapshot[FirebaseDataMap.targetDate].toDate();
            final stepIsDone = stepSnapshot[FirebaseDataMap.isDone];

            final stepId = stepItem.reference.id; //documentIdを取得して子widgetに渡す
            final stepMapData = Map<String, dynamic>.from(
                stepSnapshot); // Firestoreのデータをマップに変換して子widgetに渡す

            final stepItemWidget = StepperTimelineTile(
              stepText: Text(
                  '$stepItemTitle, $stepDifficultyLevel, $stepTargetDate, $stepIsDone'),
              documentId: stepId,
              isDoneNow: stepIsDone,
              stepMapData: stepMapData,
              loggedInUser: loggedInUser,
            );
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
