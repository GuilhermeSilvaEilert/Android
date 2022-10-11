import 'package:flutter/material.dart';
import 'package:listacontatos/helpers/contact_helper_windows.dart';

class SQLite3Teste extends StatefulWidget {
  const SQLite3Teste({Key? key}) : super(key: key);

  @override
  State<SQLite3Teste> createState() => _SQLite3TesteState();
}

class _SQLite3TesteState extends State<SQLite3Teste> {
  DataBaseSqliteWindows _database = new DataBaseSqliteWindows();

  @override
  void initState() {
    // TODO: implement initState
    _database.initDb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Testando initDB'),
          TextButton(
              onPressed: (){

              },
              child:Text('Teste insert'))
        ],
      ),
    );
  }
}
