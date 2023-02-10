import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/Models/note.dart';
import 'package:notes_app/Modules/AchivedNotes/archived_notes_ui.dart';
import 'package:notes_app/Modules/NewNotes/new_notes_ui.dart';
import 'package:notes_app/Shared/Components/components.dart';
import 'package:notes_app/Shared/Cubit/states.dart';
import 'package:notes_app/Shared/Network/Local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDarkMode = false;

  void changeThemeMode({bool? isDarkModeFromShared}) {
    if (isDarkModeFromShared != null) {
      isDarkMode = isDarkModeFromShared;
      emit(AppChangeModeState());
    } else {
      isDarkMode = !isDarkMode;
      CacheHelper.putBool(key: "isDarkMode", value: isDarkMode).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  bool isGrid = true;

  void changeListGridView({bool? isGridFromShared}) {
    if (isGridFromShared != null) {
      isGrid = isGridFromShared;
      emit(AppChangeGridState());
    } else {
      isGrid = !isGrid;
      CacheHelper.putBool(key: "isGrid", value: isGrid).then((value) {
        emit(AppChangeGridState());
      });
    }
  }

  late Database database;

  void createDB() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) async {
      await database
          .execute(""
              "CREATE TABLE notes ("
              "id INTEGER PRIMARY KEY, "
              "title TEXT, "
              "body TEXT, "
              "date TEXT, "
              "time TEXT, "
              "color int, "
              "status TEXT"
              ")")
          .then((value) {
        getAllDataFromDB(database);
      }).catchError((error) {
        showToast(
          text: 'Error: ${error.toString()}',
          state: ToastStates.error,
          gravity: ToastGravity.CENTER,
        );
      });
    }, onOpen: (database) {
      getAllDataFromDB(database);
    }).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  int currentColorIndex = 0;

  void changeSelectedColor(int colorIndex) {
    currentColorIndex = colorIndex;
    emit(AppChangeSelectedColorState());
  }

  List<Note> allNotes = [];
  List<Note> newNotes = [];
  List<Note> archivedNotes = [];

  void getDataFromDB(int id) {
    database.query("notes", where: "id = ?", whereArgs: [id]).then((row) {}).catchError((error) {
          showToast(
            text: "Error : ${error.toString()}",
            state: ToastStates.error,
            gravity: ToastGravity.CENTER,
          );
        });
  }

  void getAllDataFromDB(database) {
    allNotes.clear();
    newNotes.clear();
    archivedNotes.clear();
    emit(AppGetFromDBState());
    database.rawQuery("SELECT * FROM notes").then((value) {
      value.forEach((element) {
        allNotes.add(Note.fromJSON(element));
        if (element['status'] == 'new') {
          newNotes.add(Note.fromJSON(element));
        } else {
          archivedNotes.add(Note.fromJSON(element));
        }
      });
      allNotes = allNotes.reversed.toList();
      newNotes = newNotes.reversed.toList();
      archivedNotes = archivedNotes.reversed.toList();
      emit(AppGetFromDBState());
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void insertIntoDB({
    required String title,
    required String body,
    required String date,
    required String time,
    required int color,
    required String status,
  }) async {
    await database
        .transaction((txn) => txn
                .rawInsert(""
                    "INSERT INTO notes (title, body, date, time, color, status) "
                    "VALUES ('$title', '$body', '$date', '$time', '$color', '$status')")
                .then((value) {
              emit(AppInsertIntoDBState());
              getAllDataFromDB(database);
            }).catchError((error) {
              showToast(
                text: 'Error: ${error.toString()}',
                state: ToastStates.error,
                gravity: ToastGravity.CENTER,
              );
            }))
        .catchError((error) {
      showToast(
        text: 'Error: ${error.toString()}',
        state: ToastStates.error,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  void updateDBEditNote({
    required int id,
    required String title,
    required String body,
    required String date,
    required String time,
    required int color,
  }) {
    database.rawUpdate(
      "UPDATE notes SET title = ?, body = ?, date = ?, time = ?, color = ? WHERE id = ?",
      [title, body, date, time, color, id],
    ).then((value) {
      getAllDataFromDB(database);
      emit(AppUpdateDBEditNoteState());
    }).catchError((error) {
      showToast(text: 'Error: ${error.toString()}', state: ToastStates.error, gravity: ToastGravity.CENTER);
    });
  }

  void updateDBNoteStatus({
    required int id,
    required String status,
    required BuildContext context,
  }) {
    database.rawUpdate(
      "UPDATE NOTES SET status = ? WHERE id = ?",
      [status, id],
    ).then((value) {
      showToast(
        text: status == "new" ? 'Note unarchived successfully' : 'Note archived successfully',
        state: ToastStates.archive,
        gravity: ToastGravity.CENTER,
      );
      getAllDataFromDB(database);
      popAndResetAll(context);
      status == "new" ? navigateTo(context, const NewNotesUI()) : navigateTo(context, const ArchivedNotesUI());
      emit(AppUpdateDBNoteStatusState());
    }).catchError((error) {
      showToast(
        text: 'Error: ${error.toString()}',
        state: ToastStates.error,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  void deleteFromDB({required int id}) {
    database.rawDelete(
      "DELETE FROM notes WHERE id = ?",
      [id],
    ).then((value) {
      getAllDataFromDB(database);
      emit(AppDeleteFromDBState());
    });
  }

  void popAndResetAll(context) {
    Navigator.pop(context);
    titleController.clear();
    bodyController.clear();
    currentColorIndex = 0;
    emit(AppChangeVariableState());
  }
}
