import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class CriaSenhaModel extends Model {

  bool? isLoading = false;

  User? usuarioGarcom;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  Map<String?, dynamic>? userData = Map();


  void CriaSenhaGarcom({
    String? UserRoot,
    String? QuantidadeComandas,
    String? QuantidadePessoas,
    String? NumeroMesa,
    String? ValorSenha,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  }) async {
    isLoading = true;
    notifyListeners();

    print(UserRoot);
    Map<String, dynamic> DataSenha = {
      'QuantidadeComandas': QuantidadeComandas,
      'QuantidadePessoas': QuantidadePessoas,
      'QuantidadeComandas': QuantidadeComandas,
      'NumeroMesa': NumeroMesa
    };

    if (UserRoot != null && QuantidadeComandas != null && QuantidadeComandas != '0') {
      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('MesasAguardandoAtendimento')
          .doc(ValorSenha!)
          .set(DataSenha);

      onSucess!();
      isLoading = false;
      notifyListeners();

    } else {
      onFail!();
      isLoading = false;
      notifyListeners();
    }
  }
}
