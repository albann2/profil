class Etudiant {
  final String matricule;
  final String nom;
  final List<Map<String, dynamic>> pv;
  String mgp;

  Etudiant({
    required this.matricule,
    required this.nom,
    required this.mgp,
    required this.pv,
  });

  set setUid(value) => mgp = value;

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

  List<double> Qualitepoints(List<double> moyenes) {
    List<double> qualitepts = moyenes;
    for (int i = 0; i < moyenes.length; i++) {
      qualitepts[i] = Qualitepoint(moyenes[i]);
    }
    return qualitepts;
  }

  double CalculSumCredit(List<double> credits) {
    double sum = 0.00;
    for (int i = 0; i < credits.length; i++) {
      sum = sum + credits[i];
    }
    return sum;
  }

  double CalculSumCreditQLpt(List<double> credits, List<double> qualitepts) {
    double sumQL = 0.00;
    for (int i = 0; i < credits.length; i++) {
      sumQL = sumQL + (credits[i] * qualitepts[i]);
    }
    return sumQL;
  }

  double CalculMGP(double sum, double sumQL) {
    double mgp = 0.00;
    mgp = sumQL / sum;
    return mgp;
  }
}
