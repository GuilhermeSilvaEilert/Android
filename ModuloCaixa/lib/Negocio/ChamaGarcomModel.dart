import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ChamaGarcomModel extends Model{

  bool? isLoading = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  void CriaSenhaGarcom({
    String? UserRoot,
    String? QuantidadeComandas,
    String? QuantidadePessoas,
    String? NumeroMesa,
    String? ValorSenha,
    VoidCallback? onSucess,
    VoidCallback? onFail,
    String? ValorChamado,
    String? time,
  }) async {
    print(UserRoot);
    Map<String, dynamic> DataSenha = {
      'QuantidadeComandas': QuantidadeComandas,
      'QuantidadePessoas': QuantidadePessoas,
      'QuantidadeComandas': QuantidadeComandas,
      'NumeroMesa': NumeroMesa,
      'NumeroSenha':ValorChamado,
      'Time':time,
    };

    if (UserRoot != null && ValorChamado != null && ValorChamado != '0') {
      await FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('MesasAguardandoAtendimento')
          .doc(ValorChamado)
          .set(DataSenha);
      onSucess!();
    } else {
      onFail!();
    }
  }

}