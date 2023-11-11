import 'package:fan_hall/models/get_photos.dart';
import 'package:fan_hall/models/get_album.dart';
import 'package:fan_hall/models/get_videos.dart';

import 'package:flutter/cupertino.dart';

class GetVideoProvider extends ChangeNotifier {
  // GetPhotos userAlb = GetPhotos();
  List<String> vid = [];

  setVideos(GetVideos userVideos) {
  for(var i=0;i<=100;i++){
    vid.add(userVideos.name!);
  }

    // vid.add(userAlbum.name.toString());

    notifyListeners();
    // return vid;
  }
}
