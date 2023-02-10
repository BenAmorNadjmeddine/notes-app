import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/Modules/ShowNote/show_note_ui.dart';
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
          body: cubit.archivedNotes.isNotEmpty ? buildAllArchivedNotes(cubit) : buildNoNotesMessage(context, cubit),
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

  MasonryGridView buildAllArchivedNotes(AppCubit cubit) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(20.0),
      crossAxisCount: cubit.isGrid ? 2 : 1,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      itemCount: cubit.archivedNotes.length,
      itemBuilder: (context, index) {
        return NoteItem(
          title: cubit.archivedNotes[index].title,
          body: cubit.archivedNotes[index].body,
          date: cubit.archivedNotes[index].date,
          time: cubit.archivedNotes[index].time,
          colorIndex: 100,
          onTap: () {
            cubit.changeSelectedColor(cubit.archivedNotes[index].color);
            cubit.getDataFromDB(cubit.archivedNotes[index].id);
            cubit.titleController.text = cubit.archivedNotes[index].title;
            cubit.bodyController.text = cubit.archivedNotes[index].body;
            navigateTo(
              context,
              ShowNoteUI(
                id: cubit.archivedNotes[index].id,
                titleController: cubit.titleController,
                bodyController: cubit.bodyController,
                date: cubit.archivedNotes[index].date,
                time: cubit.archivedNotes[index].time,
                colorIndex: cubit.archivedNotes[index].color,
                status: cubit.archivedNotes[index].status,
              ),
            );
          },
        );
      },
    );
  }

  Center buildNoNotesMessage(context, AppCubit cubit) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notes, size: 65.0, color: Colors.grey),
          Text(
            "You don't have new notes yet.",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
