import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_to_goal/components/edit_item_dialog.dart';
import 'package:step_to_goal/utils/firebase_helper.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepperTimelineTile extends StatefulWidget {
  final Map<String, dynamic> stepItem;
  final User user;
  const StepperTimelineTile({@required this.stepItem, @required this.user});

  @override
  _StepperTimelineTileState createState() => _StepperTimelineTileState();
}

class _StepperTimelineTileState extends State<StepperTimelineTile> {
  // TODO: Helper関数もProviderに組み込んだ方がいいか？
  FirebaseHelper _firebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy/MM/dd').format(widget.stepItem["targetDate"].toDate());

    return Container(
      // color: Colors.blue.shade50,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          highlightColor: Colors.redAccent,
          splashColor: Colors.red,
          onTap: () {
            showDialog(
              context: context,
              // barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text(
                    widget.stepItem["documentId"],
                    style: TextStyle(fontSize: 12),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: widget.stepItem["isDone"]
                          ? Text('Doneじゃない')
                          : Text('Done'),
                      onPressed: () {
                        _firebaseHelper.toggleIsDone(
                            isDoneNow: widget.stepItem["isDone"],
                            documentId: widget.stepItem["documentId"]);
                        Navigator.pop(dialogContext);
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Edit',
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return PopupEditDialog(
                              stepMapData: widget.stepItem,
                              loggedInUser: widget.user,
                            );
                          },
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Delete',
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          // barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text("本当に削除しますか？"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    _firebaseHelper.deleteStepItems(
                                        documentId:
                                            widget.stepItem["documentId"],
                                        loggedInUser: widget.user);
                                    print("deleted!!!");
                                    int count = 0;
                                    Navigator.popUntil(
                                        dialogContext, (_) => count++ >= 2);
                                  },
                                  child: Text("削除"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: Text("削除しない"),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: TimelineTile(
            indicatorStyle: IndicatorStyle(
              color: Colors.red,
              width: 20,
            ),
            endChild: Row(
              children: [
                SizedBox(
                  width: 10,
                  height: 50,
                ),
                // widget.stepText,
                Text(
                    "${widget.stepItem['step']}, ${widget.stepItem['isDone']}, $formattedDate. ${widget.stepItem['user']}"),
              ],
            ),
            // endChild: Container(
            //   height: 85.0,
            //   child: Text('hogehgoe'),
            //   color: Colors.green,
            // ),
          ),
        ),
      ),
    );
  }
}
