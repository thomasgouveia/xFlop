import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AppState state;
  bool buttonActivated = false;
  String version = "";
  String appName = "";
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  void getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
    });
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Image.asset(
                  Constants.logoPath,
                  width: 200,
                ),
                Text(
                  'xFlop!',
                  style: theme.textTheme.headline4.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'Version ' + version,
                  style: theme.textTheme.headline4.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 1,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10,
                ),
                _conceptButton(theme),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'xFlop! a été créé par des étudiants de l\'IUT de Blagnac',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _conceptButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          style: theme.elevatedButtonTheme.style,
          onPressed: _launchURL,
          icon: Icon(IconData(62834,
              fontFamily: 'MaterialIcons', matchTextDirection: true)),
          label: Text(
            'Le concept',
            style: theme.textTheme.button,
          ),
        ),
      );

  _launchURL() async {
    const url = 'https://www.flopedt.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
