import 'dart:io';
import 'package:chat_online_firebsase/TextComposer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey <ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _isLoading = false;


  @override
  void initState(){
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user){
      setState((){
        _currentUser = user!;
      });
    });
  }

  Future<User?> _getUser() async{
    if(_currentUser != null) {
      return _currentUser;
    }

    User? user;

    try{
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final  UserCredential authResult =
      await auth.signInWithCredential(credential);

      user = authResult.user;
      return user;
    }catch (error){
      return null;
    }
  }

  String collection = 'mensagensInstantaneas';

  Future<void> _sendMessage({String? text, File? imgFile}) async{
    final User? user = await _getUser();

    if(user == null){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
           content: Text('Não foi possivel fazer login'),
         backgroundColor: Colors.red,
       ),);
       }

    Map<String, dynamic> data = {
      'uid':user!.uid,
      'sendserName': user.displayName,
      'senderPhotoUrl': user.photoURL,
      'time': Timestamp.now(),
    };

    if (imgFile != null) {
    UploadTask task = FirebaseStorage.instance
        .ref()
        .child(user.uid + DateTime.now().microsecondsSinceEpoch.toString())
        .putFile(imgFile);
    setState(() {
      _isLoading =true;
    });
    TaskSnapshot taskSnapshot = await task;
    String url = await taskSnapshot.ref.getDownloadURL();
    data['imgurl'] = url;
    setState(() {
      _isLoading =true;
    });
  }
    if(text != null){
      data['text'] = text;
    }
    FirebaseFirestore.instance.collection(collection).add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          _currentUser != null ? 'Ola, ${_currentUser!.displayName!}': 'ChatApp'
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          _currentUser != null ?
          IconButton(
              onPressed: (){
                auth.signOut();
                googleSignIn.signOut();
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('deslogado com sucesso'),
                    backgroundColor: Colors.red,
                  ),);
                });
              },
              icon: Icon(Icons.logout),)
              :
              Container(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection(collection).orderBy('time').snapshots(),
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
                          reverse: true,
                          itemBuilder: (context, index){
                            return ChatMessage(
                                data:documents[index]!.data() as Map<String, dynamic>,
                                mine: documents[index]!.get('uid') == _currentUser?.uid,
                            );
                          }
                      );
                  }
                },
              ),
            ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(sendMessage: _sendMessage,),
          ],
        ),
    );
  }
}
