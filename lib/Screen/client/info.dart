import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Infos extends StatefulWidget {
  final String matricule;

  const Infos({required this.matricule});

  @override
  _InfosState createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  TextEditingController _controller7 = TextEditingController();
  TextEditingController _controller8 = TextEditingController();
  TextEditingController _controller9 = TextEditingController();
  TextEditingController _controller10 = TextEditingController();
  TextEditingController _controller11 = TextEditingController();
  TextEditingController _controller12 = TextEditingController();

  TextEditingController _controller1tp = TextEditingController();
  TextEditingController _controller2tp = TextEditingController();
  TextEditingController _controller3tp = TextEditingController();
  TextEditingController _controller4tp = TextEditingController();
  TextEditingController _controller5tp = TextEditingController();
  TextEditingController _controller7tp = TextEditingController();
  TextEditingController _controller8tp = TextEditingController();
  TextEditingController _controller9tp = TextEditingController();
  TextEditingController _controller10tp = TextEditingController();
  TextEditingController _controller11tp = TextEditingController();
  TextEditingController _controller12tp = TextEditingController();

  TextEditingController _controller1sn = TextEditingController();
  TextEditingController _controller2sn = TextEditingController();
  TextEditingController _controller3sn = TextEditingController();
  TextEditingController _controller4sn = TextEditingController();
  TextEditingController _controller5sn = TextEditingController();
  TextEditingController _controller6sn = TextEditingController();
  TextEditingController _controller7sn = TextEditingController();
  TextEditingController _controller8sn = TextEditingController();
  TextEditingController _controller9sn = TextEditingController();
  TextEditingController _controller10sn = TextEditingController();
  TextEditingController _controller11sn = TextEditingController();
  TextEditingController _controller12sn = TextEditingController();
  DocumentSnapshot<Map<String, dynamic>>? document;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    getEtudiantDocument(widget.matricule).then((doc) {
      setState(() {
        document = doc;
      });
    }).catchError((error) {
      // Une erreur s'est produite lors de la récupération du document
      print("Erreur : $error");
    });

    setupNotes();
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

  void setupNotes() async {
    await getNotes(widget.matricule);
    print(notes);

    setState(() {
      _controller1.text = notes[6]['cc'].toString();
      _controller1tp.text = notes[6]['tp'].toString();
      _controller1sn.text = notes[6]['sn'].toString();
      _controller2.text = notes[7]['cc'].toString();
      _controller2tp.text = notes[7]['tp'].toString();
      _controller2sn.text = notes[7]['sn'].toString();
      _controller3.text = notes[8]['cc'].toString();
      _controller3tp.text = notes[8]['tp'].toString();
      _controller3sn.text = notes[8]['sn'].toString();
      _controller4.text = notes[9]['cc'].toString();
      _controller4tp.text = notes[9]['tp'].toString();
      _controller4sn.text = notes[9]['sn'].toString();
      _controller5.text = notes[10]['cc'].toString();
      _controller5tp.text = notes[10]['tp'].toString();
      _controller5sn.text = notes[10]['sn'].toString();
      _controller6.text = notes[11]['cc'].toString();
      _controller6sn.text = notes[11]['sn'].toString();

      _controller7.text = notes[0]['cc'].toString();
      _controller7tp.text = notes[0]['tp'].toString();
      _controller7sn.text = notes[0]['sn'].toString();
      _controller8.text = notes[1]['cc'].toString();
      _controller8tp.text = notes[1]['tp'].toString();
      _controller8sn.text = notes[1]['sn'].toString();
      _controller9.text = notes[2]['cc'].toString();
      _controller9tp.text = notes[2]['tp'].toString();
      _controller9sn.text = notes[2]['sn'].toString();
      _controller10.text = notes[3]['cc'].toString();
      _controller10tp.text = notes[3]['tp'].toString();
      _controller10sn.text = notes[3]['sn'].toString();
      _controller11.text = notes[4]['cc'].toString();
      _controller11tp.text = notes[4]['tp'].toString();
      _controller11sn.text = notes[4]['sn'].toString();
      _controller12.text = notes[5]['cc'].toString();
      _controller12tp.text = notes[5]['tp'].toString();
      _controller12sn.text = notes[5]['sn'].toString();
    });
  }

  Future<void> getNotes(String documentId) async {
    notes.clear();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Etudiant')
          .doc(documentId)
          .get();
      final nom = querySnapshot.data()!['nom'];
      final pv = querySnapshot.data()!['pv'].cast<Map<String, dynamic>>();
      pv.forEach((map) {
        final ue = map['ue'];
        final credit = map['credit'];
        final cc = map['cc'];
        final sn = map['sn'];
        final tp = map['tp'];
        final bool = map['bool'];
        notes.add({
          'ue': ue ?? 0,
          'credit': credit ?? 0,
          'cc': cc ?? 0,
          'sn': sn ?? 0,
          'tp': tp ?? 0,
          'bool': bool ?? 0,
        });
      });
    } catch (e) {
      print('no');
    }
  }

  double Qualitepoint(double note) {
    double point = 0;
    if ((note < 35) && (note >= 0))
      point = 0;
    else if ((note < 40) && (note >= 35))
      point = 1.00;
    else if ((note < 45) && (note >= 40))
      point = 1.30;
    else if ((note < 50) && (note >= 45))
      point = 1.70;
    else if ((note < 55) && (note >= 50))
      point = 2.00;
    else if ((note < 60) && (note >= 55))
      point = 2.30;
    else if ((note < 65) && (note >= 60))
      point = 2.70;
    else if ((note < 70) && (note >= 65))
      point = 3.00;
    else if ((note < 75) && (note >= 70))
      point = 3.30;
    else if ((note < 80) && (note >= 75))
      point = 3.70;
    else if ((note <= 100) && (note >= 80)) point = 4.00;
    return point;
  }

  String mgp() {
    List<double> a = [];
    double t = 0, sum = 0, sumQL = 0, mgp = 0;
    for (var note in notes) {
      //qualite des points
      if (note['bool'] == true) {
        t = double.parse(note['cc'].toString()) +
            double.parse(note['tp'].toString()) +
            double.parse(note['sn'].toString());
        t = Qualitepoint(t);
      } else {
        t = Qualitepoint(double.parse(note['cc'].toString()) +
            double.parse(note['sn'].toString()));
      }
      a.add(t);

      //somme des credits
      sum = sum + double.parse(note['credit'].toString());
    }

    //somme des credits x qualite
    for (int i = 0; i < notes.length; i++) {
      sumQL = sumQL + double.parse(notes[i]['credit'].toString()) * a[i];
    }

    //mgp
    mgp = sumQL / sum;
    return mgp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document?.data()?['nom'] ?? 'Chargement...'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Row(
            //   children: [
            //     Text('mgp = ' + mgp()),
            //   ],
            // ),

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Text(
                widget.matricule.toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Text(
            //   "Echec",
            //   style: TextStyle(fontSize: 20),
            // ),
            SizedBox(height: 10),
            Text(
              mgp(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              // padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6.0,
                child: Column(
                  children: [
                    Text(
                      'Premier Semestre',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller1,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT201 cc',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller1tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller1sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller2,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT207 cc',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller2tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller2sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller3,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT205 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller3tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller3sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller4,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT217 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller4tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller4sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller5,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT203 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller5tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller5sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller6,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ENG203 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller6sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Card(
                elevation: 6.0,
                child: Column(
                  children: [
                    Text(
                      'Second Semestre',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller7,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT202 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller7tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller7sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller8,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT218 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller8tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller8sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller9,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT204 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller9tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller9sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller10,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT206 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller10tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller10sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller11,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT210 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller11tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller11sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller12,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'ICT208 CC',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller12tp,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'TP',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _controller12sn,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'SN',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
