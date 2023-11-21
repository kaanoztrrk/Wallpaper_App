// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
class PhotosModel {
  String imgSrc;
  String photoName;

  PhotosModel({required this.imgSrc, required this.photoName});

  static PhotosModel fromAPIApp(Map<String, dynamic> photoMap) {
    return PhotosModel(
        imgSrc: (photoMap["src"])["portrait"],
        photoName: photoMap["photographer"]);
  }
}
