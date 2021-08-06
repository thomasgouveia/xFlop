import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/edt/edt_complete_week_viewer.dart';
import 'package:flop_edt_app/views/edt/edt_viewer.dart';
import 'package:flop_edt_app/views/loader/loading_screen.dart';
import 'package:flutter/material.dart';

class ScheduleChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState state = StateWidget.of(context).state;
    var settings = state.settings;
    return state.isLoading
        ? LoadingScreen()
        : settings.isGridDisplay ? ScheduleCompleteWeek() : ScheduleViewer();
  }
}
