import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:project1/model/note.dart';

import '../Home/home.dart';
import '../Home/review_todo_screen.dart';
import '../Home/widgets.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  final TextEditingController taskController = TextEditingController();

  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            getMyField(hintText: 'Task', controller: taskController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      Note notes = Note(
                        task: taskController.text,
                      );

                      // ToDO: Adding a notes
                      addNotesAndNavigateToHome(notes, context);
                      //
                    },
                    //edit style
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple[900],
                    ),
                    child: const Text('Add')),
                ElevatedButton(
                    onPressed: () {
                      //

                      taskController.text = '';

                      focusNode.requestFocus();
                      //
                    },
                    child: const Text('Reset')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
