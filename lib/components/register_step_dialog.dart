import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class PopupRegisterDialog extends StatefulWidget {
  final User loggedInUser;
  final String goalInThisTab;
  const PopupRegisterDialog(
      {@required this.loggedInUser, @required this.goalInThisTab});

  @override
  _PopupRegisterDialogState createState() => _PopupRegisterDialogState();
}

class _PopupRegisterDialogState extends State<PopupRegisterDialog> {
  FirebaseHelper _firebasehelper = FirebaseHelper();
  // String _goalInput; // ゴールの内容
  String _stepInput; // ステップの内容
  int _stepSize; // ステップのレベル（大中小）
  // int _diffucultyLevel; // ステップのスコア（0~100）
  DateTime _date = new DateTime.now(); // 現在日時
  String _descriptionInput; // 詳細の内容

  String _dateLabel = '日付を選択してください';
  // 日付選択ボタン押した時のイベント
  void onPressedRaisedButton() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime.now()
            .add(new Duration(days: 360))); // TODO: より後年度の値も入れれるようにする

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
                    labelText: 'New Step',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _stepInput = value;
                      print(_stepInput);
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Description(optional)',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _descriptionInput = value;
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
                DropdownButton(
                  isExpanded: true,
                  value: _stepSize,
                  hint: Text("タスクのレベルを選択してね"),
                  items: [
                    DropdownMenuItem(
                      child: Text('大テーマ'),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text('中間目標'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('小タスク'),
                      value: 2,
                    )
                  ],
                  onChanged: (value) {
                    setState(
                      () {
                        _stepSize = value;
                        print(_stepSize);
                      },
                    );
                  },
                ),
                TextButton(
                  child: Text('新しいステップを登録する'),
                  onPressed: () {
                    setState(() {
                      print("hogehoge");

                      _firebasehelper.addStepItems(
                        goalItem: widget.goalInThisTab,
                        stepItem: _stepInput,
                        stepSize: _stepSize,
                        targetDate: _date,
                        // difficultyLevel: _diffucultyLevel,
                        difficultyLevel: 50,
                        loggedInUser: widget.loggedInUser,
                        description: _descriptionInput,
                      );
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
