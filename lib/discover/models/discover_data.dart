import '../../post/models/post_model.dart';

class DiscoverData {
  List<Map<String, String>>? imgAndVideoList;
  List<PostModel>? allPosts;
  DiscoverData({required this.allPosts, required this.imgAndVideoList});
  // ===================================this function used to===========================================//
//=================to change json to model===========================//
  DiscoverData.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> tempDataImagesAndVideo = [];
    List<PostModel> tempData = [];
    json['data'].forEach((imagesAndVideos) {
      print(imagesAndVideos);
      if (imagesAndVideos['kind'] == 'image') {
        imagesAndVideos['images'].forEach((img) {
          tempDataImagesAndVideo.add({
            'subredditName': imagesAndVideos['owner']['fixedName'],
            'Url': img,
          });
        });
      } else {
        tempDataImagesAndVideo.add({
          'subredditName': imagesAndVideos['owner']['fixedName'],
          'Url': imagesAndVideos['video']
        });
      }
      PostModel temp = PostModel();
      temp.fromJson(imagesAndVideos);
      tempData.add(temp);
    });
    imgAndVideoList = tempDataImagesAndVideo;
    allPosts = tempData;
  }
}
