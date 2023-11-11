import 'package:fan_hall/models/get_photos.dart';
import 'package:fan_hall/models/get_album.dart';

import 'package:flutter/cupertino.dart';

class GetPhotoProvider extends ChangeNotifier {
  // GetPhotos userAlb = GetPhotos();
  List<String> img = [];

  setPhotos(GetPhotos userAlbum) {
    img.add(userAlbum.name.toString());

    notifyListeners();
  }
}
