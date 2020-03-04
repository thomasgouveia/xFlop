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
  Promotion promotion;
  AppState state;

  @override
  void initState() {
    super.initState();
    promotion = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    return DropdownButton<Promotion>(
      hint: Text("Promotion"),
      value: promotion,
      onChanged: (Promotion value) {
        setState(() {
          promotion = value;
          widget.onSelect(value);
        });
      },
      items: state.promos[widget.currentDep].map((Promotion promo) {
        return DropdownMenuItem<Promotion>(
          value: promo,
          child: Text('${promo.promo}'),
        );
      }).toList(),
    );
  }
}
