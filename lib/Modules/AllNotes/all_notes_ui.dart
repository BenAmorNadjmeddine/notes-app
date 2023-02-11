import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/empty_page_message.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';

import 'UIComponents/all_notes.dart';

class AllNotesUI extends StatelessWidget {
  const AllNotesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return cubit.allNotes.isNotEmpty
            ? AllNotes(cubit: cubit)
            : EmptyPageMessage(
                cubit: cubit,
                icon: Icons.notes,
                message: "You don't have notes yet.",
              );
      },
    );
  }
}
