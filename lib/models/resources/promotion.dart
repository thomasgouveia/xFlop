import 'dart:convert';

import 'package:flop_edt_app/api/api_provider.dart';
import 'package:http/http.dart';

class Promotion {
  String department;
  String promo;
  String name;
  List<String> groups;

  Promotion({this.department, this.name, this.groups: const [], this.promo});

  Map<String, dynamic> get toMap => {
        'departement': this.department,
        'promo': this.promo,
        'name': this.name,
        'groups': this.groups.toString(),
      };

  String get toJSON => jsonEncode(this.toMap);

  @override
  String toString() {
    return this.toJSON;
  }

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
          groups:
              promo['name'] == 'LP' ? <String>["LP"] : groups ?? <String>[],
          promo: promo['promo'],
        ),
      );
    }
    return res;
  }
}
