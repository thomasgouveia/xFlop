import 'package:flop_edt_app/models/resources/group.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class GroupSelector extends StatefulWidget {
  final dynamic value;
  final ValueChanged onSelect;
  final List<Group> groups;

  const GroupSelector({Key key, this.value, this.onSelect, this.groups})
      : super(key: key);
  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  Group group;
  AppState state;

  @override
  void initState() {
    super.initState();
    group = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    return DropdownButton<Group>(
      hint: Text("Groupe"),
      value: group,
      onChanged: (Group value) {
        setState(() {
          group = value;
          widget.onSelect(value);
        });
      },
      items: widget.groups.map((Group group) {
        return DropdownMenuItem<Group>(
          value: group,
          child: Text('${group.name}'),
        );
      }).toList(),
    );
  }
}
