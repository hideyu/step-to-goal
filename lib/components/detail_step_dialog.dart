import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:step_to_goal/components/delete_step_dialog.dart';
import 'package:step_to_goal/components/edit_step_dialog.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class PopupStepDetailDialog extends HookWidget {
  final Map<String, dynamic> stepItem;
  PopupStepDetailDialog({@required this.stepItem});

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
            "step: ${stepItem['step']}",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "description: ${stepItem['description']}",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "isDone: ${stepItem['isDone']}",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "ID: ${stepItem['documentId']}",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: stepItem["isDone"] ? Text('Doneじゃない') : Text('Done'),
          onPressed: () {
            _firebaseHelper.toggleStepIsDone(
                isDoneNow: stepItem["isDone"],
                documentId: stepItem["documentId"]);
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
                return PopupEditStepDialog(stepMapData: stepItem);
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
                return PopupDeleteStepDialog(stepItem: stepItem);
              },
            );
          },
        ),
      ],
    );
  }
}
