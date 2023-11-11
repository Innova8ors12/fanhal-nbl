import 'package:fan_hall/models/get_album.dart';

import 'package:flutter/cupertino.dart';

class AlbumPhotoProvider extends ChangeNotifier {
  GetAlbum userAlb = GetAlbum();

  setPhotos(GetAlbum userAlbum) {
    userAlb = userAlbum;
    notifyListeners();
  }

  getPhotos(GetAlbum userAlbum) {
    userAlb = userAlbum;
    notifyListeners();
  }
}
