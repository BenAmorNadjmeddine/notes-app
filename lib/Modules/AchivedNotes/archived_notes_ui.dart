import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/Modules/AchivedNotes/UIComponents/archived_notes.dart';
import 'package:notes_app/Modules/ShowNote/show_note_ui.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/empty_page_message.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/note_item.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';

class ArchivedNotesUI extends StatelessWidget {
  const ArchivedNotesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(cubit, context),
          body: cubit.archivedNotes.isNotEmpty
              ? ArchivedNotes(cubit: cubit)
              : EmptyPageMessage(
            cubit: cubit,
            icon: Icons.notes,
            message: "You don't have archived notes yet.",
          ),
        );
      },
    );
  }

  AppBar buildAppBar(AppCubit cubit, BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          cubit.popAndResetAll(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: const Text("Archived Notes"),
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
