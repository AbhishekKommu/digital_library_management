import 'package:flutter/material.dart';

import '../models/book.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailsScreen> createState() =>
      _BookDetailsScreenState();
}

class _BookDetailsScreenState
    extends State<BookDetailsScreen> {
  bool isBorrowed = false;

  void borrowBook() {
    if (!widget.book.isAvailable) {
      showMessage(
        'This book is currently unavailable.',
        isError: true,
      );
      return;
    }

    setState(() {
      isBorrowed = true;
      widget.book.isAvailable = false;
    });

    showMessage(
      'Book borrowed successfully!',
    );
  }

  void returnBook() {
    setState(() {
      isBorrowed = false;
      widget.book.isAvailable = true;
    });

    showMessage(
      'Book returned successfully!',
    );
  }

  void toggleFavorite() {
    setState(() {
      widget.book.isFavorite =
          !widget.book.isFavorite;
    });

    showMessage(
      widget.book.isFavorite
          ? 'Added to favorites'
          : 'Removed from favorites',
    );
  }

  void showMessage(
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? AppColors.error
            : AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Expanded(
                      child: Text(
                        'Book Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: toggleFavorite,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: Icon(
                          book.isFavorite
                              ? Icons.favorite_rounded
                              : Icons
                                  .favorite_border_rounded,
                          color: book.isFavorite
                              ? Colors.pink
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // Main book section
                LayoutBuilder(
                  builder:
                      (context, constraints) {
                    final isWide =
                        constraints.maxWidth > 750;

                    if (isWide) {
                      return Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: buildBookCover(),
                          ),
                          const SizedBox(width: 35),
                          Expanded(
                            flex: 6,
                            child: buildBookInformation(),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        buildBookCover(),
                        const SizedBox(height: 30),
                        buildBookInformation(),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 35),

                // Description
                buildDescription(),

                const SizedBox(height: 30),

                // Additional information
                buildAdditionalInformation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBookCover() {
    final book = widget.book;

    return Container(
      height: 480,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius:
            BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(
              alpha: 0.25,
            ),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -70,
            right: -70,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(
                  alpha: 0.08,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -90,
            left: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(
                  alpha: 0.06,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                    size: 70,
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Text(
                    book.title,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  book.author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(
                      alpha: 0.75,
                    ),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBookInformation() {
    final book = widget.book;

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // Category
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary
                  .withValues(
                alpha: 0.10,
              ),
              borderRadius:
                  BorderRadius.circular(9),
            ),
            child: Text(
              book.category,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            book.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'by ${book.author}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 25),

          // Details
          buildInfoRow(
            Icons.calendar_today_outlined,
            'Published',
            '${book.publishedYear}',
          ),

          const SizedBox(height: 14),

          buildInfoRow(
            Icons.library_books_outlined,
            'Category',
            book.category,
          ),

          const SizedBox(height: 14),

          buildInfoRow(
            book.isAvailable
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            'Status',
            book.isAvailable
                ? 'Available'
                : 'Currently Borrowed',
            valueColor: book.isAvailable
                ? AppColors.success
                : AppColors.error,
          ),

          const SizedBox(height: 30),

          // Button
          if (isBorrowed)
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: returnBook,
                icon: const Icon(
                  Icons.assignment_return_rounded,
                ),
                label: const Text(
                  'RETURN BOOK',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      AppColors.secondary,
                  side: const BorderSide(
                    color: AppColors.secondary,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 54,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient:
                      AppColors.primaryGradient,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: ElevatedButton.icon(
                  onPressed: book.isAvailable
                      ? borrowBook
                      : null,
                  icon: const Icon(
                    Icons.bookmark_add_rounded,
                  ),
                  label: Text(
                    book.isAvailable
                        ? 'BORROW BOOK'
                        : 'NOT AVAILABLE',
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent,
                    disabledBackgroundColor:
                        Colors.transparent,
                    shadowColor:
                        Colors.transparent,
                    foregroundColor:
                        Colors.white,
                    disabledForegroundColor:
                        Colors.white54,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildInfoRow(
    IconData icon,
    String title,
    String value, {
    Color valueColor = Colors.white,
  }) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary
                .withValues(alpha: 0.10),
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 19,
          ),
        ),

        const SizedBox(width: 12),

        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),

        const Spacer(),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: AppColors.secondary,
              ),
              SizedBox(width: 10),
              Text(
                'About This Book',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            widget.book.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAdditionalInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Library Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: buildLibraryItem(
                  Icons.local_library_outlined,
                  'Digital Access',
                  'Available online',
                ),
              ),
              Expanded(
                child: buildLibraryItem(
                  Icons.security_outlined,
                  'Secure',
                  'Library protected',
                ),
              ),
              Expanded(
                child: buildLibraryItem(
                  Icons.devices_rounded,
                  'Multi Device',
                  'Access anywhere',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLibraryItem(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 25,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color:
                        AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}