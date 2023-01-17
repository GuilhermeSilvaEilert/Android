import 'package:sqflite/sqflite.dart';

class ExecutaDataBase{

 CriaDataBase() async {
  var db = await openDatabase('DbCores');

  await db.execute(
   'CREATE TABLE CorBoxes ('
       'id INTEGER PRIMARY KEY, '
       'Red INTEGER, '
       'Blue INTEGER, '
       'Green INTEGER, '
       'Opacidade INTEGER)'
  );
  await db.execute(
      'CREATE TABLE CorDrawer ('
          'id INTEGER PRIMARY KEY, '
          'Red INTEGER, '
          'Blue INTEGER, '
          'Green INTEGER, '
          'Opacidade INTEGER)'
  );
  await db.execute(
      'CREATE TABLE CorFundo ('
          'id INTEGER PRIMARY KEY, '
          'Red INTEGER, '
          'Blue INTEGER, '
          'Green INTEGER, '
          'Opacidade INTEGER)'
  );
  await db.execute(
      'CREATE TABLE CorBotoes ('
          'id INTEGER PRIMARY KEY, '
          'Red INTEGER, '
          'Blue INTEGER, '
          'Green INTEGER, '
          'Opacidade INTEGER)'
  );

 }




}