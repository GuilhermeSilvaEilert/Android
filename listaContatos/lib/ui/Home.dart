import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'package:listacontatos/ui/contact_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {

  ContactHelper? helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState(){
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: (){
          _showContactPage();
        },
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index){
            return _contactCard(context, index);
          }
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                    FileImage(File(contacts[index].img!),) :
                    AssetImage('Images/img.png') as ImageProvider
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text(contacts[index].name ?? "",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      Text(contacts[index].email ?? "",
                        style: TextStyle(fontSize: 18,),),
                      Text(contacts[index].phone ?? "",
                        style: TextStyle(fontSize: 18,),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        _showContactPage(contact: contacts[index]);
      },
    );
  }
  void _showContactPage({Contact? contact}) async{
    final recContact = await Navigator.push(context,
      MaterialPageRoute(builder: (context)=> ContactPage(contact: contact,),)
    );
    if(recContact != null){
      if(contact != null){
        await helper!.updateContact(recContact);
        _getAllContacts();
      }else{
        await helper!.saveContact(recContact);
      }
    }
  }
  void _getAllContacts(){

    setState((){
      helper!.getAllContacts().then((list){
        contacts = list as List<Contact>;
      });
    });
  }

}
