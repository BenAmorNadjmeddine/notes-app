import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/fab.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';

import 'UIComponents/notes_details.dart';

class ShowNoteUI extends StatelessWidget {
  const ShowNoteUI({
    Key? key,
    required this.id,
    required this.titleController,
    required this.bodyController,
    required this.date,
    required this.time,
    required this.colorIndex,
    required this.status,
  }) : super(key: key);

  final String date, time, status;
  final TextEditingController titleController, bodyController;
  final int id, colorIndex;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String editedDate = DateFormat.MMMMd().format(DateTime.now());
    String editedTime = TimeOfDay.now().format(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(cubit, context),
          body: NoteDetails(width: width, cubit: cubit, titleController: titleController, date: date, time: time, bodyController: bodyController),
          floatingActionButton: FAB(
            onPressed: () {
              if (bodyController.text.isEmpty && bodyController.text.isEmpty) {
                showToast(
                  text: "Note title or body should not be empty!",
                  state: ToastStates.error,
                  gravity: ToastGravity.CENTER,
                );
              } else {
                cubit.updateDBEditNote(
                  id: id,
                  title: titleController.text,
                  body: bodyController.text,
                  date: editedDate,
                  time: editedTime,
                  color: cubit.currentColorIndex,
                );
                cubit.popAndResetAll(context);
              }
            },
            text: "Save",
            icon: Icons.save,
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
      title: const Text("Edit Note"),
      actions: [
        GestureDetector(
          onTap: () {
            var deletedTitle = titleController.text;
            var deletedBody = bodyController.text;
            var deletedDate = date;
            var deletedTime = time;
            var deletedColorIndex = colorIndex;
            var deletedStatus = status;
            cubit.deleteFromDB(id: id);
            showSnackBar(
              context: context,
              message: "Note deleted successfully",
              duration: 3,
              actionMessage: "UNDO",
              action: () {
                cubit.insertIntoDB(
                  title: deletedTitle,
                  body: deletedBody,
                  date: deletedDate,
                  time: deletedTime,
                  color: deletedColorIndex,
                  status: deletedStatus,
                );
                deletedTitle = '';
                deletedBody = '';
                deletedDate = '';
                deletedTime = '';
                deletedColorIndex = 100;
                deletedStatus = '';
              },
            );
            cubit.popAndResetAll(context);
          },
          child: const Icon(Icons.delete),
        ),
        const SizedBox(width: 20.0),
        GestureDetector(
          onTap: () {
            if (status == "new") {
              cubit.updateDBNoteStatus(id: id, status: "archive", context: context);
            } else {
              cubit.updateDBNoteStatus(id: id, status: "new", context: context);
            }
          },
          child: Icon(status == "new" ? Icons.archive : Icons.unarchive),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

}

