import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

// ******************************************
// Repository: データをFirestoreから出し入れする
// ******************************************
// StepListプロバイダー
final stepListStreamProvider = StreamProvider.autoDispose((_) {
  CollectionReference ref = FirebaseFirestore.instance.collection('steps');
  return ref.snapshots().map((snapshot) => snapshot.docs.map(
        (doc) {
          // documentIdもMapの変数として格納する{documentId: xxx, isDone: false, ...}
          // TODO: 他にもっといいやり方があるかも？
          String documentId = doc.id;
          Map<String, dynamic> documentMap = doc.data();
          documentMap["documentId"] = documentId;
          // print(fuga.runtimeType);
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

  // TODO: ここで必要あればデータ加工
  // // 部署名順、次に氏名順に並べる。
  // stepList.sort((a, b) {
  //   if (a.division == b.division) {
  //     return a.name.compareTo(b.name);
  //   } else {
  //     return a.division.compareTo(b.division);
  //   }
  // });
  // // 部署1 - メンバー多のデータに変換する
  // final divisions = List<Division>();
  // for (final e in memberList) {
  //   if (divisions.isEmpty || divisions.last.division != e.division) {
  //     divisions.add(Division(division: e.division, names: []));
  //   }
  //   divisions.last.names.add(e.name);
  // }
  return stepList;
  // AsyncSnapshot<List<Map<String, dynamic>>>(ConnectionState.done, [{isDone: false, targetDate: Timestamp(seconds=1615993200, nanoseconds=0), stepSize: 0, goal: make a cake, difficultyLevel: 50, step: do something, user: hogehoge@hog.com},{...}])
});
