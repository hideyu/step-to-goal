import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:step_to_goal/components/delete_goal_dialog.dart';
import 'package:step_to_goal/components/edit_goal_dialog.dart';
import 'package:step_to_goal/components/edit_step_dialog.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class PopupGoalDetailDialog extends HookWidget {
  final Map<String, dynamic> goalItem;
  PopupGoalDetailDialog({@required this.goalItem});

  @override
  Widget build(BuildContext context) {
    // TODO: Helper関数もProviderに組み込んだ方がいいか？
    FirebaseHelper _firebaseHelper = FirebaseHelper();

    // ************
    // contextを取得
    // ************
    final context = useContext();

    return AlertDialog(
      title: Column(
        children: [
          Text(
            "step: ${goalItem['goalTitle']}",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "description: ${goalItem['goalDescription']}",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "isDone: ${goalItem['goalIsDone']}",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "ID: ${goalItem['documentId']}",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: goalItem["goalIsDone"] ? Text('Doneじゃない') : Text('Done'),
          onPressed: () {
            _firebaseHelper.toggleGoalIsDone(
                isDoneNow: goalItem["goalIsDone"],
                documentId: goalItem["documentId"]);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            'Edit',
          ),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return PopupEditGoalDialog(goalMapData: goalItem);
              },
            );
          },
        ),
        TextButton(
          child: Text(
            'Delete',
          ),
          onPressed: () {
            showDialog(
              context: context,
              // barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return PopupDeleteGoalDialog(goalItem: goalItem);
              },
            );
          },
        ),
      ],
    );
  }
}
