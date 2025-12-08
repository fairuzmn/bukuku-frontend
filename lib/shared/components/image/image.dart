import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.width,
    this.height,
    required this.path,
    this.fit,
    this.filterQuality = FilterQuality.medium,
  });

  final double? width;
  final double? height;
  final String path;
  final BoxFit? fit;
  final FilterQuality filterQuality;

  bool get isImageNetwork => path.contains('http');

  bool get isFile => path.startsWith('/');

  @override
  Widget build(BuildContext context) {
    if (isImageNetwork) {
      return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: path,
        fit: fit,
        filterQuality: filterQuality,
      );
    }

    if (isFile) {
      return Image.file(
        File(path),
        width: width,
        height: height,
        fit: fit,
        filterQuality: filterQuality,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      filterQuality: filterQuality,
    );
  }
}
