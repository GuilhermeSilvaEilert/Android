import 'dart:convert';
import 'package:applista/Models/todo.dart';
import 'package:applista/Repositorys/todo_repository.dart';
import 'package:applista/pages/listametal.dart';
import 'package:applista/widgets/todo_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaMetal extends StatefulWidget {
  ListaMetal({Key? key}) : super(key: key);

  @override
  State<ListaMetal> createState() => _ListaMetalState();
}

class _ListaMetalState extends State<ListaMetal> {

  final TextEditingController todoController = TextEditingController();
  final Todo_repository todo_repository = Todo_repository();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController TotalController = TextEditingController();

  List<Todo> todos = [];

  double? acumulator1 = 0;
  double? b = 0;
  int? deletedTodoPos;
  Todo? deletedTodo;
  String? errorText;

  TotalCompras(){
    acumulator1 = 0;
    for (int i = 0; i < todos.length; i++) {
      double a = double.parse(todos[i].preco);
      acumulator1 = a + acumulator1!;
      String acumulator1String = acumulator1!.toStringAsFixed(2);
      acumulator1 = double.parse(acumulator1String);
      print('Acumulador: $acumulator1');
    }
  }

  @override
  void initState(){
    super.initState();
    todo_repository.getTodoList().then((value) {
      setState((){
        todos = value;
        TotalCompras();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: todoController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma Verdura de preferencia',
                          hintText: 'Ex. Leite condensado',
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.black,
                              width:2,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child:
                      TextField(
                        controller: valueController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixText: 'R\$',
                          labelText: 'Aqui é o preço',
                          hintText: ' 5.00',
                          errorText: errorText,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Column(
                  children: [
                    Row(
                      children:  [
                        ElevatedButton(
                          onPressed: () {
                            String text = todoController.text;
                            String valor = valueController.text;
                            String soma = TotalController.text;
                            acumulator1 = 0;

                            if((text.isEmpty||valor.isEmpty)){
                              setState(() {
                                errorText = 'Se é burro mermão ?';
                              });
                              return;
                            }
                            setState(() {
                              Todo newTodo = Todo(
                                title: text,
                                dateTime: DateTime.now(),
                                preco: valor,
                                total: soma,
                              );
                              todos.add(newTodo);
                              errorText = null;
                            });
                            todoController.clear();
                            valueController.clear();
                            todo_repository.saveTodoList(todos);
                            TotalCompras();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black, padding: EdgeInsets.symmetric(
                                horizontal: 125
                              , vertical: 20)),
                          child: Icon(Icons.add, size: 20, color: Colors.white),
                        ),
                        //Botão de Recarregar o PrecoTotal
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ElevatedButton(
                              onPressed: () {
                                setState((){
                                  TotalCompras();
                                  }
                                );},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black, padding: EdgeInsets.symmetric(
                                  horizontal: 37
                                  , vertical: 20)),
                              child: Icon(Icons.refresh, size: 20, color: Colors.white)),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} itens na lista',
                      ),
                    ),
                    Expanded(
                        child:Text(
                          'Valor Total R\$ $acumulator1'
                        ),),
                    SizedBox(width: 8),
                    //Botão de limpar a lista
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, padding: EdgeInsets.all(16)),
                      child: Text(
                        'limpa tudo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
      TotalCompras();
    });
    todo_repository.saveTodoList(todos);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
              TotalCompras();
            });
            todo_repository.saveTodoList(todos);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Limpar Tudo ?'),
            content: Text('VOCÊ TEM CERTEZA ABSOLUTA DISSO ??????'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(primary: Colors.black),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteAllTodos();
                },
                style: TextButton.styleFrom(primary: Colors.red),
                child: Text('Limpar Tudo'),
              ),
            ],
          ),
    );
  }
  void deleteAllTodos() {
    setState(() {
      todos.clear();
      acumulator1 = 0;
    });
    todo_repository.saveTodoList(todos);
  }
}

