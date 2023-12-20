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

SnackBar getCartSnackbar(ThemeData theme, String snackbarType) {
  return SnackBar(
    backgroundColor: snackbarType == 'error'
        ? theme.colorScheme.error
        : const Color.fromARGB(255, 0, 161, 83),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              snackbarType == 'error'
                  ? Icons.warning_amber_rounded
                  : Icons.check_circle_outline,
              color: theme.colorScheme.onPrimary),
          const SizedBox(width: 8),
          Text(
            snackbarType == 'error'
                ? 'Item already in cart'
                : 'Item added to cart',
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
        ],
      ),
    ),
  );
}
