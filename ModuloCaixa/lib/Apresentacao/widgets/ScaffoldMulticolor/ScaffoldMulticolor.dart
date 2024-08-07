// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';


class ScaffoldMultiColor extends StatefulWidget {
   ScaffoldMultiColor({
     this.AppBar,
     this.Body,
     this.TextAppBar,
     this.BottomNavigationBar,
     this.floatingActionButton,
     this.floatingActionButtonAnimator,
     this.floatingActionButtonLocation,
     this.drawer,
     this.actions,
   });

   var BottomNavigationBar;
   var AppBar;
   var Body;
   var TextAppBar;
   var floatingActionButtonAnimator;
   var floatingActionButtonLocation;
   var floatingActionButton;
   var drawer;
   var actions;

  @override
  State<ScaffoldMultiColor> createState() => _ScaffoldMultiColorState();
}

class _ScaffoldMultiColorState extends State<ScaffoldMultiColor> {

  var erro;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: FirebaseFirestore
                .instance
                .collection('Configurações')
                .doc('Cores')
                .collection('Configura Cores')
                .get(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }else{
                return Scaffold(
                  
                  appBar: widget.TextAppBar == null ? null
                      :
                  AppBar(
                    actions: widget.actions != null ? [widget.actions] : [],
                    backgroundColor: Color.fromARGB(
                      snapshot.data!.docs[1]['Opacidade'],
                      snapshot.data!.docs[1]['Red'],
                      snapshot.data!.docs[1]['Green'],
                      snapshot.data!.docs[1]['Blue'],
                    ),
                    title: widget.TextAppBar,
                    centerTitle: true,
                  ),

                  backgroundColor: Color.fromARGB(
                    snapshot.data!.docs[1]['Opacidade'],
                    snapshot.data!.docs[1]['Red'],
                    snapshot.data!.docs[1]['Green'],
                    snapshot.data!.docs[1]['Blue'],
                  ),

                  body: widget.Body,
                  bottomNavigationBar: widget.BottomNavigationBar,
                  floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
                  floatingActionButtonLocation: widget.floatingActionButtonLocation,
                  floatingActionButton: widget.floatingActionButton,
                  drawer: widget.drawer,
                );
              }
            },
          );

  }
}
