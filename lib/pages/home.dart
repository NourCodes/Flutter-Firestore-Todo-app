import 'package:flutter/material.dart';
import 'package:to_do_app/components/dialog_box.dart';
import 'package:to_do_app/services/database.dart';
import 'package:to_do_app/components/tilelist.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database database = Database();
  String search = "";

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      value: database.tasks,
      initialData: const [],
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(237, 237, 245, 1.0),
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
          backgroundColor: const Color.fromRGBO(237, 237, 245, 1.0),
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar for filtering tasks.
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (value) {
                    // Update the search query when the text changes.
                    search = value;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                    prefixIconConstraints:
                        BoxConstraints(maxHeight: 20, minWidth: 30),
                    border: InputBorder.none,
                    hintText: "Search",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 10),
                child: const Text("Todo List",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
              ),
              Expanded(
                  child: TileList(
                searchQuery: search,
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
          onPressed: () async {
            // Display the dialog box for adding a new task.
            String newTask = await showDialog(
              context: context,
              builder: (context) {
                return const DialogBox();
              },
            );
            if (newTask != null) {
              database.addTask(newTask);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.white,
                  content: Text('Task Added Successfully!',
                      style: TextStyle(color: Colors.black)),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
