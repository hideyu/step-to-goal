import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

// ******************************************
// Repository: データをFirestoreから出し入れする
// ******************************************
// User認証状態プロバイダー
final authStreamProvider = StreamProvider.autoDispose((_) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
});

/// Userプロバイダー
final userStreamProvider = StreamProvider.autoDispose((_) {
  return FirebaseAuth.instance.authStateChanges().map((user) {
    return user;
  });
});

// ***************************************************************
// Presenter: Viewを制御する（データを加工する場合はここで加工して出力する）
// ***************************************************************
// User認証状態プロバイダー
final authProvider = Provider.autoDispose((authSnapshot) async {
  // Repositoryから認証情報を取得。最新の情報をwatchする。
  final futureAuth = authSnapshot.watch(authStreamProvider.last);
  // Futureなので、値を取得できるまで待つ。
  final auth = await futureAuth;
  return auth;
});

// Userプロバイダー
final userProvider = Provider.autoDispose((userSnapshot) async {
  // Repositoryから認証情報を取得。最新の情報をwatchする。
  final futureUser = userSnapshot.watch(userStreamProvider.last);
  // Futureなので、値を取得できるまで待つ。
  final user = await futureUser;
  return user;
});
