import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScalePage extends StatelessWidget {
  final String url;
  const ImageScalePage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Недвижимость СПб'),
        ),
        body: PhotoView(imageProvider: NetworkImage(url)));
  }
}
