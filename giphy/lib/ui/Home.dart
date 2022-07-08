import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Uri? _search;
  int _offset = 0;

 Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(Uri.parse( 'https://api.giphy.com/v1/gifs/trending?api_key=YVZHN2KyReaSqctEefCFDIDgfwzRvam4&limit=25&rating=g'),);
    } else {
      response = await http.get(Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=YVZHN2KyReaSqctEefCFDIDgfwzRvam4&q=$_search&limit=20&offset=$_offset&rating=g&lang=en'));
    }

    return json.decode(response.body);
  }

  @override
  void initState(){
   super.initState();
   _getGifs().then((map){
     print(map);
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network('https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body:Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquise seu gif',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    color: Colors.white,
                    width: 23
                  ),
                ),
              ),
              style: TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
    )
    );
  }
}