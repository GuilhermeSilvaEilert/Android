import 'dart:io';
import 'package:listacontatos/helpers/contact_helper_windows.dart';
import 'package:listacontatos/ui/TesteSQLite3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'package:listacontatos/ui/contact_page.dart';

enum OrderOptions{orderaz, orderza}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {
  DataBaseSqliteWindows sqliteWindows = DataBaseSqliteWindows();
  @override
  void initState(){
    super.initState();
    setState((){
      sqliteWindows.initDb();
      sqliteWindows.getAllContacts();
    });
  }

  ContactHelper? helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed:(){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => SQLite3Teste()));
              },
              child:Text('testa sqlite3',
                  style: TextStyle(
                      color: Colors.black
                  ))),
          PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                    child: Text('ordenar de A - Z'),
                    value: OrderOptions.orderaz,
                ),
                const PopupMenuItem<OrderOptions>(
                  child: Text('ordenar de Z - A'),
                  value: OrderOptions.orderza,
                ),
              ],
            onSelected: _orderList,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: (){
          sqliteWindows.getAllContacts();
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
        _ShowOptions(context, index);
      },
    );
  }

  void _ShowOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            launch('tel:${contacts[index].phone}');
                            Navigator.pop(context);
                          },
                          child: Text('Ligar',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            ),
                          ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contacts[index]);
                        },
                        child: Text('Editar',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          sqliteWindows.deletedContact(contacts[index].id!);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Excluir',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, onClosing: () {  },
          );
        });
  }

  void _showContactPage({Contact? contact}) async{
    final recContact = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ContactPage(contact: contact,),)
    );
    if(recContact != null){
      if(contact != null){
        await sqliteWindows.updateContact(recContact);
        getAllContacts();
      }else{
        await sqliteWindows.insertItem(recContact);
        getAllContacts();
      }
    }
  }
  void getAllContacts(){
      sqliteWindows.getAllContacts().then((list){
        setState((){
        contacts = list as List<Contact>;
      });
    });
  }
  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        contacts.sort((a, b) {
            return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
          throw ("Um dos nomes era nulo");
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a, b) {
         return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
        });
        break;
    }
    setState((){});
  }
}
