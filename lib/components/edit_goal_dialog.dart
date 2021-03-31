import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class PopupEditGoalDialog extends StatefulWidget {
  final Map<String, dynamic> goalMapData;
  PopupEditGoalDialog({@required this.goalMapData});

  @override
  _PopupEditGoalDialogState createState() => _PopupEditGoalDialogState();
}

class _PopupEditGoalDialogState extends State<PopupEditGoalDialog> {
  FirebaseHelper _firebasehelper = FirebaseHelper();

  // TODO: リファクター（プロバイダー使いたいけどよくわからない）
  // *************************
  // Input Field用の変数(state)
  // *************************
  String _goalTitleInput; // ゴールの内容
  String _goalDescriptionInput; // ゴール詳細の内容

  DateTime _date; // 現在日時
  String _dateLabel = '日付を選択してください';
  User loggedInUser; // ログインユーザー取得用

  // ***************************************
  // initState()
  // ログインユーザーの取得（本当はプロバイダ使う）
  // 初期値は現時点で登録されているデータを格納する
  // ***************************************
  @override
  void initState() {
    super.initState();

    setState(() {
      loggedInUser = FirebaseAuth.instance.currentUser;

      _goalTitleInput = widget.goalMapData[FirebaseDataMap.goalTitle];
      _goalDescriptionInput =
          widget.goalMapData[FirebaseDataMap.goalDescription];
      _date = widget.goalMapData[FirebaseDataMap.goalDate].toDate();
      _dateLabel = _date.toString();
    });
  }

  // ***************************************
  // 自前の関数定義
  // 日付選択ボタンを押した時のイベント
  // ***************************************
  void onPressedRaisedButton() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.goalMapData["goalDate"].toDate(),
      firstDate: new DateTime(2021),
      lastDate: new DateTime.now().add(
        new Duration(days: 360),
      ),
    );
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
    // final stateForm = useProvider(formInputProvider.state);
    // final formInput = useProvider(formInputProvider);

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
                  "Goalを編集する",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: _goalTitleInput,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _goalTitleInput = value;
                      print(_goalTitleInput);
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: _goalDescriptionInput,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _goalDescriptionInput = value;
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
                Row(
                  children: [
                    TextButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('ステップを編集する'),
                      onPressed: () {
                        setState(() {
                          _firebasehelper.editGoalItems(
                            goalTitleInput: _goalTitleInput,
                            goalDescription: _goalDescriptionInput,
                            goalDate: _date,
                            loggedInUser: loggedInUser,
                            documentId: widget.goalMapData["documentId"],
                          );
                        });
                        int count = 0;
                        Navigator.popUntil(context, (_) => count++ >= 2);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
