import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step_to_goal/components/register_goal_dialog.dart';
import 'package:step_to_goal/components/register_step_dialog.dart';
import 'package:step_to_goal/components/stepper_timeline_listview.dart';
import 'package:step_to_goal/utils/goal_repository.dart';
import 'package:step_to_goal/utils/step_repository.dart';
import 'package:step_to_goal/utils/user_repository.dart';

class StepperScreen extends HookWidget {
  static String id = 'stepper_screen';

  @override
  Widget build(BuildContext context) {
    // ***********************
    // プロバイダーから情報を取得
    // ***********************
    // TODO: ログインしてない時はwelcomeにリダイレクト
    // auth情報を取得
    // final futureAuth = useProvider(authProvider);
    // final snapshotAuth = useFuture(futureAuth, initialData: null);
    // user情報を取得
    final futureUser = useProvider(userProvider);
    final snapshotUser = useFuture(futureUser, initialData: null);
    // goal情報を取得
    final futureGoal = useProvider(goalListProvider);
    final snapshotGoal = useFuture(futureGoal, initialData: null);
    // step情報を取得する
    final futureStepList = useProvider(stepListProvider);
    final snapshotStepList = useFuture(futureStepList, initialData: null);

    // *******************************************
    // Firestoreからgoalを取得してTabのリストを作成する
    // *******************************************
    List<Widget> tabList = [];
    List<Widget> tabBarViewList = [];
    List<DocumentReference> goalReferenceList = [];
    snapshotGoal.data.forEach((goalMap) {
      // タブに表示するためのリストを作成する
      tabList.add(Text('${goalMap['goalTitle']}'));

      //  そのゴールのDocumentReferenceを取得しリストに格納する
      // TODO: ヘルパーに移動（）リファクタ
      final goalDocumentReference = FirebaseFirestore.instance
          .collection("goals")
          .doc(goalMap['documentId']);
      goalReferenceList.add(goalDocumentReference);

      // そのゴールのDocumentReferenceを使って関連するステップを取得し、リストに格納
      final filteredStepList = snapshotStepList.data
          .where((stepMap) => stepMap["goalReference"] == goalDocumentReference)
          .toList();

      // StepperTimelineListViewにはステップリストとゴールを渡す
      tabBarViewList.add(StepperTimelineListView(
        stepMapList: filteredStepList,
        goalMap: goalMap,
      ));
    });

    // TODO: 読み込み中のくるくる
    return DefaultTabController(
        length: snapshotGoal.data.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context);
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.0),
                child: AppBar(
                    title: Text("Step To Goal v2"),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // print(
                            //     "${tabController.index}: ${tabTitleList[tabController.index]}");
                            showDialog(
                              context: context,
                              builder: (_) {
                                return PopupRegisterGoalDialog(
                                  loggedInUser: snapshotUser.data,
                                );
                              },
                            );
                          })
                    ],
                    bottom: TabBar(
                      tabs: tabList,
                      isScrollable: true,
                    )),
              ),
              body: TabBarView(
                children: tabBarViewList,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return PopupRegisterStepDialog(
                        loggedInUser: snapshotUser.data,
                        goalReference: goalReferenceList[tabController.index],
                      );
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}
