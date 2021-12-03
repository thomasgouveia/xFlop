import 'package:flop_edt_app/models/resources/promotion.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class PromotionSelector extends StatefulWidget {
  final dynamic value;
  final ValueChanged onSelect;
  final String currentDep;

  const PromotionSelector({Key key, this.value, this.onSelect, this.currentDep})
      : super(key: key);
  @override
  _PromotionSelectorState createState() => _PromotionSelectorState();
}

class _PromotionSelectorState extends State<PromotionSelector> {
  String promotion;
  AppState state;

  @override
  void initState() {
    super.initState();
    promotion = widget.value;
  }

  var isDark;

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    isDark = theme.iconTheme.color == Colors.white ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text(
          'Promotion : ',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
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
            children: state.promos[widget.currentDep]
                .map((promo) =>
                    this.buildCard(promo.promo, promo.promo == promotion))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildCard(dynamic label, bool isSelected) => GestureDetector(
        onTap: () {
          setState(() {
            promotion = label;
            widget.onSelect(label);
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: isSelected ? Color(0xFFFF6C00) : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: isSelected
                  ? null
                  : Border.all(width: 1, color: isDark ? Colors.white24 : Colors.black26)),
          child: Center(
            child: Text(
              '$label',
              style:
                  TextStyle(color: isSelected ? Colors.white : isDark ? Colors.white24 : Colors.black26),
            ),
          ),
        ),
      );
}
