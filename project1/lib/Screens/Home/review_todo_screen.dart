 
 import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project1/Screens/Home/home.dart';
import 'package:project1/model/note.dart';

 
 
 void addNotesAndNavigateToHome(Note note, BuildContext context) {
    //
    // Reference to firebase
    final notesRef = FirebaseFirestore.instance.collection('notes').doc();
    note.id = notesRef.id;
    final data = note.toJson();
    notesRef.set(data).whenComplete(() {
      //
      log('User inserted.');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false,
      );
      //
    });

    //
  }
 