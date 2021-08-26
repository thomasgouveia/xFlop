import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/settings/components/department_chooser.dart';
import 'package:flop_edt_app/views/settings/components/group_selector.dart';
import 'package:flop_edt_app/views/settings/components/promo_selector.dart';
import 'package:flutter/material.dart';

class StudentSettingsSelector extends StatefulWidget {
  final ValueChanged onSelected;
  final Settings settings;

  const StudentSettingsSelector({Key key, this.onSelected, this.settings})
      : super(key: key);
  @override
  _StudentSettingsSelectorState createState() =>
      _StudentSettingsSelectorState();
}

class _StudentSettingsSelectorState extends State<StudentSettingsSelector> {
  AppState state;

  String department;
  String promotion;
  String groupe;

  @override
  void initState() {
    super.initState();
    department = widget.settings?.department ?? 'INFO';
    promotion = widget.settings?.promo ?? 'INFO1';
    groupe = widget.settings?.groupe;
  }

  List<String> findGroupsByPromo(String department, promo) {
    var res = state.promos[department]
        .where((element) => element.promo == promo)
        .toList();
    if (res.length == 0) return <String>[];
    return res[0].groups;
  }

  bool get isUserHaveCompletedAllData =>
      department != null && groupe != null && promotion != null;

  void sendSettings() {
    if (isUserHaveCompletedAllData) {
      setState(() {
        widget.onSelected(
          Settings(
            department: department,
            groupe: groupe,
            promo: promotion,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var groups = findGroupsByPromo(department, promotion);
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              DepartmentSelector(
                onSelect: (value) => setState(() {
                  department = value;
                  groupe = null;
                  promotion = null;
                  sendSettings();
                }),
                value: department,
              ),
              PromotionSelector(
                onSelect: (value) => setState(() {
                  promotion = value;
                  sendSettings();
                }),
                value: promotion,
                currentDep: department,
              ),
              groups.length == 0
                  ? Container()
                  : GroupSelector(
                      onSelect: (value) => setState(() {
                        groupe = value;
                        sendSettings();
                      }),
                      value: groupe,
                      groups: groups,
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isUserHaveCompletedAllData
            ? Text(
                'Vous faites parti du département $department, dans la promotion $promotion et le groupe $groupe.',
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Text(
                'Veuillez sélectionner une promotion, un groupe et un département OU vous connectez.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
      ],
    );
  }
}
