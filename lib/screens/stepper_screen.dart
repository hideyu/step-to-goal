import 'package:flutter/material.dart';
import 'package:step_to_goal/screens/welcome_screen.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperScreen extends StatefulWidget {
  static String id = 'stepper_screen';

  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  List<Widget> Tablist = [Text('Tab1'), Text('Tab2'), Text('Tab3')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
              title: Text("Step To Goal"),
              // actions: [],
              bottom: TabBar(tabs: Tablist)),
        ),
        body: TabBarView(
          children: [
            StepperBodyScreen(),
            StepperBodyScreen(),
            StepperBodyScreen(),
          ],
        ),
      ),
    );
  }
}

class StepperBodyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        StepperTimelineTile(),
        // RaisedButton(
        //   child: Text('test'),
        //   onPressed: () {
        //     Navigator.pushNamed(context, WelcomeScreen.id);
        //   },
        // ),
      ],
    );
  }
}

class StepperTimelineTile extends StatelessWidget {
  const StepperTimelineTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
        indicatorStyle: IndicatorStyle(
          color: Colors.blue,
          width: 20,
        ),
        endChild: Row(children: [
          Text('hogehoge'),
        ])
        // endChild: Container(
        //   height: 85.0,
        //   child: Text('hogehgoe'),
        //   color: Colors.green,
        // ),
        );
  }
}
