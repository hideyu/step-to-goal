import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text(
                    widget.stepItem["documentId"],
                    style: TextStyle(fontSize: 12),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: widget.stepItem["isDone"]
                          ? Text('Done')
                          : Text('Doneじゃない'),
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
                              // TODO: ログイン情報を渡す
                              // loggedInUser: widget.loggedInUser,
                            );

                            // return AlertDialog(
                            //   title: Text(
                            //     "ここに編集用のpopupを作成する",
                            //     style: TextStyle(fontSize: 12),
                            //   ),
                            //   actions: <Widget>[
                            //     TextButton(
                            //       child: Text(
                            //         'OK',
                            //       ),
                            //       onPressed: () {
                            //         Navigator.pop(dialogContext);
                            //       },
                            //     ),
                            //   ],
                            // );
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
              color: Colors.blue,
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
                    "${widget.stepItem['step']}, ${widget.stepItem['isDone']}"),
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

// class StepperTimelineTile extends StatefulWidget {
//   final Widget stepText;
//   final String documentId;
//   final bool isDoneNow;
//   final Map<String, dynamic> stepMapData;
//   final User loggedInUser;

//   const StepperTimelineTile({
//     @required this.stepText,
//     @required this.documentId,
//     @required this.isDoneNow,
//     @required this.stepMapData,
//     @required this.loggedInUser,
//   });

//   @override
//   _StepperTimelineTileState createState() => _StepperTimelineTileState();
// }

// class _StepperTimelineTileState extends State<StepperTimelineTile> {
//   FirebaseHelper _firebaseHelper = FirebaseHelper();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.blue.shade50,
//       child: Material(
//         type: MaterialType.transparency,
//         child: InkWell(
//           highlightColor: Colors.redAccent,
//           splashColor: Colors.red,
//           onTap: () {
//             // print("hogehoge");
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext dialogContext) {
//                 final testId = widget.documentId;
//                 return AlertDialog(
//                   title: Text(
//                     testId,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       child: Text(
//                         widget.isDoneNow ? 'Doneじゃない' : 'Done',
//                       ),
//                       onPressed: () {
//                         _firebaseHelper.toggleIsDone(
//                             isDoneNow: widget.isDoneNow,
//                             documentId: widget.documentId);
//                         Navigator.pop(dialogContext);
//                       },
//                     ),
//                     TextButton(
//                       child: Text(
//                         'Edit',
//                       ),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (BuildContext dialogContext) {
//                             return PopupEditDialog(
//                               documentId: widget.documentId,
//                               stepMapData: widget.stepMapData,
//                               loggedInUser: widget.loggedInUser,
//                             );

//                             // return AlertDialog(
//                             //   title: Text(
//                             //     "ここに編集用のpopupを作成する",
//                             //     style: TextStyle(fontSize: 12),
//                             //   ),
//                             //   actions: <Widget>[
//                             //     TextButton(
//                             //       child: Text(
//                             //         'OK',
//                             //       ),
//                             //       onPressed: () {
//                             //         Navigator.pop(dialogContext);
//                             //       },
//                             //     ),
//                             //   ],
//                             // );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: TimelineTile(
//             indicatorStyle: IndicatorStyle(
//               color: Colors.blue,
//               width: 20,
//             ),
//             endChild: Row(
//               children: [
//                 SizedBox(
//                   width: 10,
//                   height: 50,
//                 ),
//                 widget.stepText,
//               ],
//             ),
//             // endChild: Container(
//             //   height: 85.0,
//             //   child: Text('hogehgoe'),
//             //   color: Colors.green,
//             // ),
//           ),
//         ),
//       ),
//     );
//   }
// }
