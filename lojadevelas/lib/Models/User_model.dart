import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  void signUp({
     Map<String, dynamic>? userData,
     String? pass,
     VoidCallback? onSuccess,
     VoidCallback? onFail,
  }) async{

    isLoading = true;
    notifyListeners();

    _auth!.createUserWithEmailAndPassword(
        email: userData!['email'],
        password: pass!,
    ).then((auth) async{
      firebaseUser = auth!.user;

     await _saveUserData(userData!);

      onSuccess!();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      onFail!();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn({
    String? email,
    String? pass,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  })  async {
    isLoading = true;
    notifyListeners();

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

  void signOut() async{
   await _auth!.signOut();
   userData = Map();
   firebaseUser = null;
   notifyListeners();
  }

  bool isLoggedIn(){

    return firebaseUser != null;

  }

  Future<Null> _saveUserData(Map<String , dynamic>?userData) async{
    this.userData = userData!;
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(firebaseUser!.uid!)
        .set(userData);
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