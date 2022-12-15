import 'package:cloud_firestore/cloud_firestore.dart';

class ItemData{

  String? id;
  String? NomeDoProduto;
  double? PrecoDoProduto;
  List? images;

  ItemData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.get('time');
    NomeDoProduto = snapshot.get('Nome do Produto');
    PrecoDoProduto = snapshot.get('Preço do Produto') + 0.0;
    images = snapshot.get('Imagem Produto');

  }

}