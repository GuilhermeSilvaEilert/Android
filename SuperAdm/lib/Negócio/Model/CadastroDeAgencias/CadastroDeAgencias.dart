import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CadastroDeAgencias{

  CadastraAgencias({
    String? NomeAgencia,
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
        'Nome': NomeAgencia,
        'Cidade': Cidade,
        'Imagem': url,
        'Endereco': Rua,
        'Numero': NumeroEndereco,
        'LocalStorage': File,
        'Cep': Cep,
        'Latitude': Latitude,
        'Longitude':Longitude,
      };

      FirebaseFirestore.instance.collection('Empresa')
          .doc(NomeAgencia).set(data);
    }


  }

}