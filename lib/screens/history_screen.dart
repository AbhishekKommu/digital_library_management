import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/app_background.dart';

class HistoryItem {
  final String title;
  final String author;
  final String action;
  final String date;
  final String time;
  final bool returned;

  const HistoryItem({
    required this.title,
    required this.author,
    required this.action,
    required this.date,
    required this.time,
    required this.returned,
  });
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const List<HistoryItem> history = [
    HistoryItem(
      title: 'Clean Code',
      author: 'Robert C. Martin',
      action: 'Book Returned',
      date: '28 Sep 2026',
      time: '10:30 AM',
      returned: true,
    ),
    HistoryItem(
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      action: 'Book Borrowed',
      date: '22 Sep 2026',
      time: '02:15 PM',
      returned: false,
    ),
    HistoryItem(
      title: 'Atomic Habits',
      author: 'James Clear',
      action: 'Book Returned',
      date: '18 Sep 2026',
      time: '11:20 AM',
      returned: true,
    ),
    HistoryItem(
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      action: 'Book Borrowed',
      date: '10 Sep 2026',
      time: '04:45 PM',
      returned: false,
    ),
    HistoryItem(
      title: 'Clean Code',
      author: 'Robert C. Martin',
      action: 'Book Borrowed',
      date: '02 Sep 2026',
      time: '09:50 AM',
      returned: false,
    ),
  ];

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
                            'Reading History',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '${history.length} recent library activities',
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
                        Icons.history_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Statistics
                Row(
                  children: [
                    Expanded(
                      child: buildSummaryCard(
                        'Total Activities',
                        '${history.length}',
                        Icons.timeline_rounded,
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildSummaryCard(
                        'Books Returned',
                        '${history.where((item) => item.returned).length}',
                        Icons.check_circle_outline,
                        AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildSummaryCard(
                        'Books Borrowed',
                        '${history.where((item) => !item.returned).length}',
                        Icons.bookmark_outline_rounded,
                        AppColors.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // Timeline
                Column(
                  children: List.generate(
                    history.length,
                    (index) {
                      return buildTimelineItem(
                        history[index],
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
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
                const SizedBox(height: 5),
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

  Widget buildTimelineItem(
    HistoryItem item,
    int index,
  ) {
    final Color statusColor = item.returned
        ? AppColors.success
        : AppColors.secondary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          // Timeline
          SizedBox(
            width: 55,
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(
                      alpha: 0.10,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          statusColor.withValues(
                        alpha: 0.25,
                      ),
                    ),
                  ),
                  child: Icon(
                    item.returned
                        ? Icons
                            .assignment_return_rounded
                        : Icons
                            .bookmark_add_rounded,
                    color: statusColor,
                    size: 21,
                  ),
                ),

                if (index != history.length - 1)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin:
                          const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      color: Colors.white
                          .withValues(
                        alpha: 0.08,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 18,
              ),
              padding:
                  const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius:
                    BorderRadius.circular(18),
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
                      Expanded(
                        child: Text(
                          item.action,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        item.time,
                        style: const TextStyle(
                          color:
                              AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    item.author,
                    style: const TextStyle(
                      color:
                          AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 13),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color:
                            AppColors.textSecondary,
                        size: 14,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        item.date,
                        style: const TextStyle(
                          color:
                              AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor
                              .withValues(
                            alpha: 0.10,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            7,
                          ),
                        ),
                        child: Text(
                          item.returned
                              ? 'Completed'
                              : 'Borrowed',
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}