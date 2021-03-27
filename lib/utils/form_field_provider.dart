// import 'package:hooks_riverpod/hooks_riverpod.dart';

// // privider
// final formInputProvider =
//     StateNotifierProvider((_) => FormFieldStateNotifier());

// // statenotifier
// class FormFieldStateNotifier extends StateNotifier<FormFieldState> {
//   FormFieldStateNotifier() : super(FormFieldState());

//   void editInput(Map valueMap) {
//     state.inputMap = {
//       "goalInput": valueMap["goal"], // ゴールの内容
//       "stepInput": valueMap["step"], // ステップの内容
//       "stepSize": valueMap["stepSize"], // ステップのレベル（大中小）
//       "diffucultyLevel": valueMap["difficultyLevel"], // ステップのスコア（0~100）
//       "date": valueMap["date"], // 現在日時
//       "dateLabel": valueMap["dateLabel"],
//     };
//   }

//   void editStepInput(String input) {
//     state.goalInput = input;
//   }
// }

// // stateで保持するデータクラス
// class FormFieldState {
//   Map<String, dynamic> inputMap = {
//     "goalInput": "", // ゴールの内容
//     "stepInput": "", // ステップの内容
//     "stepSize": 0, // ステップのレベル（大中小）
//     "diffucultyLevel": 0, // ステップのスコア（0~100）
//     "date": DateTime.now(), // 現在日時
//     "dateLabel": '日付を選択してください',
//   };
//   String goalInput; // ゴールの内容
//   String stepInput; // ステップの内容
//   int stepSize; // ステップのレベル（大中小）
//   int diffucultyLevel; // ステップのスコア（0~100）
//   DateTime date; // 現在日時
//   String dateLabel = '日付を選択してください';
// }
