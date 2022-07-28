import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
   TextComposer( this.sendMessage, {Key? key}) : super(key: key);

  Function(String) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

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
              onPressed: (){},),
          Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'Enviar uma mensagem',
                ),
                onChanged: (text){
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text){
                  widget.sendMessage(text);
                },
              ),),
          IconButton(
              onPressed: _isComposing ? (){
                widget.sendMessage(_controller.text);
              } : null,
              icon: Icon(Icons.send),),
        ],
      ),
    );
  }
}
