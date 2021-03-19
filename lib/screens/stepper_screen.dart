import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/components/register_item_dialog.dart';
import 'package:step_to_goal/components/stepper_timeline_listview.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';

class StepperScreen extends StatefulWidget {
  static String id = 'stepper_screen';

  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  FirebaseHelper _firebaseHelper = FirebaseHelper();
  final _firestore = FirebaseFirestore.instance;
  User _loggedInUser;
  List<Widget> tablist = [Text('Tab1'), Text('Tab2'), Text('Tab3')];

  // 最初にログインしているユーザーを取得
  // TODO: ログインしてない時はwelcomeにリダイレクト
  @override
  void initState() {
    super.initState();
    _loggedInUser = _firebaseHelper.getCurrentUser();
  }

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
            onPressed: () async {
              // _firebaseHelper.dataFetch('1hN0tgOpSetKuT77IrRl');
              final debugVariable = await _firestore
                  .collection('steps')
                  .doc('1hN0tgOpSetKuT77IrRl')
                  .get();
              print(debugVariable.data().runtimeType);

              final mapData =
                  new Map<String, dynamic>.from(debugVariable.data());
              print(mapData);
              // print("debug is bellow...");
              // showDialog(
              //   context: context,
              //   builder: (_) {
              //     return PopupRegisterDialog(
              //       loggedInUser: _loggedInUser,
              //     );
              //   },
              // );
            },
          ),
        ));
  }
}
