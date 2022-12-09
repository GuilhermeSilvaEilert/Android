import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AdmHomePage extends StatefulWidget {
  const AdmHomePage({Key? key}) : super(key: key);

  @override
  State<AdmHomePage> createState() => _AdmHomePageState();
}

class _AdmHomePageState extends State<AdmHomePage> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
        title: Row(
          children: [
            Image.asset('Assets/LogoMarca/LogoMarcaTG.png', height: 50, width: 50,),
            SizedBox(width: 10,),
            Text('Seu Cardapio', style:TextStyle(fontWeight: FontWeight.bold),),
          ],
        )
      ),
       body: Container(
         alignment: Alignment.center,
         child: IconButton(
           onPressed: (){
               showModalBottomSheet(
                   context: context,
                   builder: (context){
                     return BottomSheet(
                       builder: (context){
                         return Container(
                           padding: EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: FloatingActionButton(
                                       onPressed: () async {
                                         Navigator.pop(context);
                                        final PickedFile? imgFile = await ImagePicker.platform.pickImage(source: ImageSource.camera);
                                         if(imgFile == null) return;

                                       },
                                       backgroundColor: Colors.red,
                                       child:  Icon(Icons.photo_camera, color: Colors.white),
                                     ),
                                   ),
                                   Text('Camera'),
                                 ],
                               ),
                               Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: FloatingActionButton(
                                       backgroundColor: Colors.red,
                                       onPressed: () {
                                         Navigator.pop(context);
                                         _picker.pickImage(source: ImageSource.gallery).then((file){
                                           if(file == null) return;
                                           setState(() {
                                           });
                                         });
                                       },
                                       child: Icon(Icons.photo_album, color: Colors.white),
                                     ),
                                   ),
                                   Text('Galeria'),
                                 ],
                               ),
                             ],
                           ),
                         );
                       }, onClosing: () {  },
                     );
                   });
             },
           icon: Column(
             children: [
               Icon(Icons.add_a_photo),
             ],
           ),
         ),
       ),
    );

  }
}
