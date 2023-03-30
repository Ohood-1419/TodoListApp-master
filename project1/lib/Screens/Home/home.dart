import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/note.dart';
import '../Note/addNote.dart';
import '../Note/updateNote.dart';
import 'CustomShape.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('notes');

  // List<Note> notes = [
  //   Note(id: 'id',  task: 'play game'),
  //  Note(id: 'id', task: 'read book'),,

  // ];
//current date
  String cdate = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 180,
          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Hey Ohood! ',
                    style: TextStyle(
                      fontSize: 32,
                      foreground: Paint()
                        ..style = PaintingStyle.fill
                        ..strokeWidth = 1
                        ..color = Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    cdate.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'To do list ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: true,
          flexibleSpace: ClipPath(
              clipper: Customshape(),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.deepPurple[900],
              )),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: _reference.get(),
          builder: (context, snapshot) {
            // Check for error
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            // if data received
            if (snapshot.hasData) {
              QuerySnapshot querySnapshot = snapshot.data!;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;
              // Convert data to List
              List<Note> notes = documents
                  .map((e) => Note(
                        id: e['id'],
                        task: e['task'],
                      ))
                  .toList();
              return _getBody(notes);
            } else {
              // Show Loading
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          // child: _getBody()
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue[700],
          shape: RoundedRectangleBorder(),
          heroTag: 'add',
          onPressed: (() {
            //
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNotes(),
                ));
            //
          }),
          child: const Icon(
            Icons.add,
          ),
        ));
  }

  Widget _getBody(notes) {
    return notes.isEmpty
        ? const Center(
            child: Text(
              'No task Yet\nClick + to start adding',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Card(
                  color: Colors.greenAccent[400],
                  child: ListTile(
                    title: Text(notes[index].task),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.black.withOpacity(0.75),
                            ),
                            onTap: () {
                              //
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateNote(notes: notes[index]),
                                  ));
                              //
                            },
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onTap: () {
                              //
                              _reference.doc(notes[index].id).delete();
                              // To refresh
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));

                              //
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}




//  good copy

