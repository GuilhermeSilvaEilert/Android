import 'dart:async';
import 'dart:html' as html;
import 'dart:math';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common/utils/utils.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi_web/src/sw/constants.dart';
import 'package:sqflite_common_ffi_web/src/web/load_sqlite_web.dart'
    show SqfliteFfiWebContextExt;


final String contactTable = 'contactTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String emailColumn = 'emailColumn';
final String phoneColumn = 'phoneColumn';
final String imgColum = 'imgColum';


class _Data {
  late Database db;
}

class contact_helper_web{

  String? database;

  final _Data data = _Data();
  var databaseFactory = createDatabaseFactoryFfiWeb();
  var Factory = databaseFactoryFfiWeb;


  Future<Database> get db async{
    Database _db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  Future initDb() async{
    var db = data.db = await Factory.openDatabase(inMemoryDatabasePath);
    return await db.execute(''
        'CREATE TABLE $contactTable('
        '$idColumn INTEGER PRIMARY KEY,'
        '$nameColumn TEXT,'
        '$emailColumn TEXT,'
        '$phoneColumn TEXT,'
        '$imgColum TEXT'
        ');''');

  }

  Future<Contact> insertItem(Contact contact) async{
    sqfliteFfiInit();
    var db = await Factory.openDatabase(inMemoryDatabasePath);
    contact!.id = await db.insert(contactTable, contact.toMap());
    return contact;
  }

  Future getContact(int id) async{
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfiWeb;
    var db = await Factory.openDatabase(inMemoryDatabasePath);
    List<Map> maps = await db!.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColum],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if(maps.length>0){
      return Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<List> getAllContacts() async {
    sqfliteFfiInit();
    var db = await Factory.openDatabase(inMemoryDatabasePath);
    List listMap = await db.rawQuery('SELECT * FROM $contactTable');
    List<Contact> listContact = [];
    for(Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }
    print(listContact);
    return listContact;
  }

  Future<int> deletedContact(int id) async {
    sqfliteFfiInit();
    var db = await Factory.openDatabase(inMemoryDatabasePath);
    Database? dbContact = await db;
    return await dbContact!.delete(contactTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    sqfliteFfiInit();
    Database? dbContact = await db;
    return await dbContact!.update(contactTable, contact.toMap(), where: '$idColumn = ?', whereArgs: [contact.id]);
  }

  Future<int?> getNumber() async{
    sqfliteFfiInit();
    Database? dbContact = await db;
    return Sqflite.firstIntValue(await dbContact!.rawQuery('SELECT COUNT(*) FROM $contactTable'));
  }
}
