import 'package:flop_edt_app/themes/theme.dart';
import 'package:flutter/material.dart';

class WeekChooser extends StatefulWidget {
  final List<int> weeks;
  final ValueChanged valueChanged;
  final MyTheme theme;
  const WeekChooser({Key key, this.weeks, this.valueChanged, this.theme})
      : super(key: key);

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
          curve: Curves.easeInOut,
          width: (MediaQuery.of(context).size.width / widget.weeks.length) - 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value == weekNb
                  ? widget.theme.secondary
                  : Colors.transparent),
          child: FlatButton(
            child: Text(
              '$weekNb',
              style: TextStyle(
                  fontSize: 14,
                  color:
                      value == weekNb ? Colors.white : widget.theme.textColor),
            ),
            onPressed: () => setState(() {
              if (value != weekNb) {
                value = weekNb;
                widget.valueChanged(weekNb);
              }
            }),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: btns,
      ),
    );
  }
}
