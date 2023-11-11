import 'package:fan_hall/models/get_album.dart';
import 'package:fan_hall/models/get_photos.dart';
import 'package:flutter/cupertino.dart';

class AlbumProvider extends ChangeNotifier {
  GetAlbum userAlb = GetAlbum();
  List<String> albu=[];
  setAlb(String userAlbum) {
    albu.add(userAlbum);
  
    notifyListeners();
  }

  getPhotos(GetAlbum userAlbum) {
    userAlb = userAlbum;
    notifyListeners();
  }
}
