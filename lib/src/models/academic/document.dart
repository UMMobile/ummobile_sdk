/// The document model.
class Document {
  /// The id of the document.
  int id;

  /// The name of the document.
  String name;

  /// The pages of the document, if any.
  List<DocumentPage> pages;

  /// The images of the document, if any.
  @Deprecated("Use pages field instead")
  List<DocumentImg> images;

  /// The Document constructor.
  Document({
    required this.id,
    required this.name,
    this.pages: const [],
    this.images: const [],
  });
}

/// The document image model.
@Deprecated("Use DocumentPage class instead")
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

/// The document page model.
class DocumentPage {
  /// The page of the document.
  int page;

  /// The URL for the image.
  String? urlImage;

  /// The base 64 image.
  String? base64Image;

  /// The DocumentPage model
  DocumentPage({
    required this.page,
    this.urlImage,
    this.base64Image,
  });
}
