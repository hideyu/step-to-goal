import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperScreen extends StatefulWidget {
  static String id = 'stepper_screen';

  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  List<Widget> Tablist = [Text('Tab1'), Text('Tab2'), Text('Tab3')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
              title: Text("Step To Goal"),
              // actions: [],
              bottom: TabBar(tabs: Tablist)),
        ),
        body: TabBarView(
          children: [
            StepperBodyScreen(),
            StepperBodyScreen(),
            StepperBodyScreen(),
          ],
        ),
      ),
    );
  }
}

class StepperBodyScreen extends StatefulWidget {
  @override
  _StepperBodyScreenState createState() => _StepperBodyScreenState();
}

class _StepperBodyScreenState extends State<StepperBodyScreen> {
  final _firestore = FirebaseFirestore.instance;
  User _loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StepperTimelineListView(
      firestore: _firestore,
      loggedInUser: _loggedInUser,
    );
  }
}

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

class StepperTimelineTile extends StatefulWidget {
  final Widget stepText;

  const StepperTimelineTile({@required this.stepText});

  @override
  _StepperTimelineTileState createState() => _StepperTimelineTileState();
}

class _StepperTimelineTileState extends State<StepperTimelineTile> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
        indicatorStyle: IndicatorStyle(
          color: Colors.blue,
          width: 20,
        ),
        endChild: Row(
          children: [
            SizedBox(
              width: 10,
              height: 50,
            ),
            widget.stepText,
          ],
        )
        // endChild: Container(
        //   height: 85.0,
        //   child: Text('hogehgoe'),
        //   color: Colors.green,
        // ),
        );
  }
}
