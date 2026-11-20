import 'package:flutter/material.dart';
import '../../../../app/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';

/// Dark floating snackbar: message + "View Bag ->" + close.
void showAddedSnackBar(BuildContext context, int qty) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.snackbar,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      ),
      duration: const Duration(seconds: 4),
      content: Row(children: [
        const CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.success,
          child: Icon(Icons.check, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Added '),
              TextSpan(
                  text: qty == 1 ? '1 item' : '$qty items',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const TextSpan(text: ' to your bag!'),
            ]),
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        TextButton(
          onPressed: () {
            messenger.hideCurrentSnackBar();
            goToBagTab(context);
          },
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text('View Bag',
                style: TextStyle(
                    color: AppColors.snackbarAction,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded,
                size: 16, color: AppColors.snackbarAction),
          ]),
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 18, color: Colors.white),
          onPressed: messenger.hideCurrentSnackBar,
        ),
      ]),
    ));
}
