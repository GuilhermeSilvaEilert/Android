import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class AtualizaComandaModel extends Model{

  bool? isLoading = false;

  User? usuarioGarcom;
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  Map<String?, dynamic>? userData = Map();


  void AtualizaComanda({
    String? NumeroComanda,
    String? UserRoot,
    String? Categoria,
    String? Item,
    int? QuantidadeItem,
    String? ImagemItem,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  }) async {

    isLoading = true;
    notifyListeners();

    print(UserRoot);
    Map<String, dynamic> DataComanda = {
      'ItemComanda' : Item,
      'Categoria' : Categoria,
      'QuantidadeItens': QuantidadeItem.toString(),
      'Imagem': ImagemItem,
    };

    if(UserRoot != null && NumeroComanda != null && QuantidadeItem != '0'){
      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('comandas')
          .doc(NumeroComanda.toString())
          .collection('Itens').doc(Item).update(DataComanda);
      isLoading = false;
      notifyListeners();
      onSucess!();
    }else{
      isLoading = false;
      notifyListeners();
      onFail!();
    }

  }
}