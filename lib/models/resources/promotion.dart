import 'dart:convert';

import 'package:flop_edt_app/api/api_provider.dart';
import 'package:http/http.dart';

///Classe modèle [Promotion] permettant de stocker une promotion
///complète (département, promotion, nom, liste des groupes de la promo).
class Promotion {
  ///Le département de la promotion (eg : INFO, CS..) de type [String]
  String department;

  ///La promotion (eg: INFO1, INFO2) de type [String]
  String promo;

  ///Son nom (eg: CE, 1A) de type [String]
  String name;

  ///La liste des groupes qui compose la promotion, de type [List<String>]
  List<String> groups;

  ///Constructeur d'une promotion.
  Promotion({this.department, this.name, this.groups: const [], this.promo});

  ///Crée une [Map] à partir de l'objet.
  Map<String, dynamic> get toMap => {
        'departement': this.department,
        'promo': this.promo,
        'name': this.name,
        'groups': this.groups.toString(),
      };

  ///Retourne une chaîne JSON de l'objet.
  String get toJSON => jsonEncode(this.toMap);

  ///Méthode d'affichage de [Promotion]
  @override
  String toString() {
    return this.toJSON;
  }

  ///Méthode statique créant une liste de [Promotion] à partir d'une réponse HTTP.
  static Future<List<Promotion>> createListFromResponse(
      Response response) async {
    APIProvider api = APIProvider();
    var promos = jsonDecode(response.body)['response'];
    var res = <Promotion>[];
    for (var promo in promos) {
      var groups = await api.getGroups(
          department: promo['departement'], promo: promo['promo']);
      res.add(
        Promotion(
          department: promo['departement'],
          name: promo['name'],
          groups: promo['name'] == 'LP' ? <String>["LP"] : groups ?? <String>[],
          promo: promo['promo'],
        ),
      );
    }
    return res;
  }
}
