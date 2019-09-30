import 'dart:io';

import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String buttonText;
  final Image image;

  CustomDialog({
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) => Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: _content(context),
          ),
          _logo,
        ],
      );

  Widget _content(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            'xFlop! - $VERSION',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.0),
          Platform.isIOS
              ? Text(
                  'Pour toute question ou problème :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                )
              : Text(
                  'Application en cours de développement, susceptible de comporter des bugs. \n\nPour toute question ou problème :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
          Text(
            HELPER_EMAIL,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.0),
          Text(
            'Remerciements : Feavy, FlopEDT',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          _closeButton(context),
        ],
      );

  Widget _closeButton(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pop(); // To close the dialog
          },
          child: Text(buttonText),
        ),
      );

  Widget get _logo => Positioned(
        left: Consts.padding,
        right: Consts.padding,
        child: CircleAvatar(
          backgroundColor: Colors.grey[900],
          radius: Consts.avatarRadius,
          child: Center(child: Image.asset(LOGO_ASSET_PATH, width: 70)),
        ),
      );
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
