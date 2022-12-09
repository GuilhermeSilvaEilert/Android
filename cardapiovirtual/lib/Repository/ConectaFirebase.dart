import 'package:cardapiovirtual/Apresentacao/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ConectaFirebase{

  ConectarAoFirebase(String teste) async {
    await Firebase.initializeApp();
  }

  void _sendDados(String text, double preco, PickedFile imgFile){
    FirebaseFirestore.instance.collection('Precos').add({
      'Preco':text
    });
  }

}