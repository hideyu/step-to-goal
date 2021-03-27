import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:step_to_goal/utils/user_repository.dart';

// ******************************************
// Repository: データをFirestoreから出し入れする
// ******************************************
// StepListプロバイダー
final stepListStreamProvider = StreamProvider.autoDispose((_) {
  // TODO: ログインユーザーのデータのみを取得する
  User loggedInUser;
  try {
    User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      loggedInUser = currentUser;
    }
  } catch (e) {
    // TODO: エラーハンドリング
    print(e);
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('steps');
  Query query = ref.where('user', isEqualTo: loggedInUser.email); // クエリを追加
  return query.snapshots().map((snapshot) => snapshot.docs.map(
        (doc) {
          // documentIdもMapの変数として格納する{documentId: xxx, isDone: false, ...}
          // TODO: 他にもっといいやり方があるかも？
          String documentId = doc.id;
          Map<String, dynamic> documentMap = doc.data();
          documentMap["documentId"] = documentId;
          return documentMap;
        },
      )
          // .map((doc) => doc.data())
          .toList());
});

// ***************************************************************
// Presenter: Viewを制御する（データを加工する場合はここで加工して出力する）
// ***************************************************************
final stepListProvider = Provider.autoDispose((ref) async {
  // Repositoryからデータを取得する。最新の情報をwatchする。
  final futureStepList = ref.watch(stepListStreamProvider.last);
  // Future<List<Member>>なので、値を取得できるまで待つ。
  final stepList = await futureStepList;

  // TODO: 日付順にソート
  // 該当するユーザーのデータのみ抽出
  stepList.sort((a, b) {
    var aDate = a['targetDate']; //before -> var adate = a.expiry;
    var bDate = b['targetDate']; //var bdate = b.expiry;
    return -bDate.compareTo(aDate);
  });

  return stepList;
  // AsyncSnapshot<List<Map<String, dynamic>>>(ConnectionState.done, [{isDone: false, targetDate: Timestamp(seconds=1615993200, nanoseconds=0), stepSize: 0, goal: make a cake, difficultyLevel: 50, step: do something, user: hogehoge@hog.com},{...}])
});
