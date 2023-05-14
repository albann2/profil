import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tableau des notes',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: TableauPage(title: 'Tableau des notes'),
    );
  }
}

class TableauPage extends StatefulWidget {
  TableauPage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  _TableauPageState createState() => _TableauPageState();
}

class _TableauPageState extends State<TableauPage> {
  final _controller = TextEditingController();
  List<Map<String, String>> notes = [];
  String nome='';

  void getNotes(String documentId) async {
  notes.clear();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Etudiant')
        .doc(documentId)
        .get();
    final nom = querySnapshot.data()!['nom'];
    nome=nom;
    final pv = querySnapshot.data()!['pv'].cast<Map<String, dynamic>>();
    pv.forEach((map) {
      final ue = map['ue'];
      final credit = map['credit'];
      final cc = map['cc'];
      final sn = map['sn'];
      final tp = map['tp'];
      notes.add({
        'ue': ue, 
        'credit': credit.toString(), 
        'cc': cc.toString(), 
        'sn': sn.toString(),
        'tp': tp.toString()
      });
    });
    setState(() {}); // rafraîchir l'affichage pour afficher les nouvelles notes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle:true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Valeur à passer à getNotes()',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  setState(() {});
                getNotes(_controller.text);
              },
              child: Text('Afficher les notes'),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text('Nom : $nome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Table(
                border: TableBorder.all(
                  color: Colors.black,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    children: [
                      Center(child: Text('UE', style: TextStyle(color: Colors.white))),
                      Center(child: Text('CC', style: TextStyle(color: Colors.white))),
                      Center(child: Text('Credit', style: TextStyle(color: Colors.white))),
                      Center(child: Text('Note_SN', style: TextStyle(color: Colors.white))),
                      Center(child: Text('Note_TP', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  for(var note in notes)
                    TableRow(
                      children: [
                        Center(child: Text(note['ue']??'')),
                        Center(child: Text(note['cc']??'')),
                        Center(child: Text(note['credit']??'')),
                        Center(child: Text(note['sn']??'')),
                        Center(child: Text(note['tp']??'')),],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
