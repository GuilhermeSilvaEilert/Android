import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

final String EnderecoTable = 'Endreco';
final String idColum = 'idColum';
final String EmailColumn = 'EmailColumn';
final String EmpresaColum = 'EmpresaColum';

class SQLiteDB {

  /*static final SQLiteDB _instance = SQLiteDB.internal();

  factory SQLiteDB()=>_instance;

  SQLiteDB.internal();

  /*Database? _db;

  Database? enderecoFirebase;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }*/


    var _db = databaseFactoryFfiWeb;

  Future<Database> initDb({String? endereco}) async {
    await _db.openDatabase('test_missing');
    final path = await join(databasesPath, 'UserRootTeste.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database? db, int newerVersion) async {
          print('Cria table');
          await db!.execute(
              'CREATE TABLE $EnderecoTable ('
                  '$idColum INTEGER PRIMARY KEY,'
                  '$EmailColumn TEXT,'
                  '$EmpresaColum TEXT,'
                  ');');
        });
  }

  Future<Endereco> SaveEndereco(Endereco endereco) async {
    Database? dbendereco = await db;
    endereco.id = await dbendereco!.insert('$EnderecoTable', endereco.toMap());
    return endereco;
  }

  Future<Endereco?> getEndereco(int id) async {
    Database? dbendereco = await db;
    List<Map> maps = await dbendereco!.query(EnderecoTable,
      columns: [idColum, EmailColumn, EmpresaColum],
      where:'$idColum = ?',
      whereArgs: [id],
    );
    if(maps.length > 0){
      return Endereco.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<List> getAllEmail() async{
    Database? dbEndereco = await db;
    List listMap = await dbEndereco!.rawQuery('SELECT * FROM $EnderecoTable');
    List<Endereco> listEndereco = [];
    for(Map m in listMap){
      listEndereco.add(Endereco.fromMap(m));
    }
    return listEndereco;
  }
*/
}

class Endereco {

  Endereco();

  //String? EmailEndereco;
  int? id;
  String? Empresa;

  Endereco.fromMap(Map map){
   // id = map[idColum];
    //EmailEndereco = map[EmailColumn];
    Empresa = map[EmpresaColum];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      //EmailColumn: EmailEndereco,
      EmpresaColum: Empresa,
    };
    if(id != null){
      map[idColum] = id;
    }
    return map;
  }

  @override
  String toString(){
    return 'Endereco(id: $id, Empresa: $Empresa)';
  }

}