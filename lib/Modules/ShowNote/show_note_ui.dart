import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/color_picker.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/my_text_field.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';
import 'package:notes_app/Shared/Style/colors.dart';
import 'package:intl/intl.dart';

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
          body: buildNoteDetails(width, cubit, context, date, time),
          floatingActionButton: buildFAB(cubit, context, editedDate, editedTime),
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

  Padding buildNoteDetails(double width, AppCubit cubit, BuildContext context, String date, String time) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: 45.0,
            child: Center(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: noteColors.length,
                itemBuilder: (context, index) => ColorPicker(
                  onTap: () {
                    cubit.changeSelectedColor(index);
                  },
                  colorIndex: index,
                ),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 15.0),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          MyTextField(
            controller: titleController,
            hintText: "Title",
            style: Theme.of(context).textTheme.headlineSmall!,
            hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 10.0),
          Text(
            "$date | $time",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey, wordSpacing: 3.0),
          ),
          const SizedBox(height: 10.0),
          Divider(
            color: Colors.grey.shade500,
            height: 20.0,
          ),
          const SizedBox(height: 10.0),
          MyTextField(
            controller: bodyController,
            style: Theme.of(context).textTheme.bodyMedium!,
            hintText: "Start typing",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  FloatingActionButton buildFAB(AppCubit cubit, BuildContext context, String editedDate, String editedTime) {
    return FloatingActionButton.extended(
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
      label: const Text("Save"),
      icon: const Icon(Icons.save),
    );
  }
}
