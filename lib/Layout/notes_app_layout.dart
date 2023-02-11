import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Modules/AllNotes/all_notes_ui.dart';
import 'package:notes_app/Modules/TakeNote/take_note_ui.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';

import '../Shared/Components/ReusableWidgets/fab.dart';
import 'LayoutUIComponents/layout_navigation_drawer.dart';

class NotesAppLayout extends StatelessWidget {
  const NotesAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(cubit, context),
          drawer: LayoutNavigationDrawer(cubit: cubit),
          body: const AllNotesUI(),
          floatingActionButton: FAB(
            onPressed: () {
              navigateTo(context, const TakeNoteUI());
            },
            text: "Add Note",
            icon: Icons.edit,
          ),
        );
      },
    );
  }

  AppBar buildAppBar(AppCubit cubit, BuildContext context) {
    return AppBar(
      title: const Text("Notes App"),
      actions: [
        GestureDetector(
          onTap: () {
            cubit.changeListGridView();
          },
          child: Icon(cubit.isGrid ? Icons.list : Icons.grid_view_rounded),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }
}
