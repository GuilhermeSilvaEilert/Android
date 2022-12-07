import 'package:applista/Models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const todoListKey = 'todo_list';
const todoListValue = 'todo_value';

class Todo_repository {

  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jasonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jasonDecoded = json.decode(jasonString) as List;
    return jasonDecoded.map((e)=>Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos){
    final String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }


}