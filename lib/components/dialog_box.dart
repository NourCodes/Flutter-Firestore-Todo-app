import 'package:flutter/material.dart';
import 'button.dart';

// This class is responsible for displaying a dialog box
// for adding a new task. It includes a text field for entering
// the task name, and buttons for saving or canceling the operation.
class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
// Controller to manage the input in the text field.
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "Add a new task"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // Row containing buttons for Save and Cancel.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                Button(
                  label: "Save",
                  pressed: () {
                    // Check if the task name is empty.
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("you must write a task")));
                    }
                    // Pass the entered task name back to the caller.
                    Navigator.pop(context, _controller.text);
                    _controller.clear();

                    setState(() {});
                  },
                ),

                const SizedBox(
                  width: 8,
                ),

                // Cancel button.
                Button(
                  label: "Cancel",
                  pressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
