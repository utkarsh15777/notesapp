import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const NoteSettings({super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onEditTap!();
          },
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Edit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Delete",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}