// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cardapiovirtual/Model/itemModel.dart';
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
  });

  var BottomNavigationBar;
  var AppBar;
  var Body;
  var TextAppBar;
  var floatingActionButtonAnimator;
  var floatingActionButtonLocation;
  var floatingActionButton;
  var drawer;

  @override
  State<ScaffoldMultiColor> createState() => _ScaffoldMultiColorState();
}

class _ScaffoldMultiColorState extends State<ScaffoldMultiColor> {
  var erro;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: widget.TextAppBar == null
              ? null
              : AppBar(
                  backgroundColor: Color.fromARGB(
                    255,
                    78,
                    90,
                    85,
                  ),
                  title: widget.TextAppBar,
                  centerTitle: true,
                ),
          backgroundColor: Color.fromARGB(
            255,
            78,
            90,
            85,
          ),
          body: widget.Body,
          bottomNavigationBar: widget.BottomNavigationBar,
          floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          floatingActionButton: widget.floatingActionButton,
          drawer: widget.drawer,
        );
      },
    );
  }
}
