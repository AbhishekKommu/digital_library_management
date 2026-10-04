import '../models/book.dart';

class BookService {
  static final List<Book> books = [
    Book(
      id: '1',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      category: 'Classic',
      description:
          'A classic novel about dreams, wealth, love and ambition.',
      image: 'assets/images/books/gatsby.jpg',
      publishedYear: 1925,
    ),

    Book(
      id: '2',
      title: 'Atomic Habits',
      author: 'James Clear',
      category: 'Self Development',
      description:
          'A practical guide to building good habits and breaking bad ones.',
      image: 'assets/images/books/atomic_habits.jpg',
      publishedYear: 2018,
    ),

    Book(
      id: '3',
      title: 'Clean Code',
      author: 'Robert C. Martin',
      category: 'Programming',
      description:
          'A guide to writing clean, readable and maintainable software.',
      image: 'assets/images/books/clean_code.jpg',
      publishedYear: 2008,
    ),

    Book(
      id: '4',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      category: 'Fiction',
      description:
          'A philosophical story about following dreams and discovering purpose.',
      image: 'assets/images/books/alchemist.jpg',
      publishedYear: 1988,
    ),
  ];

  static List<Book> getBooks() {
    return books;
  }

  static List<Book> searchBooks(
    String query,
  ) {
    if (query.trim().isEmpty) {
      return books;
    }

    return books.where((book) {
      return book.title
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          book.author
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          book.category
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  static List<Book> getFavorites() {
    return books
        .where((book) => book.isFavorite)
        .toList();
  }
}