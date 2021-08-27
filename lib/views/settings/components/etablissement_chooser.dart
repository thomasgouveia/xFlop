import 'package:flop_edt_app/models/resources/etablissement.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class EtablissementSelector extends StatefulWidget {
  final dynamic value;
  final ValueChanged onSelect;
  final Settings settings;

  const EtablissementSelector(
      {Key key, this.value, this.onSelect, Settings this.settings})
      : super(key: key);
  @override
  _EtablissementSelectorState createState() => _EtablissementSelectorState();
}

class _EtablissementSelectorState extends State<EtablissementSelector> {
  AppState state;

  Etablissement eta;
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

  var isDark;

  bool get isUserHaveCompletedAllData => eta != null;

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    String etaName = eta != null ? eta.nom : '';
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _buildSearch(theme),
              SizedBox(
                height: 10,
              ),
              _buildProfList()
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        isUserHaveCompletedAllData
            ? Text(
                'Votre établissement est $etaName.',
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Text(
                'Veuillez sélectionner votre établissement dans la liste.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
      ],
    );
  }

  // Widget buildCard(dynamic label, bool isSelected) => GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           etablissement = label;
  //           widget.onSelect(label);
  //         });
  //       },
  //       child: AnimatedContainer(
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //         margin: EdgeInsets.symmetric(horizontal: 5),
  //         padding: EdgeInsets.symmetric(horizontal: 30),
  //         decoration: BoxDecoration(
  //             color: isSelected ? Color(0xFFFF6C00) : Colors.transparent,
  //             borderRadius: BorderRadius.circular(50),
  //             border: isSelected
  //                 ? null
  //                 : Border.all(
  //                     width: 1,
  //                     color: isDark ? Colors.white24 : Colors.black26)),
  //         child: Center(
  //           child: Text(
  //             '$label',
  //             style: TextStyle(
  //                 color: isSelected
  //                     ? Colors.white
  //                     : isDark
  //                         ? Colors.white24
  //                         : Colors.black26),
  //           ),
  //         ),
  //       ),
  //     );

  Container _buildSearch(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 5.0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black26,
          ),
          hintText: 'Rechercher...',
          hintStyle: TextStyle(
              color: (theme.iconTheme.color == Colors.white)
                  ? Colors.grey.shade500
                  : theme.accentColor),
          filled: true,
          fillColor: (theme.iconTheme.color == Colors.white)
              ? theme.accentColor
              : Colors.white,
        ),
        style: theme.textTheme.bodyText1,
        onChanged: (String searchVal) {},
        cursorColor: Theme.of(context).accentColor,
      ),
    );
  }

  Expanded _buildProfList() {
    return Expanded(
      child: ListView.builder(
        itemCount: state.etablissements.length,
        itemBuilder: (context, index) {
          Etablissement etablissement = state.etablissements[index];
          bool onSelect = eta?.nom == etablissement.nom;
          return ListTile(
            selected: onSelect,
            onTap: () {
              setState(() {
                eta = etablissement;
                widget.onSelect(Settings(etablissement: etablissement));
              });
            },
            title: Text(
              '${etablissement.nom}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        },
      ),
    );
  }
}
