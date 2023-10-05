import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String url;
  final Size size;
  final BoxShape? shape;
  final BorderRadiusGeometry? borderadius;
  const AppCachedNetworkImage(
      {super.key,
      required this.url,
      required this.size,
      this.borderadius,
      this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            shape: shape!,
            borderRadius: borderadius,
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          height: size.height,
          width: size.width,
          decoration:
              BoxDecoration(color: Colors.grey, borderRadius: borderadius),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: size.height,
          width: size.width,
          decoration:
              BoxDecoration(color: Colors.grey, borderRadius: borderadius),
          child: const Icon(Icons.error),
        );
      },
    );
  }
}
