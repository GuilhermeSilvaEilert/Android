import 'dart:io';
import 'package:cardapiovirtualmodulogarcom/Repository/SQLiteDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class CardapioModel extends Model{

  bool? isLoading = false;

  FirebaseAuth? _auth = FirebaseAuth.instance;

  User? firebaseUser;

  Endereco endereco = Endereco();

  SQLiteDB liteDB = SQLiteDB();

  User? usuarioGarcom;
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
    _loadCurrentUser();
  }

  Map<String?, dynamic>? userData = Map();


  void signIn({
    String? email,
    String? pass,
    String? UserRoot,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  })  async {
    signOut();

    isLoading = true;
    notifyListeners();

    print(email);
    print(pass);

    _auth!.signInWithEmailAndPassword (
      email: email!,
      password: pass!,
    ).then((auth) async {

      firebaseUser = auth!.user;

      await _loadCurrentUser();

      onSucess!();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      onFail!();
      isLoading = false;
      notifyListeners();
    });

    isLoading = false;
    notifyListeners();
  }

  recoverPass(
      String email,
      ) async {

    _auth!.sendPasswordResetEmail(email: email);

  }

  EditaUsuarioGarcom ({
    String? OldEmail,
    String? NomeUsuario,
    File? imgFile,
    String? NewEmail,
    String? url,
    String? OldLocalStorage,
    String? NewLocalStorage,
    VoidCallback? Sucesso,
    VoidCallback? Falha,
  }) async {

    print(
        '\n $OldEmail' +
            '\n $NomeUsuario' +
            '\n $imgFile'
    );
    isLoading = true;
    notifyListeners();

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;

    if(url != null && OldEmail != null && OldEmail == NewEmail && imgFile == null){
      print('Edita Nome');
      Map<String, dynamic> data = {
        'NomeUsuario': NomeUsuario,
        'Email': OldEmail,
        'Imagem': url,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'LocalStorage': OldLocalStorage,
      };

      await FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(_auth!.currentUser!.email)
          .collection('Usuario Garçom')
          .doc(OldEmail).delete();

      await FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(_auth!.currentUser!.email)
          .collection('Usuario Garçom')
          .doc(OldEmail).set(data);

      Sucesso!();
      isLoading = false;
      notifyListeners();

    }else if (imgFile != null) {
      print('Edita Nome e Foto');

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'NomeUsuario': NomeUsuario,
        'Email': OldEmail,
        'Imagem': url,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'LocalStorage': NewLocalStorage
      };

      await FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(_auth!.currentUser!.email)
          .collection('Usuario Garçom')
          .doc(OldEmail).delete();

      await FirebaseStorage.instance.ref(OldLocalStorage).delete();

      await FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(_auth!.currentUser!.email)
          .collection('Usuario Garçom')
          .doc(OldEmail).set(data);

      Sucesso!();
      isLoading = false;
      notifyListeners();
    }else{
      print('valores nulos');
      Falha!();
      isLoading = false;
      notifyListeners();
    }

  }

  void signOut() async{
    await _auth!.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  bool isLoggedIn(){

    return firebaseUser != null;

  }

  ExcluiGarcom({
    var EmailRef,
    String? fileStorage,
    VoidCallback? Sucesso,
    VoidCallback? Falha,
  }){
    isLoading = true;
    notifyListeners();

    FirebaseStorage.instance.ref(fileStorage).delete();
    FirebaseFirestore
        .instance
        .collection('Usuario raiz')
        .doc(_auth!.currentUser!.email)
        .collection('Usuario Garçom')
        .doc(EmailRef)
        .delete();
    firebaseUser = EmailRef!;
    firebaseUser!.delete().then((auth){
      Sucesso!();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      Falha!();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<Null>? _loadCurrentUser() async {
    if(firebaseUser == null){
      firebaseUser = await _auth!.currentUser!;
    }
    if(firebaseUser != null){
      if(userData!['NomeUsuario'] == null){
        DocumentSnapshot docUser =  await FirebaseFirestore
            .instance
            .collection('Usuario raiz')
            .doc(_auth!.currentUser!.email)
            .get();
        userData = await docUser.data() as Map<String?, dynamic>?;
      }
    }
    notifyListeners();

  }

}