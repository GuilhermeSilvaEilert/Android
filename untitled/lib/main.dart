import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/src/rendering/box.dart';

void main(){
  runApp(MaterialApp(
      home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  List _toDoList = [];

  Map<String, dynamic>? _lastRemoved;
  int? _lastRemovedPos;

  final _toDoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _readData().then((data){
      setState(() {
        _toDoList = json.decode(data!);
      });
    });
  }

  void _addTodo(){
    setState((){
      Map<String, dynamic> newTodo = Map();
      newTodo['title'] = _toDoController.text;
      _toDoController.text = '';
      newTodo['ok'] = false;
      _toDoList.add(newTodo);
      _saveData();
    });
  }

  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b){
        if(a['ok'] && !b['ok'])return 1;
        else if(!a['ok'] && b['ok'])return -1;
        else return 0;
      });
      _saveData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Advanced List'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children:[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                      labelText: 'New Task',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                RaisedButton(
                    child: Text('ADD',),
                    textColor: Colors.white,
                    color: Colors.black,
                    onPressed:_addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15),
                itemCount: _toDoList.length,
                itemBuilder: buildItem),
              onRefresh: _refresh,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        background:  Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white,),
          ),
        ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]['title']),
        onChanged: (bool? c) {
          setState(() {
            _toDoList[index]['ok'] = c;
            _saveData();
          });
        },
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]['ok'] ?
          Icons.check : Icons.error),),
        value: _toDoList[index]['ok'],
      ),
      onDismissed: (direction){
          setState(() {
            _lastRemoved = Map.from(_toDoList[index]);
            _lastRemovedPos = index;
            _toDoList.removeAt(index);
            _saveData();
            
            final snack = SnackBar(
              content:
              Text('Tarefa\'${_lastRemoved!['title']}\''),
              action: SnackBarAction(
                label: 'Desfazer',
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos!, _lastRemoved);
                    _saveData();
                  });
                },
              ),
              duration: Duration(seconds: 2),
            );
            Scaffold.of(context).showSnackBar(snack);
          });
      },
    );
  }

  Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    }catch (e){
      return null;
    }
  }

}



