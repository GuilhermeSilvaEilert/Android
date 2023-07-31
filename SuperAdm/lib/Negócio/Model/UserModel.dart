import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model{

  bool? isLoading = false;

  FirebaseAuth? _auth = FirebaseAuth.instance;

  User? firebaseUser;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
    _loadCurrentUser();
  }

  Map<String?, dynamic>? userData = Map();

  void signOut() async{
    await _auth!.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void signUp({
     String? Senha,
     VoidCallback? onSuccess,
     VoidCallback? onFail,
     File? imgFile,
     String? LocalStorage,
     String? Email,
     String? NomeUsuario,
     String? Empresa,
  }) async{

    isLoading = true;
    notifyListeners();

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;

    if (imgFile != null && NomeUsuario != null && Senha != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);
      Map<String, dynamic> userData = {
        'NomeUsuario': NomeUsuario,
        'Empresa': Empresa,
        'Email': Email,
        'Imagem': url,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'LocalStorage': LocalStorage
      };

      FirebaseFirestore.instance.collection('Usuario raiz').doc(firebaseUser!.email).set(userData);

      _auth!.createUserWithEmailAndPassword(
        email: userData!['Email'],
        password: Senha!,
      ).then((auth) async{


        onSuccess!();
        isLoading = false;
        notifyListeners();

      }).catchError((e){
        onFail!();
        isLoading = false;
        notifyListeners();
      });

    }
  }


  Future<Null>? _loadCurrentUser() async {
    if(firebaseUser == null){
      firebaseUser = await _auth!.currentUser!;
    }
      if(firebaseUser != null){
      if(userData!['name'] == null){
        DocumentSnapshot docUser =  await FirebaseFirestore
                                          .instance
                                          .collection('users')
                                          .doc(firebaseUser!.uid)
                                          .get();
        userData = await docUser.data() as Map<String?, dynamic>?;
      }
    }
    notifyListeners();

  }

}