import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class RegistroDeComandas extends Model{

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  void RegistroDeComandasFechadas({
    String? UserRoot,
    String? Entradas,
    double? Saidas,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  }) async {

    if(UserRoot != null && Entradas != null && Saidas != null){

      Map<String, dynamic> Saida = {
        'Troco' : Saidas.toStringAsFixed(2),
        'Tipo' : 'Saida',
      };

      Map<String, dynamic> Entrada = {
        'PrecoTotal' : Entradas,
        'Tipo' : 'Entrada',
      };

      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('ControleCaixa')
          .add(Entrada);

      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('ControleCaixa')
          .add(Saida);

      onSucess!();
    }else{
      onFail!();
    }

  }
}

