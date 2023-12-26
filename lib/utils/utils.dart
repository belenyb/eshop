import 'package:flutter/material.dart';

String capitalize(text) {
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

getIcon(category) {
  switch (category) {
    case "electronics":
      return "📱";
    case "jewelery":
      return "💍";
    case "men's clothing":
      return "👔";
    case "women's clothing":
      return "👢";
    default:
      return "🛒";
  }
}

SnackBar getSnackbar(
    ThemeData theme, String snackbarType, String snackbarMessage, {void Function()? action}) {
  return SnackBar(
    backgroundColor: snackbarType == 'error'
        ? theme.colorScheme.error
        : const Color.fromARGB(255, 0, 161, 83),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  snackbarType == 'error'
                      ? Icons.warning_amber_rounded
                      : Icons.check_circle_outline,
                  color: theme.colorScheme.onPrimary),
              const SizedBox(width: 8),
              Text(
                snackbarMessage,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            ],
          ),
          if(action != null) TextButton(onPressed: action, child: const Text("View cart", style: TextStyle(decoration: TextDecoration.underline),))
        ],
      ),
    ),
  );
}
