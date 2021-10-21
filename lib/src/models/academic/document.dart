/// The document model.
class Document {
  /// The id of the document.
  int id;

  /// The name of the document.
  String name;

  /// The images of the document, if any.
  List<DocumentImg> images;

  /// The Document constructor.
  Document({
    required this.id,
    required this.name,
    this.images: const [],
  });
}

/// The document image model.
class DocumentImg {
  /// The page of the document.
  int page;

  /// The URL for the image... or the base64 string? I don't really know, but rigth now is null.
  String? image;

  /// The DocumentImg model
  DocumentImg({
    required this.page,
    required this.image,
  });
}
