import 'package:flop_edt_app/components/fade_in.dart';
import 'package:flutter/material.dart';

class DefaultCoursContainer extends StatelessWidget {
  final double delay;
  final bool animate;

  const DefaultCoursContainer({Key key, this.delay, this.animate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return animate ? FadeIn(delay, _ui) : _ui;
  }

  Widget get _ui => Row(
        children: <Widget>[
          coursHeure,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
                boxShadow: [],
              ),
              margin: EdgeInsets.only(top: 5, bottom: 5),
              height: 100,
            ),
          ),
        ],
      );

  Widget get coursHeure => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '-----',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]),
            ),
            Text(
             '-----',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]),
            ),
          ],
        ),
      );
}
