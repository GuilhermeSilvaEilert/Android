import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String? id;
  String? title;
  String? description;
  double? preco;
  List? images;
  List? sizes;
  String? category;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot.get('title');
    description = snapshot.get('descricao');
    preco = snapshot.get('preco') + 0.0;
    images = snapshot.get('image');
    sizes = snapshot.get('size');
  }
}