import 'package:flutter/material.dart';
import 'package:step_to_goal/screens/stepper_screen.dart';
import 'package:step_to_goal/screens/test_screen.dart';
import 'package:step_to_goal/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
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
      // home: TestScreen(),
      // initialRoute: TestScreen.id,
      home: StepperScreen(),
      initialRoute: StepperScreen.id,

      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        StepperScreen.id: (context) => StepperScreen(),
        TestScreen.id: (context) => TestScreen()
      },
    );
  }
}
