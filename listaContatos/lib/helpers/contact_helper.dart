import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



final String contactTable = 'contactTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String emailColumn = 'emailColumn';
final String phoneColumn = 'phoneColumn';
final String imgColum = 'imgColum';

class ContactHelper{

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;


  ContactHelper.internal();

  Database? _db;

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }else{

      return _db;
    }
  }

  Future<Contact> saveContact(Contact? contact) async {
    Database? dbContact = await db;
    contact!.id = await dbContact!.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact?> getContact(int id) async{
    Database? dbContact = await db;
    List<Map> maps = await dbContact!.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColum],
      where: '$idColumn = ?',
      whereArgs: [id]);
    if(maps.length>0){
      return Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }
  Future<int> deletedContact(int id) async {
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



  Future close() async{
    Database? dbContact = await db;
    dbContact!.close();
  }

}
/*
  Atributos da Tabela
  id  name       email      phone       img
  0   Guilherme  gui.eilert 51991343726 /assets/perf
                 @gmail.com

 */
class Contact{

  int? id;
  String? name;
  String? email;
  String? phone;
  String? img;

  Contact();

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColum];
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn:email,
      phoneColumn: phone,
      imgColum: img,
    };

    if(id != null){
      map[idColumn]=id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Contact('
        'id:$id, '
        'name: $name,'
        'email: $email,'
        'phone: $phone,'
        'img: $img';
  }
}