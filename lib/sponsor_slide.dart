import 'dart:io';

import 'package:flutter/widgets.dart';

class SponsorSlide extends StatelessWidget {
  const SponsorSlide({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(File('/home/wim/Downloads/klein teater logo.png')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 64),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 64,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Image.file(image),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ],
    );
  }
}
