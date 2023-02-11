import 'package:flutter/material.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';

class EmptyPageMessage extends StatelessWidget {
  const EmptyPageMessage({
    super.key,
    required this.cubit,
    this.icon = Icons.notes,
    this.message = "You don't have notes yet.",
  });

  final AppCubit cubit;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 65.0, color: Colors.grey),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
