import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/Modules/ShowNote/show_note_ui.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/note_item.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';

class AllNotesUI extends StatelessWidget {
  const AllNotesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return cubit.allNotes.isNotEmpty ? buildAllNotes(cubit) : buildNoNotesMessage(context, cubit);
      },
    );
  }

  MasonryGridView buildAllNotes(AppCubit cubit) {
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

  Center buildNoNotesMessage(context, AppCubit cubit) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notes, size: 65.0, color: Colors.grey),
          Text(
            "You don't have notes yet.",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
