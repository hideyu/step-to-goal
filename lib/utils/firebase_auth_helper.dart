import 'package:firebase_auth/firebase_auth.dart';

// 1. FirebaseAuthからの処理結果をenumに定義
// （他にもあると思われるが）よく使いそうなエラー状態を列挙
enum FirebaseAuthResultStatus {
  Successful,
  EmailAlreadyExists,
  WrongPassword,
  InvalidEmail,
  UserNotFound,
  UserDisabled,
  OperationNotAllowed,
  TooManyRequests,
  Undefined,
}

// 4. static関数をHandlerクラスに入れる
class FirebaseAuthExceptionHandler {
  // 2. FirebaseAuthExceptionで渡されたエラーcodeを元に、enumで宣言した型を返す関数を作成
  static FirebaseAuthResultStatus handleException(FirebaseAuthException e) {
    FirebaseAuthResultStatus result;
    switch (e.code) {
      case 'invalid-email':
        result = FirebaseAuthResultStatus.InvalidEmail;
        break;

      case 'wrong-password':
        result = FirebaseAuthResultStatus.WrongPassword;
        break;

      case 'user-not-found':
        result = FirebaseAuthResultStatus.UserNotFound;
        break;

      case 'user-disabled':
        result = FirebaseAuthResultStatus.UserDisabled;
        break;

      case 'too-many-requests':
        result = FirebaseAuthResultStatus.TooManyRequests;
        break;

      case 'operation-not-allowed':
        result = FirebaseAuthResultStatus.OperationNotAllowed;
        break;

      case 'email-already-in-use':
        result = FirebaseAuthResultStatus.EmailAlreadyExists;
        break;

      default:
        result = FirebaseAuthResultStatus.Undefined;
        break;
    }
    return result;
  }

  // 3. FirebaseAuthResultStatusによって、エラーメッセージを返す関数を作成
  // TODO: エラーメッセージの修正
  static String exceptionMessage(FirebaseAuthResultStatus result) {
    String message = '';
    switch (result) {
      case FirebaseAuthResultStatus.InvalidEmail:
        message = 'メールアドレスが間違っています。';
        break;

      case FirebaseAuthResultStatus.WrongPassword:
        message = 'パスワードが間違っています。';
        break;

      case FirebaseAuthResultStatus.UserNotFound:
        message = 'このアカウントは存在しません。';
        break;

      case FirebaseAuthResultStatus.UserDisabled:
        message = 'このメールアドレスは無効になっています。';
        break;

      case FirebaseAuthResultStatus.TooManyRequests:
        message = '回線が混雑しています。もう一度試してみてください。';
        break;

      case FirebaseAuthResultStatus.OperationNotAllowed:
        message = 'メールアドレスとパスワードでのログインは有効になっていません。';
        break;

      case FirebaseAuthResultStatus.EmailAlreadyExists:
        message = 'このメールアドレスはすでに登録されています。';
        break;

      default:
        message = '予期せぬエラーが発生しました。';
        break;
    }
    return message;
  }
}

// 5. ログイン
Future<FirebaseAuthResultStatus> signIn({String email, String password}) async {
  FirebaseAuthResultStatus result;
  try {
    print("signIn is called...");
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      // ユーザーが取得できなかったとき
      result = FirebaseAuthResultStatus.Undefined;
    } else {
      // ログイン成功時
      result = FirebaseAuthResultStatus.Successful;
    }
  } on Exception catch (error) {
    print("ログイン失敗2");
    // エラー時
    result = FirebaseAuthExceptionHandler.handleException(error);
  }
  return result;
}

// 5. 新規登録
Future<FirebaseAuthResultStatus> signUp({String email, String password}) async {
  FirebaseAuthResultStatus result;
  try {
    print("signUp is called...");
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      // ユーザーが取得できなかったとき
      result = FirebaseAuthResultStatus.Undefined;
    } else {
      // ログイン成功時
      result = FirebaseAuthResultStatus.Successful;
    }
  } on Exception catch (error) {
    print("ログイン失敗2");
    // エラー時
    result = FirebaseAuthExceptionHandler.handleException(error);
  }
  return result;
}
