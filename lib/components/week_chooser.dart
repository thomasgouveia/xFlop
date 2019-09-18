import 'package:flutter/material.dart';

class WeekChooser extends StatefulWidget {
  final List<int> weeks;
  final ValueChanged valueChanged;
  const WeekChooser({Key key, this.weeks, this.valueChanged}) : super(key: key);

  @override
  _WeekChooserState createState() => _WeekChooserState();
}

class _WeekChooserState extends State<WeekChooser> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.weeks[0];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> btns = [];
    widget.weeks.forEach(
      (int weekNb) => btns.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInSine,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value == weekNb ? Colors.grey[900] : Colors.transparent),
          child: FlatButton(
            child: Text(
              weekNb.toString(),
              style: TextStyle(
                  fontSize: 16,
                  color: value == weekNb ? Colors.white : Colors.black),
            ),
            onPressed: () => setState(() {
              value = weekNb;
              widget.valueChanged(weekNb);
            }),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: btns,
      ),
    );
  }
}
