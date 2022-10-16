import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String src;
  BoxFit? fit = BoxFit.cover;

  ImageNetwork({
    Key? key,
    required this.src,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      fit: fit,
      errorBuilder: (context, error, strakTrace) {
        return Container(
          color: const Color.fromARGB(10, 255, 65, 59),
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: Color.fromARGB(255, 255, 65, 59),
          ),
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: const Color.fromARGB(255, 255, 65, 59),
            ),
          );
        }
      },
    );
  }
}
