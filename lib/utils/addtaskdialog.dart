import 'package:flutter/material.dart';
import 'package:todoapp/utils/Buttons.dart';

class AddTaskDialog extends StatelessWidget {
  final controller;
  final VoidCallback onsave;
  final VoidCallback oncancle;
  const AddTaskDialog(
      {super.key,
      required this.controller,
      required this.onsave,
      required this.oncancle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 242, 165, 255),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple)),
                  hintText: "Add new Task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtons(
                  onPressed: onsave,
                  text: "Save",
                ),
                const SizedBox(
                  width: 8,
                ),
                MyButtons(
                  text: "Cancel",
                  onPressed: oncancle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
