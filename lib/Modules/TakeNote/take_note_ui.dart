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
          body: buildNoteDetails(width, cubit, context, date, time),
          floatingActionButton: buildFAB(cubit, context, date, time),
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
            controller: cubit.titleController,
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
            controller: cubit.bodyController,
            style: Theme.of(context).textTheme.bodyMedium!,
            hintText: "Start typing",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  FloatingActionButton buildFAB(AppCubit cubit, BuildContext context, String date, String time) {
    return FloatingActionButton.extended(
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
      label: const Text("Save"),
      icon: const Icon(Icons.save),
    );
  }
}
