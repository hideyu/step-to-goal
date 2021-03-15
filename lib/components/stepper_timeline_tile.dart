import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperTimelineTile extends StatefulWidget {
  final Widget stepText;

  const StepperTimelineTile({@required this.stepText});

  @override
  _StepperTimelineTileState createState() => _StepperTimelineTileState();
}

class _StepperTimelineTileState extends State<StepperTimelineTile> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
        indicatorStyle: IndicatorStyle(
          color: Colors.blue,
          width: 20,
        ),
        endChild: Row(
          children: [
            SizedBox(
              width: 10,
              height: 50,
            ),
            widget.stepText,
          ],
        )
        // endChild: Container(
        //   height: 85.0,
        //   child: Text('hogehgoe'),
        //   color: Colors.green,
        // ),
        );
  }
}
