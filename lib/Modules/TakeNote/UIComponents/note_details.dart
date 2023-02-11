import 'package:flutter/material.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/color_picker.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/my_text_field.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Style/colors.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({
    super.key,
    required this.width,
    required this.cubit,
    required this.date,
    required this.time,
  });

  final double width;
  final AppCubit cubit;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
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
}
