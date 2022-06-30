import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?format=json&key=be53b38f';

void main() async{

  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

  Future<Map> _getData() async{
    http.Response response = await http.get(Uri.parse(request));
    return json.decode(response.body);
  }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final euroController = TextEditingController();
  final dolarController = TextEditingController();

  double? dolar;
  double? euro;
  double? validaEuro = 0.00;
  double? validaDolar = 0.00;
  double? validaReal = 0.00;

  void _realChanged(String text){
   if((text == '0.00'|| text.isEmpty)){
      dolarController.text = '';
      euroController.text = '';
    }else{
      double? real = double.parse(text);
      validaDolar = double.parse(text);
      validaEuro = double.parse(text);
      dolarController.text = (real/(dolar!)).toStringAsFixed(2);
      euroController.text = (real/euro!).toStringAsFixed(2);
    }
  }

  void _dolarChanged(String text){
    if((text == '0.00' || text.isEmpty)){
      realController.text = '';
      euroController.text = '';
    }else{
      double? dolar = double.parse(text);
      validaReal = double.parse(text);
      validaEuro = double.parse(text);
      realController.text = (dolar*this.dolar!).toStringAsFixed(2);
      euroController.text = (dolar*this.dolar!/euro!).toStringAsFixed(2);
    }
  }

  void _euroChanged(String text){
    if((text == '0.00' || text.isEmpty)){
      dolarController.text = '';
      realController.text = '';
    }else{
      double euro = double.parse(text);
      validaDolar = double.parse(text);
      validaReal = double.parse(text);
      realController.text = (euro * this.euro!).toStringAsFixed(2);
      dolarController.text = (euro * this.euro!/dolar!).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text('Carregando Dados', style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if(snapshot.hasError){
               return const Center(
                  child: Text('Erro nos Dados', style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,),
                    textAlign: TextAlign.center,),
                );
              }else{
                dolar = snapshot.data!['results']['currencies']['USD']['buy'];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:<Widget> [
                        const Icon(Icons.monetization_on, size: 150, color: Colors.amber,),
                        buildTextField('Reais','R\$', realController, _realChanged),
                        const Divider(),
                        buildTextField('Dolares', 'US\$', dolarController, _dolarChanged),
                        const Divider(),
                        buildTextField('Euros', '€', euroController, _euroChanged),
                      ],
                    ),
                  ),
                );
              }
          }
        }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){
          realController.clear();
          dolarController.clear();
          euroController.clear();
        },
        child: const Icon(Icons.refresh,
        color: Colors.black,
        ),
      ),
      );
    }
  }

 Widget buildTextField( String label, String prefix, TextEditingController control, Function(String) f){
    return TextField(

      controller: control,
      decoration: InputDecoration(
        labelText: label ,
        labelStyle: const TextStyle(color: Colors.amber),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.amber),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        prefixText: prefix,
        prefixStyle: const TextStyle(
            color: Colors.amber
        ),
      ),
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
      onChanged: f,
      keyboardType: TextInputType.number,
    );
  }


  /*

  switch(snapshot.connectionState){
            case ConnectionState.done:
            case ConnectionState.waiting:
              return Center(
                child: Text('Carregando dados...',
                  style: TextStyle(
                    color: Colors.amber, fontSize: 25,),
                  textAlign: TextAlign.center,),);
            default:
              if(snapshot.hasError){
                Center(
                  child: Text('Erro ao retornar dados :/',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }else{
                return Container(
                  color: Colors.green,
                );
              }
          }

   */