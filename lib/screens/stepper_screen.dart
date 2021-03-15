import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/components/stepper_timeline_listview.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class StepperScreen extends StatefulWidget {
  static String id = 'stepper_screen';

  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  final _firestore = FirebaseFirestore.instance;
  User _loggedInUser;
  List<Widget> tablist = [Text('Tab1'), Text('Tab2'), Text('Tab3')];

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
                bottom: TabBar(tabs: tablist)),
          ),
          body: TabBarView(
            children: [
              StepperTimelineListView(
                  loggedInUser: _loggedInUser, firestore: _firestore),
              StepperTimelineListView(
                  loggedInUser: _loggedInUser, firestore: _firestore),
              StepperTimelineListView(
                  loggedInUser: _loggedInUser, firestore: _firestore),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (_) {
              //     return AlertDialog(
              //       title: Text("タイトル"),
              //       insetPadding: EdgeInsets.symmetric(horizontal: 5),
              //       content: SingleChildScrollView(
              //         child: ListBody(
              //           children: <Widget>[
              //             Text('This is a demo alert dialog.'),
              //             Text('Would you like to approve of this message?'),
              //           ],
              //         ),
              //       ),
              //       // Text("メッセージメッセージメッセージメッセージメッセージメッセージ"),
              //       actions: <Widget>[
              //         // ボタン領域
              //         TextButton(
              //           child: Text('Approve'),
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // );
              showDialog(
                context: context,
                builder: (_) {
                  return PopupRegisterDialog();
                },
              );
            },
          ),
        ));
  }
}

class PopupRegisterDialog extends StatefulWidget {
  @override
  _PopupRegisterDialogState createState() => _PopupRegisterDialogState();
}

class _PopupRegisterDialogState extends State<PopupRegisterDialog> {
  FirebaseHelper _firebasehelper = FirebaseHelper();
  User _loggedInUser;
  final now = DateTime.now();

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
            child: Text(
              "You can make cool stuff!",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            child: Text('登録する'),
            onPressed: () {
              setState(() {
                print("hogehoge");
                _firebasehelper.addStepItems(
                    goalItem: "make a cake",
                    stepItem: "buy water",
                    stepSize: 2,
                    targetDate: now,
                    difficultyLevel: 100,
                    loggedInUser: _loggedInUser);
              });
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
