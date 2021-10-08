class Archive {
  int id;
  String name;
  List<ArchiveImg> images;

  Archive({
    required this.id,
    required this.name,
    this.images: const [],
  });
}

class ArchiveImg {
  int page;
  String? image;

  ArchiveImg({
    required this.page,
    required this.image,
  });
}
