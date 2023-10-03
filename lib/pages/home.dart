import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/addtaskdialog.dart';
import 'package:todoapp/utils/todotile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _mybox = Hive.box('mybox');
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get("TODO") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }

  void onchanged(bool? value, int index) {
    setState(() {
      db.todo[index][1] = !db.todo[index][1];
    });
    db.upadatedata();
  }

  void saveTask() {
    setState(() {
      db.todo.add([_controller.text.trim(), false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.upadatedata();
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          controller: _controller,
          oncancle: () => Navigator.of(context).pop(),
          onsave: saveTask,
        );
      },
    );
  }

  void deletetask(int index) {
    setState(() {
      db.todo.removeAt(index);
    });
    db.upadatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 185, 255),
      appBar: AppBar(
        title: const Text("To Do"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todo.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(
            taskcompleted: db.todo[index][1],
            taskname: db.todo[index][0],
            onChanged: (value) => onchanged(value, index),
            functiondelete: (context) => deletetask(index),
          );
        },
      ),
    );
  }
}
