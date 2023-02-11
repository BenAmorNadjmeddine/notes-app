import 'package:flutter/material.dart';
import 'package:notes_app/Shared/Style/colors.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    Key? key,
    required this.title,
    required this.body,
    required this.date,
    required this.time,
    required this.colorIndex,
    required this.onTap,
  }) : super(key: key);

  final String title, body, date, time;
  final int colorIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: colorIndex > noteColors.length
              ? Colors.grey.shade400
              : noteColors[colorIndex],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title.isNotEmpty
                ? Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: scaffoldBackgroundDarkColor,
                        ),
                  )
                : const SizedBox(),
            title.isNotEmpty ? const SizedBox(height: 6.0) : const SizedBox(),
            body.isNotEmpty
                ? Text(
              body,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: scaffoldBackgroundDarkColor),
            )
                : const SizedBox(),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "$date | $time",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: scaffoldBackgroundDarkColor,
                      letterSpacing: 0.5,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
