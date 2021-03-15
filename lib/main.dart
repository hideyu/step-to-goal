import 'package:flutter/material.dart';
import 'package:step_to_goal/screens/stepper_screen.dart';
import 'package:step_to_goal/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step To Goal',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: StepperScreen(),
      // initialRoute: StepperScreen.id,
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,

      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        StepperScreen.id: (context) => StepperScreen()
      },
    );
  }
}
