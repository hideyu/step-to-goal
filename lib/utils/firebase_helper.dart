import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseDataMap {
  static const goalTitle = 'goalTitle';
  static const goalDescription = 'goalDescription';
  static const goalDate = 'goalDate';
  static const goalIsDone = 'goalIsDone';
  static const goalUser = 'goalUser';
  static const step = 'step';
  static const description = 'description';
  static const stepSize = 'stepSize';
  static const difficultyLevel = 'difficultyLevel';
  static const targetDate = 'targetDate';
  static const isDone = 'isDone';
  static const user = 'user';
  static const goalReference = 'goalReference';
}

class FirebaseHelper {
  // final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  // documentIdからDocumentReferenceを取得する
  DocumentReference getGoalDocumentReference({String documentId}) {
    return _firestore.collection("goals").doc(documentId);
  }

  // 5. Firestoreにデータ（goals）を登録する処理
  void addGoalItems({
    String goalItem,
    String goalDescription,
    DateTime goalDate,
    User loggedInUser,
  }) async {
    print('addGoalItems is called');
    print('loggedInUser is $loggedInUser');
    _firestore.collection('goals').add(
      {
        FirebaseDataMap.goalTitle: goalItem,
        FirebaseDataMap.goalDescription: goalDescription,
        FirebaseDataMap.goalDate: Timestamp.fromDate(goalDate),
        FirebaseDataMap.goalIsDone: false,
        FirebaseDataMap.goalUser: loggedInUser.email,
      },
    );
  }

  // 4. Firestoreにデータ（steps）を登録する処理
  void addStepItems({
    DocumentReference goalReference,
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
        FirebaseDataMap.goalReference: goalReference,
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

  // 4. Firestoreのデータ（goals）を編集する処理
  void editGoalItems({
    String goalTitleInput,
    DateTime goalDate,
    User loggedInUser,
    String documentId,
    String goalDescription,
  }) async {
    // TODO: ユーザーのvaridation
    _firestore.collection('goals').doc(documentId).update(
      {
        FirebaseDataMap.goalTitle: goalTitleInput,
        FirebaseDataMap.goalDescription: goalDescription,
        FirebaseDataMap.goalDate: Timestamp.fromDate(goalDate),
        // FirebaseDataMap.goalUser: loggedInUser.email,
      },
    );
  }

  // 4. Firestoreのデータ（steps）を編集する処理
  void editStepItems({
    // DocumentReference goalReference,
    String stepItem,
    DateTime targetDate,
    int stepSize,
    int difficultyLevel,
    User loggedInUser,
    String documentId,
    String description,
  }) async {
    // TODO: ユーザーのvaridation
    print('editStepItems is called');
    print('loggedInUser is $loggedInUser');
    _firestore.collection('steps').doc(documentId).update(
      {
        // FirebaseDataMap.goalReference: goalReference,
        FirebaseDataMap.step: stepItem,
        FirebaseDataMap.difficultyLevel: difficultyLevel,
        FirebaseDataMap.targetDate: Timestamp.fromDate(targetDate),
        FirebaseDataMap.stepSize: stepSize,
        FirebaseDataMap.isDone: false,
        // FirebaseDataMap.user: loggedInUser.email,
        FirebaseDataMap.description: description
      },
    );
  }

  // 4. Firestoreのデータ（goals）を削除する処理
  void deleteGoalItems({
    User loggedInUser,
    String documentId,
  }) async {
    print('delete StepItems is called');
    print('loggedInUser is $loggedInUser');

    // TODO: userのバリデーション
    // goalのDocumentReferenceを取得する
    DocumentReference goalRef =
        FirebaseFirestore.instance.collection("goals").doc(documentId);

    // 関連するstepを全て削除する
    Query relevantStepQuery = _firestore
        .collection('steps')
        .where('goalReference', isEqualTo: goalRef);
    QuerySnapshot stepList = await relevantStepQuery.get();
    for (var step in stepList.docs) {
      _firestore.collection('steps').doc(step.id).delete();
    }

    // goalを削除する
    _firestore.collection('goals').doc(documentId).delete();
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
  void toggleStepIsDone({String documentId, bool isDoneNow}) {
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

  // 6. GoalのisDoneを切り替える
  void toggleGoalIsDone({String documentId, bool isDoneNow}) {
    try {
      final itemUpdate = _firestore
          .collection("goals")
          .doc(documentId)
          .update({'goalIsDone': isDoneNow ? false : true});
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
}
