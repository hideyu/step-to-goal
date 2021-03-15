import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_to_goal/components/alert_dialog.dart';
import 'package:step_to_goal/components/rounded_button.dart';
import 'package:step_to_goal/constants/constants.dart';
import 'package:step_to_goal/screens/stepper_screen.dart';
import 'package:step_to_goal/utils/firebase_auth_helper.dart';
// import 'package:step_to_goal/utils/firebase_helper.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;

  // TODO: リファクター、関数を別ファイルに移す
  void login() async {
    final FirebaseAuthResultStatus result = await signIn(
      email: _email,
      password: _password,
    );

    if (result == FirebaseAuthResultStatus.Successful) {
      // ログイン成功時の処理
      Navigator.pushNamed(context, StepperScreen.id);
    } else {
      print("ログイン失敗1");
      // ログイン失敗時の処理
      final errorMessage =
          FirebaseAuthExceptionHandler.exceptionMessage(result);

      // エラー情報をユーザーに何かで通知
      showErrorDialog(context, errorMessage);
    }
  }

  // TODO: リファクター、関数を別ファイルに移す
  void register() async {
    final FirebaseAuthResultStatus result = await signUp(
      email: _email,
      password: _password,
    );

    if (result == FirebaseAuthResultStatus.Successful) {
      // サインアップ成功時の処理
      Navigator.pushNamed(context, StepperScreen.id);
    } else {
      print("新規登録失敗1");
      // サインアップ失敗時の処理
      final errorMessage =
          FirebaseAuthExceptionHandler.exceptionMessage(result);

      // エラー情報をユーザーに何かで通知
      showErrorDialog(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                '🔥 Step To Goal 🔥',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  _email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  _password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RoundedButton(
                  title: 'Login',
                  color: Colors.orangeAccent,
                  onPressed: () async {
                    // setState(() {
                    //   showSpinner = true;
                    // });
                    try {
                      print('login process is called...');
                      login();
                      // final user = await _auth.signInWithEmailAndPassword(
                      // email: _email, password: _password);
                      // if (user != null) {
                      //   Navigator.pushNamed(context, StepperScreen.id);
                      // }
                      // setState(() {
                      //   showSpinner = false;
                      // });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                RoundedButton(
                  title: 'Register',
                  color: Colors.red,
                  onPressed: () async {
                    print('registration process is called...');
                    register();
                    // try {
                    //   final newUser =
                    //       await _auth.createUserWithEmailAndPassword(
                    //           email: _email, password: _password);
                    //   if (newUser != null) {
                    //     Navigator.pushNamed(context, StepperScreen.id);
                    //   }
                    //   setState(() {
                    //     showSpinner = false;
                    //   });
                    // } catch (e) {
                    //   print(e);
                    // }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
