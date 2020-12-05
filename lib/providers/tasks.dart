import 'package:flutter/foundation.dart';
import 'package:task/helpers/db_helpers.dart';
import '../models/task.dart';


class Tasks with ChangeNotifier {
  List<Task> _items =[];
  List<Task> get items {
    return [..._items];
  }
  void addTask(
  String pickedTask, 
  ) {
    final newTask = Task(
      id: DateTime.now().toString(),
      task: pickedTask,
      
    );
    
    _items.add(newTask);
    notifyListeners();
    DBHelper.database();
    DBHelper.insert('user_tasks', {
      'id': newTask.id,
      'task': newTask.task,
      
    });
  }
  Future<void> fetchAndSetTasks() async {
    final dataList = await DBHelper.getData('user_tasks');
    _items = dataList.map(
      (item) => Task(
        id: item['id'],
        task: item['task'],
      ),
    ).toList();
    notifyListeners();
  }
}