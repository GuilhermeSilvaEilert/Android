import 'package:chat_online_firebsase/TextComposer.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Log Chat', ),
        elevation: 0,
      ),
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:TextComposer((text){
                print(text);
            }
            ),
        ),
    );
  }
}
