import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step_to_goal/utils/goal_repository.dart';
import 'package:step_to_goal/utils/step_repository.dart';

class TestScreen extends HookWidget {
  static String id = 'test_screen';

  @override
  Widget build(BuildContext context) {
    final futureGoalList = useProvider(goalListProvider);
    final goalSnapshot = useFuture(futureGoalList, initialData: null);

    final futurestepList = useProvider(stepListProvider);
    final stepSnapshot = useFuture(futurestepList, initialData: null);
    // final futureUser = useProvider(userProvider);
    // final snapshot = useFuture(futureUser, initialData: null);
    // print(futureUser);
    // final stateForm = useProvider(formInputProvider.state);
    // final formInput = useProvider(formInputProvider);
    // int hoge = stateForm.inputMap["stepSize"];
    // hoge = 40;

    // DateTime now = DateTime.now();
    // DateTime today = DateTime(now.year, now.month, now.day);
    // DateTime tommorow = DateTime(now.year, now.month, now.day + 1);
    // var compared =
    // now.difference(tommorow).inDays == 0 && now.day == tommorow.day;

    final goalDocReference = stepSnapshot.data[0]["goalReference"];
    final goalFutureSnapshot = goalDocReference.get();

    final ref = FirebaseFirestore.instance
        .collection("goals")
        .doc("NaSX7VapDIFKi33iI8wV");
    Query step = FirebaseFirestore.instance
        .collection("steps")
        .where('goalReference', isEqualTo: ref);
    final stepGet = step.get();

    return Scaffold(
      appBar: AppBar(
        title: Text("this is test"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(step);

          print(stepGet);

          var stepData = await stepGet;
          print(stepData.docs[0].id);
          // var goalData = await goalFutureSnapshot;
          // print("${stepSnapshot.data[0]["goalReference"]}");
          // print(goalData.data());
        },
      ),
      body: Column(
        children: [
          Container(
            child: Text("${goalSnapshot.data[0]}"),
          ),
          Container(
            child: Text("${stepSnapshot.data[0]}"),
          ),
        ],
      ),
    );
  }
}
