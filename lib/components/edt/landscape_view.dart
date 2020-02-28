import 'package:flop_edt_app/components/default_cours.dart';
import 'package:flutter/material.dart';

class LandscapeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('LUN 21/10'),
              Column(
                children: <Widget>[
                  Container(),
                ],
              ),
            ],
          ),
        ],
      ),
      
      
      /*Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('LUN 21/10'),
              Text('MAR 22/10'),
              Text('MER 23/10'),
              Text('JEU 24/10'),
              Text('VEN 25/10'),
            ],
          ),
        ],
      ),
      */
    );
  }
}
