import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
//The `Database` class manages data operations with Firebase Firestore.

class Database {
  // Collection reference to the "tasks" collection in Firebase Firestore.

  CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection("tasks");

  // Converts a Firestore [QuerySnapshot] into a list of [Task] objects.
  /// This private method is used internally to map Firestore data to the
  // application's [Task] model.
  List<Task> _taskFromFirestore(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Task(
          id: doc.id,
          name: data != null ? doc.get("taskname") : "",
          isDone: data != null ? doc.get("isDone") : false,
        );
      }).toList();
    } catch (e) {
      print("Error processing snapshot: $e");
      return [];
    }
  }

  // Stream that emits a list of tasks whenever the Firestore collection changes.
  // This stream is used to listen for updates in the "tasks" collection.
  Stream<List<Task>> get tasks {
    return tasksCollection
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map(_taskFromFirestore);
  }

  // Updates the "isDone" field of a specific task in the Firestore collection.
  // This method takes a boolean value [isDone] and the [Id] of the task to be updated.
  Future updated(bool isDone, String Id) async {
    try {
      await tasksCollection.doc(Id).update({
        "isDone": isDone,
      });
    } catch (e) {
      print("Update error: $e");
    }
  }

  // Updates the "taskname" field of a specific task in the Firestore collection.
  // This method takes a string [newTaskName] and the [Id] of the task to be updated.
  Future updateTask(String newTaskName, String id) async {
    try {
      await tasksCollection.doc(id).update({
        "taskname": newTaskName,
      });
    } catch (e) {
      print("Update error: $e");
    }
  }

  // Deletes a specific task from the Firestore collection.
  // This method takes the [id] of the task to be deleted.
  Future deleteTask(String id) async {
    try {
      await tasksCollection.doc(id).delete();
    } catch (e) {
      print("Delete error: $e");
    }
  }

  // Adds a new task to the Firestore collection.
  Future addTask(String taskName) async {
    try {
      await tasksCollection.add({
        "taskname": taskName,
        "isDone": false,
        "timestamp": FieldValue
            .serverTimestamp(), // Add a timestamp field with the current server time
      });
    } catch (e) {
      print("Add task error: $e");
    }
  }
}
