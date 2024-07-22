import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CadastroDeAgenciaFilha{

  CadastraAgencias({
    String? NomeAgencia,
    String? NomedaFranquia,
    String? Pais,
    String? Cidade,
    String? Rua,
    String? NumeroEndereco,
    String? Estado,
    String? Cep,
    File? imgFile,
    String? File,
    String? Latitude,
    String? Longitude,
    UniqueKey? id,
  }) async {
    if(NomeAgencia != null && NomeAgencia != 'null'){

      String? request = "https://api.geoapify.com/v1/geocode/search?name=Teste&housenumber=$NumeroEndereco&street=$Rua&postcode=$Cep&city=$Cidade&state=$Estado&country=$Pais&format=json&apiKey=53e180dd53c04480a4d67e5470236406";

      http.Response response1 = await http.get(Uri.parse(request));

      Latitude = json.decode(response1.body)['results'][0]['lat'].toString();
      Longitude = json.decode(response1.body)['results'][0]['lon'].toString();

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Pais': Pais,
        'Nome': NomedaFranquia,
        'Cidade': Cidade,
        'Imagem': url,
        'Endereco': Rua,
        'Estado': Estado,
        'Numero': NumeroEndereco,
        'LocalStorage': File,
        'Cep': Cep,
        'Latitude': Latitude,
        'Longitude':Longitude,
      };

      FirebaseFirestore.instance.collection('Empresa')
          .doc(NomeAgencia).collection('Franquias')
          .doc(id.toString())
          .set(data);
    }else{
      print('${NomeAgencia}');
      print('Valores Nulos');
    }


  }

}