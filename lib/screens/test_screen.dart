import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TestScreen extends HookWidget {
  static String id = 'test_screen';

  @override
  Widget build(BuildContext context) {
    // final futurestepList = useProvider(stepListProvider);
    // final snapshot = useFuture(futurestepList, initialData: null);
    // final futureUser = useProvider(userProvider);
    // final snapshot = useFuture(futureUser, initialData: null);
    // print(futureUser);
    // final stateForm = useProvider(formInputProvider.state);
    // final formInput = useProvider(formInputProvider);
    // int hoge = stateForm.inputMap["stepSize"];
    // hoge = 40;

    return Scaffold(
      appBar: AppBar(
        title: Text("this is test"),
      ),
      body: Column(
        children: [
          Container(
            child: Text("this is a test screen."),
          ),
          // Container(
          //   child: SvgPicture.asset(
          //     "images/check.svg",
          //     color: Colors.red,
          //     width: 200,
          //     height: 200,
          //   ),
          // )
        ],
      ),
    );
  }
}
