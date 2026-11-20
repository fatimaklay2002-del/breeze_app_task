import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'shimmer_box.dart';


class AppNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  /// Decode size cap (px) to save memory for small thumbnails.
  final int? cacheWidth;
  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.cacheWidth,
  });

  Widget _error() => Container(
        color: AppColors.shimmerBase,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined,
            color: AppColors.textMuted),
      );

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _error();
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      memCacheWidth: cacheWidth,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (_, _) => const ShimmerWrap(
        child: SizedBox.expand(child: ColoredBox(color: Colors.white)),
      ),
      errorWidget: (_, _, _) => _error(),
    );
  }
}
