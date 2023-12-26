import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String onActionLabel;
  final void Function()? onAction;

  const CustomDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.onAction,
      required this.onActionLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('❌ Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onAction,
            child: Text(onActionLabel),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16));
  }
}
