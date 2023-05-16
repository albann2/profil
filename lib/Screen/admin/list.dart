import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './info.dart';

class StudentListPage extends StatefulWidget {
  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late Future<List<DocumentSnapshot>> futureDocuments;

  @override
  void initState() {
    super.initState();
    futureDocuments = getDocumentsInCollection();
  }

  Future<List<DocumentSnapshot>> getDocumentsInCollection() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Etudiant').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: futureDocuments,
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Aucune video'));
          } else {
            List<DocumentSnapshot> documents = snapshot.data!;
            // return PageView(
            //   scrollDirection: Axis.vertical,
            //   children: documents.map((item) {
            //     return Text('oki okio ki');
            //   }).toList(),
            // );
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = documents[index];
                String nom = document['nom'];
                // String description = document['description'];
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Infos(matricule: documents[index].id),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      nom,
                      style: const TextStyle(
                          backgroundColor:
                              Color.fromRGBO(159, 151, 151, 0.498)),
                    ),
                    subtitle: Text(documents[index].id),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
