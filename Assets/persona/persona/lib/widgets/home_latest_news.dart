class NewsDataModel {
  String imageUrl;
  String caption;

  NewsDataModel({
    required this.imageUrl,
    required this.caption,
  });
}

class NewsData {
  static List<NewsDataModel> NewsList = [
    NewsDataModel(
      imageUrl: 'assets/performance.png',
      caption: 'Deskripsi Gambar 1',
    ),
    NewsDataModel(
      imageUrl: 'assets/performance.png',
      caption: 'Deskripsi Gambar 2',
    ),
    NewsDataModel(
      imageUrl: 'assets/performance.png',
      caption: 'Deskripsi Gambar 3',
    ),
    // Add more image data as needed
  ];
}
