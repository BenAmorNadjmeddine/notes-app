import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/Modules/ShowNote/show_note_ui.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/note_item.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';

class AllNotes extends StatelessWidget {
  const AllNotes({
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
      itemCount: cubit.allNotes.length,
      itemBuilder: (context, index) {
        return NoteItem(
          title: cubit.allNotes[index].title,
          body: cubit.allNotes[index].body,
          date: cubit.allNotes[index].date,
          time: cubit.allNotes[index].time,
          colorIndex: cubit.allNotes[index].status == "new" ? cubit.allNotes[index].color : 100,
          onTap: () {
            cubit.changeSelectedColor(cubit.allNotes[index].color);
            cubit.getDataFromDB(cubit.allNotes[index].id);
            cubit.titleController.text = cubit.allNotes[index].title;
            cubit.bodyController.text = cubit.allNotes[index].body;
            navigateTo(
              context,
              ShowNoteUI(
                id: cubit.allNotes[index].id,
                titleController: cubit.titleController,
                bodyController: cubit.bodyController,
                date: cubit.allNotes[index].date,
                time: cubit.allNotes[index].time,
                colorIndex: cubit.allNotes[index].color,
                status: cubit.allNotes[index].status,
              ),
            );
          },
        );
      },
    );
  }
}
