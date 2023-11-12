import 'package:flutter/material.dart';


class ToDoTile extends StatelessWidget {
  String taskName;
  bool taskCompleted;
  Function()? deleteFunction;
  Function()? updateFunction;
  Function(bool?)? change;

  ToDoTile(
      {super.key,
      required this.taskCompleted,
      required this.taskName,
      required this.change,
      required this.deleteFunction,
      this.updateFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  fillColor: MaterialStateProperty.all(Colors.purple),
                  activeColor: Colors.black,
                  value: taskCompleted,
                  onChanged: change,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 16,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),

                  ],
                ),
            Row(
              children: [
                IconButton(onPressed: updateFunction, icon: const Icon(Icons.edit)),
                IconButton(onPressed: deleteFunction, icon: const Icon(Icons.delete))
              ],
            ),
          ],
        ),

      ),
    );
  }
}
