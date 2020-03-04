import 'dart:convert';

import 'package:http/http.dart';

class Group {
  String name;
  List<String> parents;

  Group({this.name: '', this.parents: const []});

  Map<String, dynamic> get toMap => {
        'name': this.name,
        'parents': this.parents,
      };

  String get toJson => jsonEncode(this.toMap);

  @override
  String toString() {
    return this.toJson;
  }

  static List<Group> createListFromResponse(Response response) {
    var groups = jsonDecode(response.body)['response'];
    var res = <Group>[];
    if (groups == null) return [];
    for (var group in groups) {
      Group g = Group();
      g.name = group['group'];
      g.parents = group['parents'].cast<String>();
      res.add(g);
    }
    return res;
  }
}
