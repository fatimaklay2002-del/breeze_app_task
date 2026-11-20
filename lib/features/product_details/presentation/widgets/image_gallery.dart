import 'package:flutter/material.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../products/data/models/product.dart';
import 'gallery_buttons.dart';
import 'gallery_overlays.dart';
import 'image_zoom_dialog.dart';

/// Swipeable carousel of product.images with dots, badges and floating buttons.
class ImageGallery extends StatefulWidget {
  final Product product;
  const ImageGallery({super.key, required this.product});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _zoom() {
    final images = widget.product.images;
    if (images.isNotEmpty) showImageZoom(context, images[_page]);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(fit: StackFit.expand, children: [
            PageView.builder(
              controller: _controller,
              itemCount: p.images.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) => AppNetworkImage(url: p.images[i]),
            ),
            Positioned(top: 12, left: 12, child: GalleryBadges(product: p)),
            Positioned(
              top: 12,
              right: 12,
              child: GalleryActions(product: p, onZoom: _zoom),
            ),
            if (p.images.length > 1)
              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: GalleryDots(count: p.images.length, current: _page),
              ),
          ]),
        ),
      ),
    );
  }
}
