import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

// ******************************************
// Repository: データをFirestoreから出し入れする
// ******************************************
// GoalListプロバイダー
final goalListStreamProvider = StreamProvider.autoDispose((_) {
  // TODO: ログインユーザーのデータを取得するときにプロバイダを使う？
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

  // TODO: 該当するゴールのやつだけ取得する
  CollectionReference ref = FirebaseFirestore.instance.collection('steps');
  Query query = ref
      .where('user', isEqualTo: loggedInUser.email)
      .where('stepSize', isEqualTo: 4); // クエリを追加
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

//   CollectionReference ref = FirebaseFirestore.instance.collection('goals');
//   Query query = ref.where('goalUser', isEqualTo: loggedInUser.email); // クエリを追加
//   return query.snapshots().map((snapshot) => snapshot.docs.map(
//         (doc) {
//           // documentIdもMapの変数として格納する{documentId: xxx, isDone: false, ...}
//           // TODO: 他にもっといいやり方があるかも？
//           String documentId = doc.id;
//           Map<String, dynamic> documentMap = doc.data();
//           documentMap["documentId"] = documentId;
//           return documentMap;
//         },
//       )
//           // .map((doc) => doc.data())
//           .toList());
// });

// ***************************************************************
// Presenter: Viewを制御する（データを加工する場合はここで加工して出力する）
// ***************************************************************
final goalListProvider = Provider.autoDispose((ref) async {
  // Repositoryからデータを取得する。最新の情報をwatchする。
  final futureGoalList = ref.watch(goalListStreamProvider.last);
  // Future<List<Member>>なので、値を取得できるまで待つ。
  final goalList = await futureGoalList;

  goalList.sort((a, b) {
    var aDate = a['targetDate']; //before -> var adate = a.expiry;
    var bDate = b['targetDate']; //var bdate = b.expiry;
    return -bDate.compareTo(aDate);
  });

  return goalList;
});
