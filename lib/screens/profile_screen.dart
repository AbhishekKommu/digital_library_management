import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/book_service.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  final AuthService authService = AuthService();

  bool isEditing = false;

  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: authService.currentUser?.name ??
          'Library User',
    );

    emailController = TextEditingController(
      text: authService.currentUser?.email ??
          'user@digitallibrary.com',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveProfile() {
    setState(() {
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile updated successfully',
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = BookService.books;

    final favoriteCount =
        books.where((book) => book.isFavorite).length;

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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Manage your library account',
                            style: TextStyle(
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
                        Icons.person_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Profile card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient:
                        AppColors.primaryGradient,
                    borderRadius:
                        BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withValues(
                          alpha: 0.20,
                        ),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder:
                        (context, constraints) {
                      final isWide =
                          constraints.maxWidth >
                              650;

                      if (isWide) {
                        return Row(
                          children: [
                            buildAvatar(),
                            const SizedBox(width: 22),
                            Expanded(
                              child:
                                  buildProfileHeader(),
                            ),
                            buildEditButton(),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          buildAvatar(),
                          const SizedBox(height: 18),
                          buildProfileHeader(),
                          const SizedBox(height: 18),
                          buildEditButton(),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Statistics
                LayoutBuilder(
                  builder:
                      (context, constraints) {
                    int columns = 1;

                    if (constraints.maxWidth >
                        900) {
                      columns = 4;
                    } else if (constraints
                            .maxWidth >
                        500) {
                      columns = 2;
                    }

                    return GridView.count(
                      crossAxisCount: columns,
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 2.2,
                      children: [
                        buildStatCard(
                          'Books Read',
                          '12',
                          Icons.auto_stories_rounded,
                          AppColors.primary,
                        ),
                        buildStatCard(
                          'Borrowed',
                          '3',
                          Icons.bookmark_rounded,
                          AppColors.secondary,
                        ),
                        buildStatCard(
                          'Favorites',
                          '$favoriteCount',
                          Icons.favorite_rounded,
                          Colors.pink,
                        ),
                        buildStatCard(
                          'Achievements',
                          '5',
                          Icons.emoji_events_rounded,
                          AppColors.warning,
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Account information
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius:
                        BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white
                          .withValues(
                        alpha: 0.06,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Account Information',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isEditing)
                            TextButton(
                              onPressed: saveProfile,
                              child: const Text(
                                'SAVE',
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      buildTextField(
                        label: 'Full Name',
                        controller:
                            nameController,
                        icon:
                            Icons.person_outline,
                      ),

                      const SizedBox(height: 18),

                      buildTextField(
                        label: 'Email Address',
                        controller:
                            emailController,
                        icon:
                            Icons.email_outlined,
                      ),

                      const SizedBox(height: 18),

                      buildReadOnlyField(
                        label: 'User ID',
                        value: 'USR001',
                        icon:
                            Icons.badge_outlined,
                      ),

                      const SizedBox(height: 18),

                      buildReadOnlyField(
                        label: 'Member Since',
                        value: 'September 2026',
                        icon:
                            Icons.calendar_today_outlined,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Library membership
                buildMembershipCard(),

                const SizedBox(height: 25),

                // Profile options
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius:
                        BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white
                          .withValues(
                        alpha: 0.06,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      buildOption(
                        Icons.lock_outline_rounded,
                        'Change Password',
                        'Update your account password',
                        () {
                          showMessage(
                            'Password settings will be available soon.',
                          );
                        },
                      ),
                      buildOption(
                        Icons.download_outlined,
                        'Download History',
                        'Download your reading history',
                        () {
                          showMessage(
                            'Download feature will be added soon.',
                          );
                        },
                      ),
                      buildOption(
                        Icons.help_outline_rounded,
                        'Help & Support',
                        'Get help with your library account',
                        () {
                          showMessage(
                            'Support section will be added soon.',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.15,
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.30,
          ),
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.person_rounded,
        color: Colors.white,
        size: 48,
      ),
    );
  }

  Widget buildProfileHeader() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          nameController.text.isEmpty
              ? 'Library User'
              : nameController.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          emailController.text,
          style: TextStyle(
            color: Colors.white.withValues(
              alpha: 0.72,
            ),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.12,
            ),
            borderRadius:
                BorderRadius.circular(8),
          ),
          child: const Text(
            'Premium Member',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditButton() {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          isEditing = !isEditing;
        });
      },
      icon: Icon(
        isEditing
            ? Icons.close_rounded
            : Icons.edit_rounded,
        size: 17,
      ),
      label: Text(
        isEditing ? 'Cancel' : 'Edit Profile',
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(
          color: Colors.white.withValues(
            alpha: 0.35,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(18),
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
                alpha: 0.10,
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
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color:
                        AppColors.textSecondary,
                    fontSize: 11,
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

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      enabled: isEditing,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return TextField(
      enabled: false,
      controller:
          TextEditingController(text: value),
      style: const TextStyle(
        color: AppColors.textSecondary,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget buildMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.14,
              ),
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Library Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Enjoy unlimited access to your digital library.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildOption(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(
            alpha: 0.10,
          ),
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textSecondary,
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }
}