import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final AuthService authService;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;

    return Drawer(
      backgroundColor: AppColors.backgroundSecondary,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(user?.name ?? AppConstants.defaultUserName),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildSectionTitle('MAIN'),

                  _buildDrawerItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    index: 0,
                  ),

                  _buildDrawerItem(
                    icon: Icons.menu_book_rounded,
                    title: 'Books',
                    index: 1,
                  ),

                  _buildDrawerItem(
                    icon: Icons.bookmark_rounded,
                    title: 'Borrowed Books',
                    index: 2,
                  ),

                  _buildDrawerItem(
                    icon: Icons.favorite_rounded,
                    title: 'Favorites',
                    index: 3,
                  ),

                  _buildDrawerItem(
                    icon: Icons.history_rounded,
                    title: 'History',
                    index: 4,
                  ),

                  const SizedBox(height: 18),

                  _buildSectionTitle('ACCOUNT'),

                  _buildDrawerItem(
                    icon: Icons.person_rounded,
                    title: 'Profile',
                    index: 5,
                  ),

                  _buildDrawerItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    index: 6,
                  ),
                ],
              ),
            ),

            _buildLogoutButton(context),

            const SizedBox(height: 12),

            Text(
              'Version ${AppConstants.appVersion}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String userName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            AppConstants.appName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            userName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        gradient: isSelected
            ? AppColors.primaryGradient
            : null,
        color: isSelected
            ? null
            : Colors.transparent,
        borderRadius: BorderRadius.circular(13),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 2,
        ),
        leading: Icon(
          icon,
          color: isSelected
              ? Colors.white
              : AppColors.textSecondary,
          size: 21,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onTap: () {
          onItemSelected(index);
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () {
          authService.logout();

          Navigator.of(context).popUntil(
            (route) => route.isFirst,
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: AppColors.error.withValues(alpha: 0.18),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}