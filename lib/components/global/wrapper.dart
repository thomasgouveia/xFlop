import 'package:flutter/material.dart';

class WrapperWidget extends StatelessWidget {
  final double left;
  final double right;
  final Widget child;

  const WrapperWidget(
      {Key key,
      @required this.left,
      @required this.right,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left, right: right),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}
