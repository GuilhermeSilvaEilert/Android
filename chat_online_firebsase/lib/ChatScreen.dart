import 'dart:io';
import 'package:chat_online_firebsase/TextComposer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  final GoogleSignIn googleSignIn = GoogleSignIn();


  void getUser() async{
    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
    }catch (error){


    }

  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String collection = 'mensagensInstantaneas';

  Future<void> _sendMessage({String? text, File? imgFile}) async{
    final User user = await _getUser();


    Map<String, dynamic>data = {};

    if (imgFile != null) {
    UploadTask task = FirebaseStorage.instance
        .ref()
        .child(DateTime.now().microsecondsSinceEpoch.toString())
        .putFile(imgFile);
    TaskSnapshot taskSnapshot = await task;
    String url = await taskSnapshot.ref.getDownloadURL();
    data['imgurl'] = url;
  }
    if(text != null) data['text'] = text;
    FirebaseFirestore.instance.collection(collection).add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Log Chat', ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection(collection).snapshots(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot?> documents =
                      snapshot.data!.docs.reversed.toList();

                      return ListView.builder(
                          itemCount: documents.length,
                          reverse: false,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(documents[index]!.get('text')??'',),
                            );
                          }
                      );
                  }
                },
              ),
            ),
          TextComposer(sendMessage: _sendMessage,),
          ],
        ),
    );
  }
}
