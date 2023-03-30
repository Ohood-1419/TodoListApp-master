import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:project1/model/note.dart';

import '../Home/home.dart';
import '../Home/widgets.dart';

class UpdateNote extends StatelessWidget {
  final Note notes;
  UpdateNote({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final TextEditingController taskController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    taskController.text = notes.task;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
        title: const Text('Edit Task'),
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
                      // ToDO: Update a notes

                      Note updatedNotes = Note(
                        id: notes.id,
                        task: taskController.text,
                      );
                      //

                      final collectionReference =
                          FirebaseFirestore.instance.collection('notes');
                      collectionReference
                          .doc(updatedNotes.id)
                          .update(updatedNotes.toJson())
                          .whenComplete(() {
                        log('Note Updated');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                      });
                    },
                    child: const Text('Update'),
                    //edit style
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple[900],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //      backgroundColor: Colors.blueGrey
                        ),
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
