import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/book_service.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';

class BorrowedBooksScreen extends StatefulWidget {
  const BorrowedBooksScreen({super.key});

  @override
  State<BorrowedBooksScreen> createState() =>
      _BorrowedBooksScreenState();
}

class _BorrowedBooksScreenState
    extends State<BorrowedBooksScreen> {
  final List<Book> borrowedBooks = [];

  @override
  void initState() {
    super.initState();

    // Demo borrowed books.
    // In a real application this data would come
    // from a database/backend.
    borrowedBooks.addAll(
      BookService.books
          .where((book) => !book.isAvailable)
          .toList(),
    );
  }

  void returnBook(Book book) {
    setState(() {
      book.isAvailable = true;
      borrowedBooks.remove(book);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${book.title} returned successfully',
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                            'Borrowed Books',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '${borrowedBooks.length} books currently borrowed',
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.bookmark_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: buildSummaryCard(
                        title: 'Borrowed',
                        value:
                            '${borrowedBooks.length}',
                        icon:
                            Icons.menu_book_rounded,
                        color:
                            AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildSummaryCard(
                        title: 'Due Soon',
                        value: '1',
                        icon:
                            Icons.schedule_rounded,
                        color:
                            AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildSummaryCard(
                        title: 'Returned',
                        value: '5',
                        icon:
                            Icons.check_circle_rounded,
                        color:
                            AppColors.success,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                borrowedBooks.isEmpty
                    ? buildEmptyState()
                    : Column(
                        children:
                            borrowedBooks.map(
                          (book) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: 18,
                              ),
                              child:
                                  buildBorrowedBook(
                                book,
                              ),
                            );
                          },
                        ).toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.12,
              ),
              borderRadius:
                  BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color:
                        AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBorrowedBook(Book book) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                buildBookMainInfo(book),
                const SizedBox(height: 18),
                buildDueDate(book),
                const SizedBox(height: 18),
                buildReturnButton(book),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                flex: 5,
                child: buildBookMainInfo(book),
              ),
              Expanded(
                flex: 3,
                child: buildDueDate(book),
              ),
              SizedBox(
                width: 150,
                child: buildReturnButton(book),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildBookMainInfo(Book book) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 105,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius:
                BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 38,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                book.author,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary
                      .withValues(alpha: 0.10),
                  borderRadius:
                      BorderRadius.circular(7),
                ),
                child: Text(
                  book.category,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDueDate(Book book) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.warning.withValues(
            alpha: 0.15,
          ),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.calendar_month_rounded,
            color: AppColors.warning,
            size: 23,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Due Date',
                style: TextStyle(
                  color:
                      AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '15 Oct 2026',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReturnButton(Book book) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton.icon(
        onPressed: () {
          returnBook(book);
        },
        icon: const Icon(
          Icons.assignment_return_rounded,
          size: 18,
        ),
        label: const Text(
          'Return',
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor:
              AppColors.secondary,
          side: const BorderSide(
            color: AppColors.secondary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: AppColors.primary
                  .withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: AppColors.primary,
              size: 42,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'No Borrowed Books',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'Books you borrow will appear here.',
            textAlign: TextAlign.center,
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