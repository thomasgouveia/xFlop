import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AppState state;
  bool buttonActivated = false;
  TextEditingController emailController = new TextEditingController();
  
  
  @override
  void initState() {
    super.initState();
  }

  

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Image.asset(
                  Constants.logoPath,
                  width: 200,
                ),
              ),
              Text(
                'xFlop!',
                style: theme.textTheme.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                'Version ' + 'PackageInfo',
                style: theme.textTheme.headline4.copyWith(
                  fontSize: 20,
                ),
              ),
              Text(
                'Un lien sera envoyé à l\'adresse suivante',
                style: theme.textTheme.headline4.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


