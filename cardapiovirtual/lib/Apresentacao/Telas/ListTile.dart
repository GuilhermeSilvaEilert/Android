import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(snapshot.get('Imagem')),
      ),
      title: Text(snapshot.get('Nome'),),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){

      }
    );
  }
}
