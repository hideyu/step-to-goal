import 'package:flutter/material.dart';

class StepperScreen extends StatefulWidget {
  static String id = 'stepper_screen';

  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step To Goal"),
      ),
      body: Container(
        child: Text('fugafuga'),
      ),
    );
  }
}
