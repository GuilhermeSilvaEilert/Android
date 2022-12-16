import 'package:cloud_firestore/cloud_firestore.dart';

class ItemData{
  String? category;
  String? id;
  String? NomeDoProduto;
  double? PrecoDoProduto;
  String? images;

  ItemData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    images = snapshot.get('Imagem');
    NomeDoProduto = snapshot.get('Nome');
    PrecoDoProduto = snapshot.get('Preco') + 0.0;

    print('$id, $NomeDoProduto, $PrecoDoProduto, $images');
  }

}