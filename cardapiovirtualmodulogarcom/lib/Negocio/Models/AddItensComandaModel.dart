import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class CriaComandaModel extends Model{

  bool? isLoading = false;

  User? usuarioGarcom;
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  Map<String?, dynamic>? userData = Map();


  void AdicionaComanda({
    String? NumeroComanda,
    String? UserRoot,
    String? Categoria,
    String? Item,
    String? QuantidadeItem,
    String? ImagemItem,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  }) async {

    print(UserRoot);
    Map<String, dynamic> DataComanda = {
      'ItemComanda' : Item,
      'Categoria' : Categoria,
      'QuantidadeItens': QuantidadeItem,
      'Imagem': ImagemItem,
    };

    if(UserRoot != null && NumeroComanda != null && QuantidadeItem != '0'){
      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('comandas')
          .doc(NumeroComanda.toString())
          .collection('Itens').doc(Item).set(DataComanda);

      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('comandas')
          .doc(NumeroComanda.toString())
          .collection('Itens').doc(Item).update(DataComanda);
      onSucess!();
    }else{
      onFail!();
    }

  }
}