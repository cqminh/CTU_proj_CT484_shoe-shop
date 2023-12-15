import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Bạn chắc chứ?'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Đồng ý'),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
        TextButton(
          child: const Text('Không'),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}