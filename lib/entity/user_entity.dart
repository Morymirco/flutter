// le dossier sert de stockage

import 'dart:math';

import 'package:floor/floor.dart';

@Entity(tableName: "utilisateur")
class Utilisateur {
  // decorateur pour indiquer la cle primaire
  @PrimaryKey(autoGenerate: true)
  int? id;
  String nom;
  String prenom;

  Utilisateur({required this.nom, required this.prenom});
}
