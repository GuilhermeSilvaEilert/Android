import 'dart:io';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final String contactTable = 'contactTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String emailColumn = 'emailColumn';
final String phoneColumn = 'phoneColumn';
final String imgColum = 'imgColum';

class DataBaseSqliteWindows{

  static final DataBaseSqliteWindows _instance = DataBaseSqliteWindows.internal();

  factory DataBaseSqliteWindows() => _instance;

  DataBaseSqliteWindows.internal();

  var databaseFactory = databaseFactoryFfi;

  String? database;

  Future<Database> get db async{
    var _db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  Future initDb() async{
    sqfliteFfiInit();
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
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
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    contact!.id = await db.insert(contactTable, contact.toMap());
    return contact;
  }


  Future getContact(int id) async{
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
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
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
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
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    Database? dbContact = await db;
    return await dbContact!.delete(contactTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database? dbContact = await db;
    return await dbContact!.update(contactTable, contact.toMap(), where: '$idColumn = ?', whereArgs: [contact.id]);
  }

  Future<int?> getNumber() async{
    Database? dbContact = await db;
    return Sqflite.firstIntValue(await dbContact!.rawQuery('SELECT COUNT(*) FROM $contactTable'));
  }

}

