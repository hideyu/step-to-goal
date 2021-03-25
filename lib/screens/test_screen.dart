import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step_to_goal/utils/user_repository.dart';

class TestScreen extends HookWidget {
  static String id = 'test_screen';

  @override
  Widget build(BuildContext context) {
    // final futurestepList = useProvider(stepListProvider);
    // final snapshot = useFuture(futurestepList, initialData: null);
    final futureUser = useProvider(userProvider);
    final snapshot = useFuture(futureUser, initialData: null);
    print(futureUser);

    return Scaffold(
      appBar: AppBar(
        title: Text("this is test"),
      ),
      body: Column(
        children: [
          Container(
            child: Text("snapshot has data."),
          ),
          Container(
            child: snapshot.hasData
                // ? Text("${snapshot.data[0]['step']}")
                ? Text("${snapshot.data}")
                : Text("no data"),
          ),
        ],
      ),
    );
  }
}
