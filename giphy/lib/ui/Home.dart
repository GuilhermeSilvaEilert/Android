import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _search;

  int _offset = 0;

 Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(
          'https://api.giphy.com/v1/gifs/trending?api_key=YVZHN2KyReaSqctEefCFDIDgfwzRvam4&limit=25&rating=g');
    } else {
      response = await http.get(
          'https://api.giphy.com/v1/gifs/search?api_key=YVZHN2KyReaSqctEefCFDIDgfwzRvam4&q=$_search&limit=$_offset&offset=25&rating=g&lang=en');
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
    return Container();
  }
}