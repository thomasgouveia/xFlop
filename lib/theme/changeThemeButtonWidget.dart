import 'package:flop_edt_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        value: true,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          ThemeProvider.setMode(context, value);
          provider.toggleTheme(value);
        });
  }
}
