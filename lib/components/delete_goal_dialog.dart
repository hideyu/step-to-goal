import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';
import 'package:step_to_goal/utils/user_repository.dart';

class PopupDeleteGoalDialog extends HookWidget {
  final Map<String, dynamic> goalItem;
  PopupDeleteGoalDialog({@required this.goalItem});

  @override
  Widget build(BuildContext context) {
    // TODO: Helper関数もProviderに組み込んだ方がいいか？
    FirebaseHelper _firebaseHelper = FirebaseHelper();

    // ************
    // contextを取得
    // ************
    final context = useContext();

    // ***********************
    // プロバイダーから情報を取得
    // ***********************
    // User情報を取得
    final futureUser = useProvider(userProvider);
    final snapshotUser = useFuture(futureUser, initialData: null);

    return AlertDialog(
      title: Text("関連のステップも一緒に削除されます。元に戻せません。本当に削除しますか？"),
      actions: [
        TextButton(
          onPressed: () {
            _firebaseHelper.deleteGoalItems(
                documentId: goalItem["documentId"],
                loggedInUser: snapshotUser.data);
            print("deleted!!!");
            int count = 0;
            Navigator.popUntil(context, (_) => count++ >= 2);
          },
          child: Text("削除"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("削除しない"),
        )
      ],
    );
  }
}
