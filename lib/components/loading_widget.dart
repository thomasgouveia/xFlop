import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final int semaine;

  const LoadingWidget({Key key, this.semaine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text('Récupération de la semaine $semaine'),
          ),
        ],
      ),
    );
  }
}
