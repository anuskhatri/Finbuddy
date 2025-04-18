import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecentNotifications extends StatelessWidget {
  RecentNotifications({super.key});

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              // Show confirmation dialog before clearing
              Get.dialog(
                AlertDialog(
                  backgroundColor: overlayColor,
                  title: const Text("Clear All Notifications",
                      style: TextStyle(color: Colors.white)),
                  content: const Text(
                      "Are you sure you want to clear all notifications?",
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    TextButton(
                      onPressed: () {
                        // Clear all notifications
                        notificationController.isClosed;
                        Get.back();
                      },
                      child: const Text("Clear",
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
              size: 18,
            ),
            label: const Text(
              "Clear All",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Recent Notifications",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Swipe left to dismiss notifications",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Expanded(
                child: notificationController.notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.bellSlash,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No Notifications",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "You're all caught up!",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: notificationController.notifications.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final notification =
                              notificationController.notifications[index];
                          final parsedDate =
                              DateTime.parse(notification.timestamp);
                          final isToday =
                              DateTime.now().difference(parsedDate).inDays == 0;

                          return Dismissible(
                            key: ValueKey(notification.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              color: Colors.redAccent.withOpacity(0.2),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                            onDismissed: (direction) {
                              notificationController
                                  .deleteNotification(notification.id);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: overlayColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.1)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.bell,
                                          color: primaryColor,
                                          size: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Alert",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          isToday
                                              ? "Today, ${DateFormat("h:mm a").format(parsedDate)}"
                                              : DateFormat("MMM d, yyyy")
                                                  .format(parsedDate),
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    notification.content,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
