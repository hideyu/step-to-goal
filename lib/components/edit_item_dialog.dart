import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class PopupEditDialog extends StatefulWidget {
  final Map<String, dynamic> stepMapData;
  PopupEditDialog({@required this.stepMapData});

  @override
  _PopupEditDialogState createState() => _PopupEditDialogState();
}

class _PopupEditDialogState extends State<PopupEditDialog> {
  FirebaseHelper _firebasehelper = FirebaseHelper();

  // TODO: リファクター（プロバイダー使いたいけどよくわからない）
  // *************************
  // Input Field用の変数(state)
  // *************************
  String _goalInput; // ゴールの内容
  String _stepInput; // ステップの内容
  int _stepSize; // ステップのレベル（大中小）
  int _diffucultyLevel; // ステップのスコア（0~100）
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

      _goalInput = widget.stepMapData[FirebaseDataMap.goal];
      _stepInput = widget.stepMapData[FirebaseDataMap.step];
      _stepSize = widget.stepMapData[FirebaseDataMap.stepSize];
      _diffucultyLevel = widget.stepMapData[FirebaseDataMap.difficultyLevel];
      _date = widget.stepMapData[FirebaseDataMap.targetDate].toDate();
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
      initialDate: widget.stepMapData["targetDate"].toDate(),
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
                  "Stepを編集する",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: _stepInput,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _stepInput = value;
                      print(_stepInput);
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
                          _firebasehelper.editStepItems(
                            goalItem: _goalInput,
                            stepItem: _stepInput,
                            stepSize: _stepSize,
                            targetDate: _date,
                            difficultyLevel: _diffucultyLevel,
                            // difficultyLevel: 50,
                            loggedInUser: loggedInUser,
                            documentId: widget.stepMapData["documentId"],
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
