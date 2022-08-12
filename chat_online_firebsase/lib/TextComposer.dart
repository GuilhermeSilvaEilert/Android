
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
   TextComposer({Key? key, required this.sendMessage}) : super(key: key);

  final Function({String? text, File? imgFile}) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  ImagePicker _picker = ImagePicker();

  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async{
                final XFile? imgFile =
                await _picker.pickImage(source: ImageSource.camera);
                if(imgFile == null){
                  return;
                }
                File fileSend = File(imgFile.path);
                await widget.sendMessage(imgFile: fileSend);
              },),
          Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration.collapsed(
                    hintText: 'Enviar uma mensagem',
                ),
                onChanged: (text){
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text){
                  widget.sendMessage(text:text);
                  _reset();
                },
              ),),
          IconButton(
              onPressed: _isComposing ? (){
                widget.sendMessage(text: _controller.text);
                _reset();
              } : null,
              icon: Icon(Icons.send),),
        ],
      ),
    );
  }
}
