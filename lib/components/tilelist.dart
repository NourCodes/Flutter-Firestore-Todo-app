import 'package:flutter/material.dart';
import 'package:to_do_app/components/todotilelist.dart';
import '../models/task.dart';
import '../pages/updatePage.dart';
import '../services/database.dart';
import 'package:provider/provider.dart';


class TileList extends StatelessWidget {
  final String searchQuery;
   TileList({super.key, required this.searchQuery});


  Database database = Database();

  @override
  Widget build(BuildContext context) {
    // Get the list of tasks from the provider
    List<Task> tasks = Provider.of<List<Task>>(context);

    // Filter tasks based on the search query
    List<Task> filteredTasks = searchQuery.isNotEmpty
        ? tasks
        .where((task) =>
        task.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList()
        : tasks;

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        Task task = filteredTasks[index];
        return ToDoTile(
          // Update the checkbox
          change: (value) async {
            await database.updated(
              !task.isDone,
              task.id,
            );
          },
          // Delete the task
          deleteFunction: () async {
            await database.deleteTask(task.id);
          },
          //update task data
          updateFunction: () async {
            await showModalBottomSheet(context: context,
              //puts the bottom sheet above the keyboard
              isScrollControlled:
              true, //make bottom sheet full height above the keyboard
              builder: (context) {
                return UpdatePage(id: task.id);
              },);
          },
          taskCompleted: task.isDone,
          taskName: task.name,
        );
      },
    );
  }


}
