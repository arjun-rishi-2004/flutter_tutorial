
import 'package:flutter/material.dart';
import 'package:flutter_application_1/localstorage/local_storage.dart';

class Todoviewmodel extends ChangeNotifier{
  String name = "Admin";
  String password= "";


List <Map<String,dynamic>> todolist = [];


void setTodoFromLocal ()async{
  todolist = await LocalStorage().getTodo();
  notifyListeners();
}

  

  void updatePassword(String updatedPassword){
  password = updatedPassword;
  notifyListeners();

  }

  void deleteTask(int index)async{
    todolist.removeAt(index);
    await LocalStorage().setTodo(todolist);

    notifyListeners();
  }

  void addTask(String taskName, String status) async {
  print("Add task");
  todolist.add({
    "task_name": taskName,
    "status": status, 
  });
  await LocalStorage().setTodo(todolist);
  notifyListeners();
}
}
