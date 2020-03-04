import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class DepartmentSelector extends StatefulWidget {
  final dynamic value;
  final ValueChanged onSelect;

  const DepartmentSelector({Key key, this.value, this.onSelect})
      : super(key: key);
  @override
  _DepartmentSelectorState createState() => _DepartmentSelectorState();
}

class _DepartmentSelectorState extends State<DepartmentSelector> {
  dynamic department;
  AppState state;

  @override
  void initState() {
    super.initState();
    department = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    return DropdownButton<dynamic>(
      hint: Text("Département"),
      value: department == '' ? null : department,
      onChanged: (dynamic value) {
        setState(() {
          department = value;
          widget.onSelect(value);
        });
      },
      items: state.departments.map((dynamic dep) {
        return DropdownMenuItem<dynamic>(
          value: dep,
          child: Text('$dep'),
        );
      }).toList(),
    );
  }
}
