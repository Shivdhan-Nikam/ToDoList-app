import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todo = [];
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    todo = [
      ["make tutorial", false],
      ["Do exercise", false]
    ];
  }

  void loadData() {
    todo = _mybox.get("TODO");
  }

  void upadatedata() {
    _mybox.put("TODO", todo);
  }
}
