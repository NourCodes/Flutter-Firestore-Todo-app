import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/components/todotilelist.dart';
import '../models/task.dart';
import '../pages/updatePage.dart';
import '../services/database.dart';
import 'package:provider/provider.dart';


class TileList extends StatelessWidget {
  final String searchQuery;
   TileList({super.key, required this.searchQuery});


  final taskCollection = FirebaseFirestore.instance.collection('tasks');

  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      value: database.tasks,
      initialData:  const [],
      child: Consumer<List<Task>>(builder: (context, value, child) {
        //if there is no task return No tasks yet
        if (value.isEmpty) {
          return const Center(
            child: Text(
              'No tasks yet!',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        List<Task> filteredTasks = value;
        //if the searchQuery is not empty filter the tasks based on the search query
        if (searchQuery.isNotEmpty) {
          filteredTasks = value
              .where((task) =>
              task.name.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();
        }
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
              deleteFunction: () async{
                await database.deleteTask(task.id);
              },
              //update task data
              updateFunction: () async{
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
      }),
    );
  }
}
