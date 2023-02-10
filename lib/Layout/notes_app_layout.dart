import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Modules/AchivedNotes/archived_notes_ui.dart';
import 'package:notes_app/Modules/AllNotes/all_notes_ui.dart';
import 'package:notes_app/Modules/NewNotes/new_notes_ui.dart';
import 'package:notes_app/Modules/TakeNote/take_note_ui.dart';
import 'package:notes_app/Shared/Components/ReusableWidgets/drawer_item.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';
import 'package:notes_app/Shared/Style/colors.dart';

class NotesAppLayout extends StatelessWidget {
  const NotesAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(cubit, context),
          drawer: buildNavigationDrawer(context, cubit),
          body: const AllNotesUI(),
          floatingActionButton: buildFAB(context),
        );
      },
    );
  }

  AppBar buildAppBar(AppCubit cubit, BuildContext context) {
    return AppBar(
      title: const Text("Notes App"),
      actions: [
        GestureDetector(
          onTap: () {
            cubit.changeListGridView();
          },
          child: Icon(cubit.isGrid ? Icons.list : Icons.grid_view_rounded),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

  Drawer buildNavigationDrawer(BuildContext context, AppCubit cubit) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CloseButton(),
                DrawerItem(
                  onTap: () {
                    Navigator.pop(context);
                    navigateTo(context, const TakeNoteUI());
                  },
                  itemColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  iconBoxColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  iconColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  textColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  icon: Icons.edit,
                  text: "Add Note",
                ),
                const SizedBox(height: 15.0),
                DrawerItem(
                  onTap: () {
                    Navigator.pop(context);
                    navigateTo(context, const NewNotesUI());
                  },
                  itemColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  iconBoxColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  iconColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  textColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  icon: Icons.notes,
                  text: "New Notes",
                ),
                const SizedBox(height: 15.0),
                DrawerItem(
                  onTap: () {
                    Navigator.pop(context);
                    navigateTo(context, const ArchivedNotesUI());
                  },
                  itemColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  iconBoxColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  iconColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  textColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  icon: Icons.archive,
                  text: "Archive",
                ),
                const SizedBox(height: 15.0),
                DrawerItem(
                  onTap: () {
                    cubit.changeThemeMode();
                    // navigateTo(context, const ArchivedNotesUI());
                  },
                  itemColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  iconBoxColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  iconColor: cubit.isDarkMode ? scaffoldBackgroundLightColor : scaffoldBackgroundDarkColor,
                  textColor: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                  icon: cubit.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  text: cubit.isDarkMode ? "Light Mode" : "Dark Mode",
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: const Icon(Icons.power_settings_new, size: 32.0),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Developed by : Ben Amor Nadjmeddine",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        navigateTo(context, const TakeNoteUI());
      },
      label: const Text("Add Note"),
      icon: const Icon(Icons.edit),
    );
  }
}
