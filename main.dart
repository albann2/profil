import 'dart:io';

/*class Mgp {
  // function to read name
  static String readNameitem() {
    print('Entrez votre nom:');
    String name = stdin.readLineSync();
    return name;
  }

  // function to enter the number of UE
  static int nombreUe() {
    print('Entrez le nombre d\'UE:');
    int x = int.parse(stdin.readLineSync());
    return x;
  }

  // function to enter the names of different units of teaching
  static List<String> datacodeUe(int taille) {
    print('Entrez les codes d\'UE');
    List<String> codeue = [];

    for (int i = 0; i < taille; i++) {
      stdout.write('CODUE[$i]=');
      String code = stdin.readLineSync();
      codeue.add(code);
    }
    return codeue;
  }

  // function to declare different averages
  static List<double> dataMoyennes(int taille) {
    print('Entrez les moyennes');
    List<double> moyennes = [];

    for (int i = 0; i < taille; i++) {
      stdout.write('moyenne[$i]=');
      double moy = double.parse(stdin.readLineSync());
      moyennes.add(moy);
    }
    return moyennes;
  }

  // function to declare the credits corresponding to each unit
  static List<double> dataCredits(int taille) {
    print('Entrez les credits:');
    List<double> credits = [];

    for (int i = 0; i < taille; i++) {
      stdout.write('credits[$i]=');
      double credit = double.parse(stdin.readLineSync());
      credits.add(credit);
    }
    return credits;
  }*/

  static double qualitepoint(double note) {
    double point;

    if (note <= 34)
      point = 0;
    else if (35 <= note && note <= 39)
      point = 1;
    else if (40 <= note && note <= 44)
      point = 1.3;
    else if (45 <= note && note <= 49)
      point = 1.7;
    else if (50 <= note && note <= 54)
      point = 2;
    else if (55 <= note && note <= 59)
      point = 2.3;
    else if (60 <= note && note <= 64)
      point = 2.7;
    else if (65 <= note && note <= 69)
      point = 3;
    else if (70 <= note && note <= 74)
      point = 3.3;
    else if (75 <= note && note <= 79)
      point = 3.7;
    else if (80 <= note && note <= 100)
      point = 4;
    else
      throw ('Invalid note');

    return point;
  }

  // function to determine the quality point
  static List<double> qualitepoints(List<double> moyennes) {
    List<double> points = [];

    for (int i = 0; i < moyennes.length; i++) {
      if (moyennes[i] <= 34)
        points.add(0);
      else if (35 <= moyennes[i] && moyennes[i] <= 39)
        points.add(1);
      else if (40 <= moyennes[i] && moyennes[i] <= 44)
        points.add(1.3);
      else if (45 <= moyennes[i] && moyennes[i] <= 49)
        points.add(1.7);
      else if (50 <= moyennes[i] && moyennes[i] <= 54)
        points.add(2);
      else if (55 <= moyennes[i] && moyennes[i] <= 59)
        points.add(2.3);
      else if (60 <= moyennes[i] && moyennes[i] <= 64)
        points.add(2.7);
     else if (65 <= moyennes[i] && moyennes[i] <= 69)
        points.add(3);
     else if (70 <= moyennes[i] && moyennes[i] <= 74)
        points.add(3.3);
     else if (75 <= moyennes[i] && moyennes[i] <= 79)
        points.add(3.7);
     else if (80 <= moyennes[i] && moyennes[i] <= 100)
        points.add(4);
    return points;
    
    }

  }
double calculSumcredit(List<double> credits) {
  double sumcredit = 0;
  for (int i = 0; i < credits.length; i++) {
    sumcredit += credits[i];
  }
  return sumcredit;
}

double calculSumCreditQlpt(List<double> credits, List<double> points) {
  double sumcreditQlpt = 0;
  for (int i = 0; i < credits.length; i++) {
    sumcreditQlpt += credits[i] * points[i];
  }
  return sumcreditQlpt;
}

double calculMGP(double sumcredit, double sumcreditQlpt) {
  double mgp = (sumcreditQlpt) / (sumcredit);
  return mgp;
}

void beginSection(String nameSection) {
  print("********************************" + nameSection + "*************************");
}

void AffichTableauCodesUe(List<String> codeue) {
  stdout.write("codeue=[");
  for (int i = 0; i < codeue.length; i++) {
    stdout.write(codeue[i] + ";");
  }
  print("]");
}

void AfficherTableauMoyennes(List<double> moyennes) {
  stdout.write("moyenne=[");
  for (int i = 0; i < moyennes.length; i++) {
    stdout.write(moyennes[i].toString() + ";");
  }
  print("]");
}



































