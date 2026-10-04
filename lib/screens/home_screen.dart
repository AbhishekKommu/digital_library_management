import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/book_service.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';
import 'books_screen.dart';
import 'borrowed_books_screen.dart';
import 'favorites_screen.dart';
import 'history_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthService authService;

  const HomeScreen({
    super.key,
    required this.authService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<String> menuItems = [
    'Dashboard',
    'Books',
    'Borrowed Books',
    'Favorites',
    'History',
    'Profile',
    'Settings',
  ];

  final List<IconData> menuIcons = [
    Icons.dashboard_rounded,
    Icons.menu_book_rounded,
    Icons.bookmark_rounded,
    Icons.favorite_rounded,
    Icons.history_rounded,
    Icons.person_rounded,
    Icons.settings_rounded,
  ];

  void selectMenu(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void logout() {
    widget.authService.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  Widget buildContent() {
    switch (selectedIndex) {
      case 1:
        return const BooksScreen();

      case 2:
        return const BorrowedBooksScreen();

      case 3:
        return const FavoritesScreen();

      case 4:
        return const HistoryScreen();

      case 5:
        return const ProfileScreen();

      case 6:
        return const SettingsScreen();

      default:
        return buildDashboard();
    }
  }

  Widget buildDashboard() {
    final books = BookService.getBooks();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Welcome back 👋',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.authService.currentUser?.name ??
                          'Library User',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Explore your digital library',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Notification
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: 0.06,
                    ),
                  ),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Search
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(
                  alpha: 0.06,
                ),
              ),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search books, authors or categories...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Statistics
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              int count = 1;

              if (width > 1000) {
                count = 4;
              } else if (width > 650) {
                count = 2;
              }

              return GridView.count(
                crossAxisCount: count,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.2,
                children: [
                  buildStatCard(
                    title: 'Total Books',
                    value: '${books.length}',
                    icon: Icons.menu_book_rounded,
                    color: AppColors.primary,
                  ),
                  buildStatCard(
                    title: 'Borrowed',
                    value: '3',
                    icon: Icons.bookmark_rounded,
                    color: AppColors.secondary,
                  ),
                  buildStatCard(
                    title: 'Favorites',
                    value: '${BookService.getFavorites().length}',
                    icon: Icons.favorite_rounded,
                    color: Colors.pink,
                  ),
                  buildStatCard(
                    title: 'Reading',
                    value: '2',
                    icon: Icons.auto_stories_rounded,
                    color: Colors.purple,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 35),

          // Section title
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Popular Books',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  selectMenu(1);
                },
                child: const Text(
                  'View All',
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Books
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final book = books[index];

                return buildBookCard(book);
              },
            ),
          ),

          const SizedBox(height: 35),

          // Categories
          const Text(
            'Browse Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              buildCategory(
                'Programming',
                Icons.code_rounded,
              ),
              buildCategory(
                'Fiction',
                Icons.auto_stories_rounded,
              ),
              buildCategory(
                'Classic',
                Icons.history_edu_rounded,
              ),
              buildCategory(
                'Self Development',
                Icons.psychology_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatCard({
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
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

  Widget buildBookCard(dynamic book) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
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
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 55,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(
    String title,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: 20,
          ),
          const SizedBox(width: 9),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Row(
            children: [
              // Sidebar
              Container(
                width: 245,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card.withValues(
                    alpha: 0.96,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: 0.06,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Logo
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient:
                                AppColors.primaryGradient,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.menu_book_rounded,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Text(
                            'Digital Library',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Expanded(
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder:
                            (context, index) {
                          return buildMenuItem(
                            index,
                          );
                        },
                      ),
                    ),

                    const Divider(
                      color: Colors.white12,
                    ),

                    // Logout
                    ListTile(
                      onTap: logout,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      leading: const Icon(
                        Icons.logout_rounded,
                        color: AppColors.error,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(int index) {
    final isSelected =
        selectedIndex == index;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 6,
      ),
      decoration: BoxDecoration(
        gradient: isSelected
            ? AppColors.primaryGradient
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          selectMenu(index);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        leading: Icon(
          menuIcons[index],
          color: isSelected
              ? Colors.white
              : AppColors.textSecondary,
        ),

        title: Text(
          menuItems[index],
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : AppColors.textSecondary,
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}