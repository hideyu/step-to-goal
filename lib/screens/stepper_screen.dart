import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step_to_goal/components/register_item_dialog.dart';
import 'package:step_to_goal/components/stepper_timeline_listview.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';
import 'package:step_to_goal/utils/user_repository.dart';

class StepperScreen extends HookWidget {
  static String id = 'stepper_screen';

  // TODO: プロバイダに移す
  List<Widget> tablist = [Text('Tab1'), Text('Tab2'), Text('Tab3')];

  // 最初にログインしているユーザーを取得
  // @override
  // void initState() {
  //   super.initState();
  //   _loggedInUser = _firebaseHelper.getCurrentUser();
  // }

  @override
  Widget build(BuildContext context) {
    // プロバイダーからUser情報を取得
    // TODO: ログインしてない時はwelcomeにリダイレクト
    final futureAuth = useProvider(authProvider);
    final snapshotAuth = useFuture(futureAuth, initialData: null);
    final futureUser = useProvider(userProvider);
    final snapshotUser = useFuture(futureUser, initialData: null);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
                title: Text("Step To Goal v2"),
                // actions: [],
                bottom: TabBar(tabs: tablist)),
          ),
          body: TabBarView(
            children: [
              StepperTimelineListView(),
              StepperTimelineListView(),
              StepperTimelineListView(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              print("debug is bellow...");

              // _firebaseHelper.dataFetch('1hN0tgOpSetKuT77IrRl');

              // final debugVariable = await _firestore
              //     .collection('steps')
              //     .doc('1hN0tgOpSetKuT77IrRl')
              //     .get();
              // print(debugVariable.data().runtimeType);

              // final mapData =
              //     new Map<String, dynamic>.from(debugVariable.data());
              // print(mapData);

              showDialog(
                context: context,
                builder: (_) {
                  return PopupRegisterDialog(
                    loggedInUser: snapshotUser.data,
                  );
                },
              );
            },
          ),
        ));
  }
}
