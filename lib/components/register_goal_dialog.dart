import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class PopupRegisterGoalDialog extends StatefulWidget {
  final User loggedInUser;
  const PopupRegisterGoalDialog({this.loggedInUser});

  @override
  _PopupRegisterGoalDialogState createState() =>
      _PopupRegisterGoalDialogState();
}

class _PopupRegisterGoalDialogState extends State<PopupRegisterGoalDialog> {
  FirebaseHelper _firebasehelper = FirebaseHelper();
  String _goalInput; // ゴールの内容
  DateTime _date = new DateTime.now(); // 現在日時

  String _dateLabel = '日付を選択してください';
  // 日付選択ボタン押した時のイベント
  void onPressedRaisedButton() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    // TODO: より後年度の値も入れれるようにする

    if (picked != null) {
      // 日時の反映
      setState(() {
        _date = picked;
        _dateLabel = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children: [
                Text(
                  "You can make cool stuff!",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'New Goal',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _goalInput = value;
                      print(_goalInput);
                    });
                  },
                ),
                Row(
                  children: [
                    Text(_dateLabel),
                    RaisedButton(
                      onPressed: () {
                        // 押した時のイベントを宣言。
                        onPressedRaisedButton();
                      },
                      child: Text('日付を選択'),
                    ),
                  ],
                ),
                TextButton(
                  child: Text('新しいゴールを登録する'),
                  onPressed: () {
                    setState(() {
                      _firebasehelper.addStepItems(
                        goalItem: _goalInput,
                        stepItem: _goalInput,
                        stepSize: 4,
                        targetDate: _date,
                        // difficultyLevel: _diffucultyLevel,
                        difficultyLevel: 100,
                        loggedInUser: widget.loggedInUser,
                      );

                      // _firebasehelper.addGoalItems(
                      //   goalItem: _goalInput,
                      //   goalDate: _date,
                      //   loggedInUser: widget.loggedInUser,
                      // );
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
