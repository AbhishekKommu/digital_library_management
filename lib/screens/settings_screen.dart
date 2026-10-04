import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/app_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool emailNotifications = true;
  bool autoRenew = false;
  bool biometricLogin = false;

  String selectedLanguage = 'English';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.cardLight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth >= 900;

            return SingleChildScrollView(
              padding: EdgeInsets.all(isWide ? 32 : 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        'Preferences',
                        Icons.tune_rounded,
                      ),
                      const SizedBox(height: 12),

                      _buildSettingsCard(
                        children: [
                          _buildSwitchTile(
                            icon: Icons.notifications_active_outlined,
                            title: 'Notifications',
                            subtitle:
                                'Receive library and account notifications',
                            value: notifications,
                            onChanged: (value) {
                              setState(() {
                                notifications = value;
                              });

                              showMessage(
                                value
                                    ? 'Notifications enabled'
                                    : 'Notifications disabled',
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            icon: Icons.email_outlined,
                            title: 'Email Notifications',
                            subtitle:
                                'Receive updates and reminders by email',
                            value: emailNotifications,
                            onChanged: (value) {
                              setState(() {
                                emailNotifications = value;
                              });

                              showMessage(
                                value
                                    ? 'Email notifications enabled'
                                    : 'Email notifications disabled',
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            icon: Icons.autorenew_rounded,
                            title: 'Auto Renew',
                            subtitle:
                                'Automatically renew borrowed books',
                            value: autoRenew,
                            onChanged: (value) {
                              setState(() {
                                autoRenew = value;
                              });

                              showMessage(
                                value
                                    ? 'Auto renew enabled'
                                    : 'Auto renew disabled',
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        'Security',
                        Icons.security_rounded,
                      ),
                      const SizedBox(height: 12),

                      _buildSettingsCard(
                        children: [
                          _buildSwitchTile(
                            icon: Icons.fingerprint_rounded,
                            title: 'Biometric Login',
                            subtitle:
                                'Use biometric authentication for login',
                            value: biometricLogin,
                            onChanged: (value) {
                              setState(() {
                                biometricLogin = value;
                              });

                              showMessage(
                                value
                                    ? 'Biometric login enabled'
                                    : 'Biometric login disabled',
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildActionTile(
                            icon: Icons.lock_outline_rounded,
                            title: 'Change Password',
                            subtitle: 'Update your account password',
                            onTap: () {
                              showMessage(
                                'Password change option selected',
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildActionTile(
                            icon: Icons.privacy_tip_outlined,
                            title: 'Privacy & Security',
                            subtitle:
                                'Manage your privacy and security settings',
                            onTap: () {
                              showMessage(
                                'Privacy & Security selected',
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        'General',
                        Icons.settings_outlined,
                      ),
                      const SizedBox(height: 12),

                      _buildSettingsCard(
                        children: [
                          _buildLanguageTile(),
                          _buildDivider(),
                          _buildActionTile(
                            icon: Icons.dark_mode_outlined,
                            title: 'Dark Mode',
                            subtitle:
                                'Dark theme is currently active',
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'ON',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {
                              showMessage(
                                'Dark mode is already active',
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildActionTile(
                            icon: Icons.delete_sweep_outlined,
                            title: 'Clear Cache',
                            subtitle:
                                'Clear temporary application data',
                            onTap: () {
                              _showClearCacheDialog();
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        'About',
                        Icons.info_outline_rounded,
                      ),
                      const SizedBox(height: 12),

                      _buildSettingsCard(
                        children: [
                          _buildActionTile(
                            icon: Icons.info_outline_rounded,
                            title: 'About Digital Library',
                            subtitle:
                                'Learn more about this application',
                            onTap: () {
                              _showAboutDialog();
                            },
                          ),
                          _buildDivider(),
                          _buildActionTile(
                            icon: Icons.help_outline_rounded,
                            title: 'Help & Support',
                            subtitle:
                                'Get help with your library account',
                            onTap: () {
                              showMessage(
                                'Help & Support selected',
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildActionTile(
                            icon: Icons.description_outlined,
                            title: 'Terms & Conditions',
                            subtitle:
                                'View application terms and policies',
                            onTap: () {
                              showMessage(
                                'Terms & Conditions selected',
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              AppConstants.appName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Version ${AppConstants.appVersion}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Smart • Simple • Digital',
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 18,
              ),
            ],
          ),
          child: const Icon(
            Icons.settings_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Customize your digital library experience',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.secondary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      leading: _buildIconBox(icon),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.secondary,
        activeTrackColor: AppColors.secondary.withValues(
          alpha: 0.35,
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      leading: _buildIconBox(icon),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
          ),
    );
  }

  Widget _buildLanguageTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      leading: _buildIconBox(
        Icons.language_rounded,
      ),
      title: const Text(
        'Language',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(top: 4),
        child: Text(
          'Choose your preferred language',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          dropdownColor: AppColors.cardLight,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.secondary,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            DropdownMenuItem(
              value: 'English',
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: 'Telugu',
              child: Text('Telugu'),
            ),
            DropdownMenuItem(
              value: 'Hindi',
              child: Text('Hindi'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedLanguage = value;
            });

            showMessage(
              'Language changed to $value',
            );
          },
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        icon,
        color: AppColors.secondary,
        size: 22,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 78,
      endIndent: 18,
      color: Colors.white.withValues(alpha: 0.06),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Clear Cache',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to clear temporary data?',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showMessage(
                  'Cache cleared successfully',
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'Digital Library Management System helps users discover, borrow, manage and organize books digitally.\n\nVersion 1.0.0',
            style: TextStyle(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}