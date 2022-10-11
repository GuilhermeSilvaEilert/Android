import 'package:flutter/material.dart';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'package:listacontatos/helpers/contact_helper_windows.dart';
import 'package:listacontatos/ui/Home.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({this.contact});

  final Contact? contact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final _nameFocus = FocusNode();

  //ContactHelper? helper = ContactHelper();
  DataBaseSqliteWindows sqliteWindows =DataBaseSqliteWindows();

  List<Contact> contacts = [];

  bool _userEdited = false;
  Contact? _editedContact;

  @override
  void initState() {
    if(widget.contact == null){
      _editedContact = Contact();
    }else{
      _editedContact = Contact.fromMap(widget.contact!.toMap());
      _nameController.text = _editedContact!.name!;
      _emailController.text = _editedContact!.email!;
      _phoneController.text = _editedContact!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() {
        return _requestPop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedContact!.name ?? 'Novo Contato'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          backgroundColor: Colors.red,
          onPressed: (){
            setState((){
              getAllContacts();
            });
            if(_editedContact?.name != null && _editedContact!.name!.isNotEmpty){
              Navigator.pop(context, _editedContact);
            }else{
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedContact?.img != null ?
                        FileImage(File( _editedContact!.img!),) :
                        AssetImage('Images/img.png') as ImageProvider
                    ),
                  ),
                ),
                onTap: (){
                  _ShowOptions();
                },
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  labelText: 'Nome',),
                  onChanged:(text){
                    setState((){
                      _userEdited = true;
                      _editedContact?.name = text;
                    });
                  },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',),
                onChanged:(text){
                  _userEdited = true;
                  _editedContact?.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',),
                onChanged:(text){
                  _userEdited = true;
                  _editedContact?.phone = text;
                },
                  keyboardType: TextInputType.phone
              ),
            ],
          ),
        ),
      ),
    );
  }
 Future<bool> _requestPop() async {
    if(_userEdited){
      showDialog(context: context,
        builder: (context){
        return AlertDialog(
          title: Text('Descartar alterações ?'),
          content: Text('Se sair as alterações serão perdidas'),
          actions: [
            TextButton(
              child: Text('cancelar'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
              TextButton(
                child: Text('Sim'),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
          ],
        );
        }
      );
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

  void getAllContacts(){
    setState((){
     sqliteWindows!.getAllContacts().then((list){
        contacts = list as List<Contact>;
      });
    });
  }

  void _ShowOptions(){
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
                            onPressed: () {
                              Navigator.pop(context);
                              _picker.pickImage(source: ImageSource.camera).then((file){
                                if(file == null) return;
                                setState(() {
                                  _editedContact!.img = file.path;
                                });
                              });
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
                                  _editedContact!.img = file.path;
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
  }

}
