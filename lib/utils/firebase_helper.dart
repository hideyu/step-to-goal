import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataMap {
  static const goalTitle = 'goalTitle';
  static const goalDate = 'goalDate';
  static const goalIsDone = 'goalIsDone';
  static const goalUser = 'goalUser';
  static const step = 'step';
  static const stepSize = 'stepSize';
  static const difficultyLevel = 'difficultyLevel';
  static const targetDate = 'targetDate';
  static const isDone = 'isDone';
  static const user = 'user';
  static const goal = 'goal';
}

class FirebaseHelper {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  // 2. Userがsigninしているかどうかを確認する処理
  // TODO: dynamicでいいか不明
  dynamic getCurrentUser() {
    try {
      final user = _auth.currentUser;
      // final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        return loggedInUser;
      }
    } catch (e) {
      print(e);
    }
  }

  // 3. Firestoreのデータ（Stream）を取得する処理
  Stream getStepItemSnapshot() {
    final stepItemSnapshot = _firestore.collection('steps').snapshots();
    return stepItemSnapshot;
  }

  // 3. Firestoreのデータ（Future）を取得する処理
  dynamic getCollections(collection) async {
    final itemCollection = await _firestore.collection(collection).get();
    // itemCollectionにはFuture<Querysnapshot>が入る
    // for (var item in itemCollection.docs) {
    //   // itemCollection.docsにはDocumentSnapshotのListが格納されている
    //   print(item.data()); // todoitem.data()で各データにアクセスできる
    // }
    print(itemCollection.docs.length);
    return itemCollection;
  }

  Future<int> getCollectionLength(collection) async {
    final itemCollection = await _firestore
        .collection(collection)
        .get(); // todoItemsにはFuture<Querysnapshot>が入る
    return itemCollection.docs.length;
  }

  // 4. Firestoreにデータ（steps）を登録する処理
  void addStepItems({
    String goalItem,
    String stepItem,
    DateTime targetDate,
    int stepSize,
    int difficultyLevel,
    User loggedInUser,
  }) async {
    print('addStepItems is called');
    print('loggedInUser is $loggedInUser');
    _firestore.collection('steps').add(
      {
        FirebaseDataMap.goal: goalItem,
        FirebaseDataMap.step: stepItem,
        FirebaseDataMap.difficultyLevel: difficultyLevel,
        FirebaseDataMap.targetDate: Timestamp.fromDate(targetDate),
        FirebaseDataMap.stepSize: stepSize,
        FirebaseDataMap.isDone: false,
        FirebaseDataMap.user: loggedInUser.email,
      },
    );
  }

  // 4. Firestoreにデータ（steps）を編集する処理
  void editStepItems({
    String goalItem,
    String stepItem,
    DateTime targetDate,
    int stepSize,
    int difficultyLevel,
    User loggedInUser,
    String documentId,
  }) async {
    print('editStepItems is called');
    print('loggedInUser is $loggedInUser');
    _firestore.collection('steps').doc(documentId).update(
      {
        FirebaseDataMap.goal: goalItem,
        FirebaseDataMap.step: stepItem,
        FirebaseDataMap.difficultyLevel: difficultyLevel,
        FirebaseDataMap.targetDate: Timestamp.fromDate(targetDate),
        FirebaseDataMap.stepSize: stepSize,
        FirebaseDataMap.isDone: false,
        // FirebaseDataMap.user: loggedInUser.email,
      },
    );
  }

  // 5. Firestoreにデータ（goals）を登録する処理
  void addGoalItems({
    String goalItem,
    DateTime goalDate,
    User loggedInUser,
  }) async {
    print('addGoalItems is called');
    print('loggedInUser is $loggedInUser');
    _firestore.collection('goals').add(
      {
        FirebaseDataMap.goalTitle: goalItem,
        FirebaseDataMap.goalDate: Timestamp.fromDate(goalDate),
        FirebaseDataMap.goalIsDone: false,
        FirebaseDataMap.goalUser: loggedInUser.email,
      },
    );
  }

  // 6. StepのisDoneを切り替える
  void toggleIsDone({String documentId, bool isDoneNow}) {
    try {
      final itemUpdate = _firestore
          .collection("steps")
          .doc(documentId)
          .update({'isDone': isDoneNow ? false : true});
      print(itemUpdate);
    } catch (e) {
      // TODO: エラーハンドリング
      print(e);
    }
  }

  // NOTE: documentIDの取得
  // final itemReferences = await _firestore.collection("steps").get();
  // for (var itemReference in itemReferences.docs) {
  //   print(itemReference.reference.id);
  // }
  // TODO: 型を調べてdynamicをなおす
  dynamic dataFetch(documentId) async {
    final document = await _firestore.collection("steps").doc(documentId).get();
    print(document.data()["step"]);
    return document.data();
  }
}
