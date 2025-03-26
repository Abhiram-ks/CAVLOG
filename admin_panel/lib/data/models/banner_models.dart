

class BannerModels {
  final List<String> imageUrls;
  final int index;

  BannerModels({required this.imageUrls, required this.index});

  factory BannerModels.fromMap(Map<String,dynamic>map){
    return BannerModels(
      imageUrls: List<String>.from(map['image_urls'] ?? []),
      index: map['index'] ?? 0,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'image_urls': imageUrls,
      'index': index,
    };
  }
}