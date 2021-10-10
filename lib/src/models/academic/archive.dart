/// The archive model.
class Archive {
  /// The id of the archive.
  int id;

  /// The name of the archive.
  String name;

  /// The images of the archive, if any.
  List<ArchiveImg> images;

  /// The Archive constructor.
  Archive({
    required this.id,
    required this.name,
    this.images: const [],
  });
}

/// The archive image model.
class ArchiveImg {
  /// The page of the archive.
  int page;

  /// The URL for the image... or the base64 string? I don't really know, but rigth now is null.
  String? image;

  /// The ArchiveImg model
  ArchiveImg({
    required this.page,
    required this.image,
  });
}
