import 'package:flutter/material.dart';

// TODO: アラートのスタイル
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(
          message,
          style: TextStyle(fontSize: 12),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}
