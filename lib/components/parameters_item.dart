import 'package:flutter/material.dart';

class ParametersItem extends StatelessWidget {
  ///[Widget] représentant un item dans les paramètres.
  final Widget child;
  final String label;
  final Color textColor;

  const ParametersItem({Key key, this.label, this.child, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: textColor),
        ),
        child ?? Container(),
      ],
    );
  }
}
