import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class TutorSettingsSelector extends StatefulWidget {
  final ValueChanged onSelected;

  const TutorSettingsSelector({Key key, this.onSelected}) : super(key: key);

  @override
  _TutorSettingsSelectorState createState() => _TutorSettingsSelectorState();
}

class _TutorSettingsSelectorState extends State<TutorSettingsSelector> {
  AppState state;

  Tutor prof;
  String filter;

  @override
  void initState() {
    super.initState();
    filter = 'INFO';
  }

  var isDark;

  bool get isUserHaveCompletedAllData => prof != null;

  void setFilter(String newFilter) => setState(() => filter = newFilter);

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    isDark = theme.iconTheme.color == Colors.white;
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: Column(
            children: <Widget>[
              //_buildSearch(),
              SizedBox(
                height: 10,
              ),
              _buildFilters(),
              SizedBox(
                height: 10,
              ),
              _buildProfList()
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isUserHaveCompletedAllData
            ? Text(
                'Vous êtes $prof.',
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Text(
                'Veuillez sélectionner votre nom dans la liste.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
      ],
    );
  }

  // Container _buildSearch() {
  //   return Container(
  //     margin: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       color: Colors.black12,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: TextField(
  //       onChanged: (String searchVal) {

  //       },
  //       cursorColor: Theme.of(context).primaryColor,
  //       decoration: InputDecoration(
  //           border: InputBorder.none,
  //           prefixIcon: Icon(Icons.search, color: Colors.black26,),
  //           hintText: 'Rechercher...'),
  //     ),
  //   );
  // }

  Container _buildFilters() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.promos.keys.length,
        itemBuilder: (context, index) {
          var label = state.promos.keys.toList()[index];
          bool isFilter = filter == label;
          return GestureDetector(
            onTap: () => this.setFilter(label),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: isFilter ? Color(0xFFFF6C00) : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: isFilter
                      ? null
                      : Border.all(
                          width: 1,
                          color: isDark ? Colors.white24 : Colors.black26)),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      color: isFilter
                          ? Colors.white
                          : isDark
                              ? Colors.white24
                              : Colors.black26),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _buildProfList() {
    return Expanded(
      child: ListView.builder(
        itemCount: state.profs[filter].length,
        itemBuilder: (context, index) {
          Tutor tutor = state.profs[filter][index];
          bool isSelected = prof?.initiales == tutor.initiales;
          return ListTile(
            onTap: () {
              setState(() {
                prof = tutor;
                widget.onSelected(Settings(
                    tutor: tutor,
                    isTutor: true,
                    department: filter,
                    etablissement: state.settings.etablissement));
              });
            },
            leading: CircleAvatar(
              backgroundColor: isSelected
                  ? Theme.of(context).primaryColor
                  : Color(0xFFFF6C00),
              child: Text(
                '${tutor.initiales}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            title: Text(
              '${tutor.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        },
      ),
    );
  }
}
