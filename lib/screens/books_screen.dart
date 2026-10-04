import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/book_service.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';
import 'book_details_screen.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Programming',
    'Fiction',
    'Classic',
    'Self Development',
  ];

  List<Book> get filteredBooks {
    List<Book> books =
        BookService.searchBooks(searchController.text);

    if (selectedCategory != 'All') {
      books = books
          .where(
            (book) =>
                book.category == selectedCategory,
          )
          .toList();
    }

    return books;
  }

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final books = filteredBooks;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Digital Library',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '${books.length} books available in your library',
                            style: const TextStyle(
                              color:
                                  AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.library_books_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Search
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius:
                        BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.06,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText:
                          'Search by title, author or category...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                      ),
                      suffixIcon:
                          searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                  ),
                                )
                              : null,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Categories
                const Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder:
                        (_, __) =>
                            const SizedBox(width: 10),
                    itemBuilder:
                        (context, index) {
                      final category =
                          categories[index];

                      final selected =
                          selectedCategory ==
                              category;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory =
                                category;
                          });
                        },
                        child: AnimatedContainer(
                          duration:
                              const Duration(
                            milliseconds: 250,
                          ),
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          decoration: BoxDecoration(
                            gradient: selected
                                ? AppColors
                                    .primaryGradient
                                : null,
                            color: selected
                                ? null
                                : AppColors.card,
                            borderRadius:
                                BorderRadius.circular(
                              13,
                            ),
                            border: Border.all(
                              color: selected
                                  ? Colors.transparent
                                  : Colors.white
                                      .withValues(
                                      alpha: 0.06,
                                    ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : AppColors
                                        .textSecondary,
                                fontSize: 13,
                                fontWeight:
                                    selected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Results
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'All Books',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${books.length} results',
                      style: const TextStyle(
                        color:
                            AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Books Grid
                books.isEmpty
                    ? buildEmptyState()
                    : LayoutBuilder(
                        builder:
                            (context, constraints) {
                          int columns = 1;

                          if (constraints.maxWidth >
                              1100) {
                            columns = 4;
                          } else if (constraints
                                  .maxWidth >
                              750) {
                            columns = 3;
                          } else if (constraints
                                  .maxWidth >
                              450) {
                            columns = 2;
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            itemCount: books.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  columns,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              childAspectRatio:
                                  0.70,
                            ),
                            itemBuilder:
                                (context, index) {
                              return buildBookCard(
                                books[index],
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBookCard(Book book) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailsScreen(
              book: book,
            ),
          ),
        );

        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius:
              BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.06,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.18,
              ),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // Book cover
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient:
                          AppColors.primaryGradient,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 65,
                      ),
                    ),
                  ),

                  // Favorite
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          book.isFavorite =
                              !book.isFavorite;
                        });
                      },
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withValues(
                            alpha: 0.35,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          book.isFavorite
                              ? Icons.favorite_rounded
                              : Icons
                                  .favorite_border_rounded,
                          color: book.isFavorite
                              ? Colors.pink
                              : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // Availability
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: book.isAvailable
                            ? AppColors.success
                                .withValues(
                                alpha: 0.9,
                              )
                            : AppColors.error
                                .withValues(
                                alpha: 0.9,
                              ),
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: Text(
                        book.isAvailable
                            ? 'Available'
                            : 'Borrowed',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Title
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Author
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            // Category + year
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary
                        .withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(7),
                  ),
                  child: Text(
                    book.category,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const Spacer(),

                Text(
                  '${book.publishedYear}',
                  style: const TextStyle(
                    color:
                        AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 70,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 65,
            color: AppColors.textSecondary
                .withValues(alpha: 0.6),
          ),
          const SizedBox(height: 18),
          const Text(
            'No books found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try another search or category',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}