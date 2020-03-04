import 'package:flop_edt_app/models/resources/group.dart';
import 'package:flop_edt_app/models/resources/promotion.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/settings/components/department_chooser.dart';
import 'package:flop_edt_app/views/settings/components/group_selector.dart';
import 'package:flop_edt_app/views/settings/components/promo_selector.dart';
import 'package:flutter/material.dart';

class CreateSettingsScreen extends StatefulWidget {
  @override
  _CreateSettingsScreenState createState() => _CreateSettingsScreenState();
}

class _CreateSettingsScreenState extends State<CreateSettingsScreen> {
  AppState state;
  String department;
  Promotion promotion;
  Group groupe;

  @override
  void initState() {
    super.initState();
    department = 'INFO';
  }

  updatePromotion() {
    //var promo = state.promos.where((promo) => promo.department == department).toList();
    //print('Promo=' + promo.toString());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'xFlop!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      DepartmentSelector(
                          value: department,
                          onSelect: (value) {
                            setState(() {
                              department = value;
                            });
                          }),
                      PromotionSelector(
                        value: promotion,
                        currentDep: department,
                        onSelect: (promo) => setState(() => promotion = promo),
                      ),
                      GroupSelector(
                        value: groupe,
                        groups: promotion?.groups ?? <Group>[],
                        onSelect: (group) => setState(() => groupe = group),
                      ),
                    ],
                  ),
                ),
                _validateButton(theme)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _validateButton(ThemeData theme) => RaisedButton(
        onPressed: () {
          //Settings settings = Settings(department: department, groupe: groupe.name, promo: promotion.name);
          //print(settings);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.all(10),
        child: Text(
          'Valider',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        color: theme.accentColor,
      );
}
