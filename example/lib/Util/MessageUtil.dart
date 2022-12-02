


import 'package:flutter/material.dart';

void showSnackBar(BuildContext context , String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    action: SnackBarAction(
      label: "关闭",
      onPressed: () {
        // Code to execute.
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
    ),
    content: Text(content),
    duration: const Duration(milliseconds: 15000),
    padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
        vertical: 10.0
    ),
    behavior: SnackBarBehavior.fixed,
  ));
}