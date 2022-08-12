import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage:  NetworkImage(data['senderPhotoUrl']),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data['imgurl'] != null ?
                  Image.network(data['imgurl'])
            :
            Text(data['text'],
              style:TextStyle(
                  fontSize: 16),
            ),
                  Text
                    (data['sendserName'],
                    style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                ],    
              ),
          ),
        ],
      ),
    );
  }
}
