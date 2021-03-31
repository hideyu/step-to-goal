import 'package:flutter/material.dart';

class IconMap {
  static String check = "✅";
  static String cracker = "🎉";
  static String skull = "☠️";
  static String here = "👉";
  static String sleep = "💤";
  static String juel = "💎";
  static String flag = "🚩";
  static String crown = "👑";
}

class StepperIcon extends StatelessWidget {
  final bool isDone;
  final DateTime targetDate;
  final int stepSize;
  StepperIcon(
      {@required this.isDone,
      @required this.targetDate,
      @required this.stepSize});

  final today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    // isDoneがtrueで、stepSizeが4以外だったら✅
    // isDoneがtrueで、stepSizeが4以外だったら🎉
    // isDoneがfalseで日付が過去だったらドクロ
    // isDoneがfalseで日付が今日だったら👉
    // isDoneがfalseで日付が将来だったら、stepSizeが0だったら💤
    // isDoneがfalseで日付が将来だったら、stepSizeが1だったら💎
    // isDoneがfalseで日付が将来だったら、stepSizeが2だったら🚩
    // isDoneがfalseで日付が将来だったら、stepSizeが4だったら👑

    if (isDone == true) {
      if (stepSize != 4) {
        // isDoneがtrueで、stepSizeが4以外だったら✅
        return EmojiIcon(icon: IconMap.check);
      } else {
        // isDoneがtrueで、stepSizeが4以外だったら🎉
        return EmojiIcon(icon: IconMap.cracker);
      }
    } else {
      // isDoneがfalseで日付が過去だったらドクロ
      if (targetDate.isBefore(today)) {
        return EmojiIcon(icon: IconMap.skull);
      }
      // isDoneがfalseで日付が今日だったら👉
      else if (targetDate.difference(today).inDays == 0 &&
          targetDate.day == today.day) {
        return EmojiIcon(icon: IconMap.here);
      }
      // isDoneがfalseで日付が将来だったら、stepSizeが0だったら💤
      else if (targetDate.isAfter(today) && stepSize == 0) {
        return EmojiIcon(icon: IconMap.sleep);
      }
      // isDoneがfalseで日付が将来だったら、stepSizeが2だったら🚩
      else if (targetDate.isAfter(today) && stepSize == 2) {
        return EmojiIcon(icon: IconMap.juel);
      }
      // isDoneがfalseで日付が将来だったら、stepSizeが4だったら👑
      else if (targetDate.isAfter(today) && stepSize == 4) {
        return EmojiIcon(icon: IconMap.crown);
      }
      // isDoneがfalseで日付が将来だったら、stepSizeが1だったら💎
      else {
        // else if (targetDate.isAfter(today) && stepSize == 1) {
        return EmojiIcon(icon: IconMap.juel);
      }
    }
  }
}

class EmojiIcon extends StatelessWidget {
  final String icon;

  const EmojiIcon({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          icon,
          style: TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
