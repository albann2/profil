import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final List<Map<String, dynamic>> pv = [
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT201',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 5,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT207',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 5,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT205',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 5,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT217',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT203',
    },
    {
      'bool': false,
      'cc': 0,
      'credit': 3,
      'sn': 0,
      'tp': 0,
      'ue': 'ENG203',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT202',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT218',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT204',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT206',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT210',
    },
    {
      'bool': true,
      'cc': 0,
      'credit': 6,
      'sn': 0,
      'tp': 0,
      'ue': 'ICT208',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _matriculeController,
            decoration: const InputDecoration(
              labelText: 'Matricule',
            ),
          ),
          TextField(
            controller: _nomController,
            decoration: const InputDecoration(
              labelText: 'Nom',
            ),
          ),
          MaterialButton(
            color: Colors.amber,
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Etudiant')
                  .doc(_matriculeController.text)
                  .set({
                'nom': _nomController.text,
                'pv': pv,
              });
              _matriculeController.clear();
              _nomController.clear();
            },
            child: const Text('Add Student'),
          ),
        ],
      ),
    );
  }
}
