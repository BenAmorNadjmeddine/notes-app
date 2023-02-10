import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Cubit/states.dart';
import 'package:notes_app/Shared/Network/Local/cache_helper.dart';
import 'package:notes_app/bloc_observer.dart';

import 'Layout/notes_app_layout.dart';
import 'Shared/Style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await CacheHelper.init();
  bool? isDarkMode = CacheHelper.getBool(key: "isDarkMode") ?? false;
  bool? isGrid = CacheHelper.getBool(key: "isGrid") ?? false;
  runApp(MyApp(isDarkMode: isDarkMode, isGrid: isGrid));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.isDarkMode, this.isGrid});

  bool? isDarkMode, isGrid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..changeThemeMode(isDarkModeFromShared: isDarkMode)
        ..changeListGridView(isGridFromShared: isGrid)
        ..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'Notit',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const NotesAppLayout(),
          );
        },
      ),
    );
  }
}
