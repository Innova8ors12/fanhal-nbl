import 'package:fan_hall/models/get_photos.dart';
import 'package:flutter/cupertino.dart';

class PhotosProvider extends ChangeNotifier {
  GetPhotos userpho = GetPhotos();
  List<String> photos = [];
  // List<> photos1 = [];

  get(List<String> userPhotos) {
    photos.clear();
    photos.addAll(userPhotos);
    notifyListeners();
    // return photos;
  }

  // setPhotos(GetPhotos userphotos) {
  //   userpho = userphotos;
  //   notifyListeners();
  // }
}
