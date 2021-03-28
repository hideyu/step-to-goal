import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataMap {
  // static const goalTitle = 'goalTitle';
  // static const goalDate = 'goalDate';
  // static const goalIsDone = 'goalIsDone';
  // static const goalUser = 'goalUser';
  static const step = 'step';
  static const stepSize = 'stepSize';
  static const difficultyLevel = 'difficultyLevel';
  static const targetDate = 'targetDate';
  static const isDone = 'isDone';
  static const user = 'user';
  static const goal = 'goal';
  static const description = 'description';
}

class FirebaseHelper {
  // final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  // 4. Firestoreにデータ（steps）を登録する処理
  void addStepItems({
    String goalItem,
    String stepItem,
    DateTime targetDate,
    int stepSize,
    int difficultyLevel,
    User loggedInUser,
    String description,
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
        FirebaseDataMap.description: description
      },
    );
  }

  // 4. Firestoreのデータ（steps）を編集する処理
  void editStepItems(
      {String goalItem,
      String stepItem,
      DateTime targetDate,
      int stepSize,
      int difficultyLevel,
      User loggedInUser,
      String documentId,
      String description}) async {
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
        FirebaseDataMap.user: loggedInUser.email,
        FirebaseDataMap.description: description
      },
    );
  }

  // 4. Firestoreのデータ（steps）を削除する処理
  void deleteStepItems({
    User loggedInUser,
    String documentId,
  }) async {
    print('delete StepItems is called');
    print('loggedInUser is $loggedInUser');
    // TODO: userのバリデーション
    _firestore.collection('steps').doc(documentId).delete();
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

  // // 5. Firestoreにデータ（goals）を登録する処理
  // void addGoalItems({
  //   String goalItem,
  //   DateTime goalDate,
  //   User loggedInUser,
  // }) async {
  //   print('addGoalItems is called');
  //   print('loggedInUser is $loggedInUser');
  //   _firestore.collection('goals').add(
  //     {
  //       FirebaseDataMap.goalTitle: goalItem,
  //       FirebaseDataMap.goalDate: Timestamp.fromDate(goalDate),
  //       FirebaseDataMap.goalIsDone: false,
  //       FirebaseDataMap.goalUser: loggedInUser.email,
  //     },
  //   );
  // }

  // NOTE: documentIDの取得
  // final itemReferences = await _firestore.collection("steps").get();
  // for (var itemReference in itemReferences.docs) {
  //   print(itemReference.reference.id);
  // }
}
