import 'package:flutter/material.dart';
import 'package:notesapp/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {

  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteTile({super.key, required this.text, required this.onEditPressed, required this.onDeletePressed});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(left: 25,right: 25,top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        title: Text(
          text
        ),

        // trailing: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //       icon: const Icon(Icons.edit),
        //       onPressed: onEditPressed,
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.delete),
        //       onPressed: onDeletePressed,
        //     ),
        //   ],
        // ),

        trailing: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                width: 100,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                  onEditTap: onEditPressed,
                  onDeleteTap: onDeletePressed,
                )
              ),
            );
          }
        ),
        
      ),
    );
  }
}