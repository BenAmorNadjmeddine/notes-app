import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/Modules/ShowNote/show_note_ui.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/note_item.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';

class ArchivedNotes extends StatelessWidget {
  const ArchivedNotes({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
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
}
