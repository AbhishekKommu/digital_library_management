class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final String image;
  final int publishedYear;
  bool isAvailable;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.image,
    required this.publishedYear,
    this.isAvailable = true,
    this.isFavorite = false,
  });
}