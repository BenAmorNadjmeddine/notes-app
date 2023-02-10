import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Style/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

enum ToastStates {
  success,
  warning,
  error,
  archive,
  hint,
}

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.archive:
      color = Colors.grey;
      break;
    case ToastStates.hint:
      color = Colors.blueAccent;
      break;
  }
  return color;
}

void showToast({required String text, required ToastStates state, required ToastGravity gravity}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: scaffoldBackgroundLightColor,
    fontSize: 14.0,
  );
}

void showSnackBar({
  required BuildContext context,
  required String message,
  required int duration,
  required String actionMessage,
  required VoidCallback action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(8.0),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      duration: Duration(seconds: duration),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      action: SnackBarAction(
        label: actionMessage,
        onPressed: action,
      ),
    ),
  );
}

void showAlertBoxDialog({
  required BuildContext context,
  required AppCubit cubit,
}) {
  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'You are going to cancel this note.\nAre you sure?',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                          ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.popAndResetAll(context);
                    },
                    child: Text(
                      'Yes',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: cubit.isDarkMode ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
                          ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                ],
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        );
      });
}
