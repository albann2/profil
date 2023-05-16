import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profil/Screen/admin/signin.dart';
import './client/info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r"[0-9]+[a-zA-Z]+[0-9]+");
  String _matricule = " ";
  TextEditingController matriculecontoller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    matriculecontoller.text = '';
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEtudiantDocument(
      String matricule) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('Etudiant')
          .doc(matricule)
          .get();

      if (doc.exists) {
        // Le document existe, vous pouvez y accéder ici
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Infos(matricule: matriculecontoller.text.trim()),
          ),
        );
        return doc;
      } else {
        // Le document n'existe pas
        throw Exception("Le document n'existe pas");
      }
    } catch (e) {
      // Une erreur s'est produite lors de la récupération du document
      throw Exception("Erreur lors de la récupération du document : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
              icon: Icon(
                Icons.admin_panel_settings,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminSignInScreen()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Profil Academique',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: matriculecontoller,
                        onChanged: (value) =>
                            setState(() => _matricule = value),
                        validator: (value) =>
                            value!.isEmpty || !emailRegex.hasMatch(value)
                                ? 'Please enter a valid id'
                                : null,
                        decoration: InputDecoration(
                          hintText: '21Q2439',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 0.0,
                          ),
                          elevation: 0,
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          getEtudiantDocument(_matricule);
                        },
                        child: Text(
                          'Continuer'.toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
