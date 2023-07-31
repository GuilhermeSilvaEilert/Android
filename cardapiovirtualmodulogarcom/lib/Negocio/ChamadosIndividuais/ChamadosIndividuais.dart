import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class ChamadosIndivisuais extends Model {

  bool? isLoading = false;

  User? usuarioGarcom;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  Map<String?, dynamic>? userData = Map();


  void CriaSenhaIndividualGarcom({
    String? EmailGarcom,
    String? UserRoot,
    String? QuantidadeComandas,
    String? QuantidadePessoas,
    String? NumeroMesa,
    String? ValorSenha,

  }) async {
    isLoading = true;
    notifyListeners();

    print(UserRoot);
    Map<String, dynamic> DataSenha = {
      'QuantidadeComandas': QuantidadeComandas,
      'QuantidadePessoas': QuantidadePessoas,
      'QuantidadeComandas': QuantidadeComandas,
      'NumeroMesa': NumeroMesa,
      'NumeroSenha': ValorSenha,
    };

    if (UserRoot != null && QuantidadeComandas != null && QuantidadeComandas != '0') {
      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('Usuario Garçom')
          .doc(EmailGarcom!)
          .collection('Chamados').doc(ValorSenha)
          .set(DataSenha);


      isLoading = false;
      notifyListeners();

    } else {

      isLoading = false;
      notifyListeners();
    }
  }
}
