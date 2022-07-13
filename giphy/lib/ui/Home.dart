import 'dart:convert';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

import 'gif_page.dart';

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
      response = await http.get(Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=YVZHN2KyReaSqctEefCFDIDgfwzRvam4&q=$_search&limit=19&offset=$_offset&rating=g&lang=en'));
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
        children:  [
           Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (String text){
                setState((){
                  if(text.isEmpty || text == null || text == ' ') {
                    _offset += 19;
                  }else{
                    _search = Uri.parse(text);
                    _offset = 0;
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Pesquise seu gif',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5,
                          ),
                        );
                      case ConnectionState.none:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5,
                          ),
                        );
                      default:
                       if(snapshot.hasError) return Container(child: Text('Carregou tudo'),);
                       else
                         return _createGifTable(context, snapshot);
                    }
                  }
              ),
          ),
        ],
    )
    );
  }

  int getCount(List data){
   if(_search == null) {
     return data.length;
   }else{
     return data.length + 1;
   }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot){
   return GridView.builder(
     padding: EdgeInsets.all(10),
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount:2,
       crossAxisSpacing: 10,
       mainAxisSpacing: 10,
     ),
     itemCount: snapshot.data['data'].length,
     itemBuilder: (context, index){
       if(_search == null || index < snapshot.data['data'].length)
       return GestureDetector(
         child: FadeInImage.memoryNetwork(
             placeholder: kTransparentImage,
             image: snapshot.data['data'][index]['images']['fixed_height']['url'],
             height: 300,
             width: 300,
             fit: BoxFit.cover,
         ),
         onTap: (){
           Navigator.push(context,
           MaterialPageRoute(builder: (context) => GifPage(snapshot.data['data'][index])));
         },
         onLongPress: (){
           Share.share(snapshot.data['data'][index]['images']['fixed_height']['url']);
         },
       );
       else
         return Container(
           child: GestureDetector(
             child: Column (
               children: [
                 Icon(Icons.add, color: Colors.grey, size: 70,),
                 Text('Carregar mais ...',
                 style: TextStyle(color: Colors.white, fontSize: 22),),
               ],
             ),
             onTap: (){
               setState((){
                 _offset += 19;
               });
             }
           )
         );
     },
   );
  }

}