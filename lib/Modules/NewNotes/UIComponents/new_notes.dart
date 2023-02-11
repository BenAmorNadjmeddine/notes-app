import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/Modules/ShowNote/show_note_ui.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/note_item.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';

class NewNotes extends StatelessWidget {
  const NewNotes({
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
      itemCount: cubit.newNotes.length,
      itemBuilder: (context, index) {
        return NoteItem(
          title: cubit.newNotes[index].title,
          body: cubit.newNotes[index].body,
          date: cubit.newNotes[index].date,
          time: cubit.newNotes[index].time,
          colorIndex: cubit.newNotes[index].color,
          onTap: () {
            cubit.changeSelectedColor(cubit.newNotes[index].color);
            cubit.getDataFromDB(cubit.newNotes[index].id);
            cubit.titleController.text = cubit.newNotes[index].title;
            cubit.bodyController.text = cubit.newNotes[index].body;
            navigateTo(
              context,
              ShowNoteUI(
                id: cubit.newNotes[index].id,
                titleController: cubit.titleController,
                bodyController: cubit.bodyController,
                date: cubit.newNotes[index].date,
                time: cubit.newNotes[index].time,
                colorIndex: cubit.newNotes[index].color,
                status: cubit.newNotes[index].status,
              ),
            );
          },
        );
      },
    );
  }
}
