import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Switch personalisé s'affichant en tant que cupperino si IOS ou material si Android
class AdaptableSwitch extends StatefulWidget {
  AdaptableSwitch({@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  _AdaptableSwitch createState() => _AdaptableSwitch();
}

class _AdaptableSwitch extends State<AdaptableSwitch> {
  bool _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSwitch(
            value: _switchValue,
            onChanged: (bool value) {
              setState(() {
                _switchValue = value;
                widget.valueChanged(value);
              });
            })
        : Switch(
            value: _switchValue,
            onChanged: (bool value) {
              _switchValue = value;
              widget.valueChanged(value);
            },
          );
  }
}
