import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/fab.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';

import 'UIComponents/note_details.dart';

class TakeNoteUI extends StatelessWidget {
  const TakeNoteUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.MMMMd().format(DateTime.now());
    String time = TimeOfDay.now().format(context);
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(cubit, context),
          body: NoteDetails(width: width, cubit: cubit, date: date, time: time),
          floatingActionButton: FAB(
            onPressed: () {
              if (cubit.titleController.text.isEmpty && cubit.bodyController.text.isEmpty) {
                showToast(
                  text: "Note title or body should not be empty!",
                  state: ToastStates.error,
                  gravity: ToastGravity.CENTER,
                );
              } else {
                cubit.insertIntoDB(
                  title: cubit.titleController.text,
                  body: cubit.bodyController.text,
                  date: date,
                  time: time,
                  color: cubit.currentColorIndex,
                  status: "new",
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
          if (cubit.bodyController.text.isNotEmpty) {
            showAlertBoxDialog(context: context, cubit: cubit);
          } else {
            cubit.popAndResetAll(context);
          }
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: const Text("Take Note"),
    );
  }
}