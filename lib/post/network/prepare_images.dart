import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

/// This class have 2 function for preparing the images.

class PrepareImages {
  /// This function is used to load the images
  ///
  /// it takes a list of urls and returns a list of Images.
  static Future loadImages(List<String> images) async {
    List<String> imagesValid = [];
    for (int i = 0; i < images.length; i++) {
      try {
        await http.head(Uri.parse(images[i]));
        imagesValid.add(images[i]);
      } catch (e) {}
    }

    List<Image?> temp = [];
    temp = imagesValid
        .map((image) {
          return Image.network(
            image,
            fit: BoxFit.cover,
          );
        })
        .cast<Image>()
        .toList();

    return temp;
  }

  /// This function is used to get the height of a given Image.
  static Future getHeightOfImage(Image image) async {
    Completer<ImageInfo> completer = Completer();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image.height.toDouble();
  }

  ///this function is used to get the max height from a list of Images.

  static Future getMaxHeight(List<Image> imageList) async {
    double max = 0;
    List<double> imagesHeight =
        List.filled(imageList.length, 0, growable: false);
    for (int i = 0; i < imageList.length; i++) {
      imagesHeight[i] = await getHeightOfImage(imageList[i]);

      if (imagesHeight[i] > max) max = imagesHeight[i];
    }
    return max;
  }
}
