import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String CaminhoTable = 'Caminho';
final String idColum = 'idColum';
final String EmailColumn = 'EmailColumn';
final String EmpresaColumn = 'EmpresaColumn';

class SQLiteDBCaminho {

  static final SQLiteDBCaminho _instance = SQLiteDBCaminho.internal();

  factory SQLiteDBCaminho()=>_instance;

  SQLiteDBCaminho.internal();

  Database? _db;

  Database? enderecoFirebase;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = await join(databasesPath, 'enderecoCaminhotester.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database? db, int newerVersion) async {
          print('Cria table');
          await db!.execute(
              'CREATE TABLE $CaminhoTable('
                  '$idColum INTEGER PRIMARY KEY,'
                  '$EmailColumn TEXT,'
                  '$EmpresaColumn TEXT'
                  ');');
        });
  }

  Future<Caminho> SaveEndereco(Caminho caminho) async {
    Database? dbendereco = await db;
    caminho.id = await dbendereco!.insert('$CaminhoTable', caminho.toMap());
    return caminho;
  }

  Future<Caminho?> getEndereco({int? id}) async {
    Database? dbendereco = await db;
    List<Map> maps = await dbendereco!.query(
      CaminhoTable,
      columns: [idColum, EmpresaColumn],
      where:'$idColum = ?',
      whereArgs: [id],
    );
    if(maps.length > 0){
      return Caminho.fromMap(maps.first);
    }else{
      return null;
    }
  }

  length() async{
    Database? dbEndereco = await db;
    int tamanhoLista;
    List listMap = await dbEndereco!.rawQuery('SELECT * FROM $CaminhoTable');
    List<Caminho> listEndereco = [];
    for(Map m in listMap){
      listEndereco.add(Caminho.fromMap(m));
    }
    tamanhoLista = listEndereco.length;
    return tamanhoLista;
  }

  Future<List> getAllEmail() async{
    Database? dbEndereco = await db;
    List listMap = await dbEndereco!.rawQuery('SELECT * FROM $CaminhoTable');
    List<Caminho> listEndereco = [];
    for(Map m in listMap){
      listEndereco.add(Caminho.fromMap(m));
    }
    return listEndereco;
  }

  Future close() async {
    Database? dbEndereco = await db;
    await dbEndereco!.close();
  }

}

class Caminho{

  Caminho();

  int? id;
  String? Empresa;
  String? Email;


  Caminho.fromMap(Map map){
    id = map['$idColum'];
    Empresa = map['$EmpresaColumn'];
    Email = map['$EmailColumn'];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      EmpresaColumn: Empresa,
      EmailColumn: Email,
    };

    if(id != null){
      map[idColum] = id;
    }
    return map;
  }
  @override
  String toString(){
    return 'Endereco(id: $id, Empresa:$Empresa, EnderecoEmail: $Email)';
  }
}