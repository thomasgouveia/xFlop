import 'dart:convert';

import 'package:flop_edt_app/api/api_provider.dart';
import 'package:flop_edt_app/models/resources/group.dart';
import 'package:http/http.dart';

class Promotion {
  String department;
  String promo;
  String name;
  List<Group> groups;

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
      var responseGroup = await api.getGroups(
          department: promo['departement'], promo: promo['promo']);
      var groups = Group.createListFromResponse(responseGroup);
      res.add(
        Promotion(
          department: promo['departement'],
          name: promo['name'],
          groups: groups ?? <Group>[],
          promo: promo['promo'],
        ),
      );
    }
    return res;
  }
}
