import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class GroupSelector extends StatefulWidget {
  final dynamic value;
  final ValueChanged onSelect;
  final List<String> groups;

  const GroupSelector({Key key, this.value, this.onSelect, this.groups})
      : super(key: key);
  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  String group;
  AppState state;

  @override
  void initState() {
    super.initState();
    group = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text(
          'Groupe : ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: widget.groups
                .map((gr) => this.buildCard(gr, gr == group))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildCard(dynamic label, bool isSelected) => GestureDetector(
        onTap: () {
          setState(() {
            group = label;
            widget.onSelect(label);
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: isSelected ? Color(0xFFFF6C00) : Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: isSelected
                  ? null
                  : Border.all(width: 1, color: Colors.black26)),
          child: Center(
            child: Text(
              '$label',
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black26),
            ),
          ),
        ),
      );
}
