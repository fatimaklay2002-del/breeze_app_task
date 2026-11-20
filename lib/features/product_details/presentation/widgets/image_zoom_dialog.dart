import 'package:flutter/material.dart';
import '../../../../core/widgets/app_network_image.dart';

Future<void> showImageZoom(BuildContext context, String url) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(children: [
        Positioned.fill(
          child: InteractiveViewer(
            maxScale: 4,
            child: AppNetworkImage(url: url, fit: BoxFit.contain),
          ),
        ),
        SafeArea(
          child: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ),
      ]),
    ),
  );
}
