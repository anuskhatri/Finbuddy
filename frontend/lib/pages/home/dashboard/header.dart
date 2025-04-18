import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/investment_controller.dart';
import 'package:bobhack/pages/home/dashboard/recent_notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BobHeader extends StatelessWidget {
  BobHeader({super.key});

  final InvestmentController investmentController =
      Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => CircleAvatar(
              radius: 24,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Text(
                _getInitials(),
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Text(
                  investmentController.name.value,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: overlayColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Get.to(() => RecentNotifications()),
              icon: Stack(
                children: [
                  FaIcon(
                    FontAwesomeIcons.bell,
                    size: 18,
                    color: Colors.grey[300],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              tooltip: 'Notifications',
            ),
          )
        ],
      ),
    );
  }

  String _getInitials() {
    try {
      final firstName =
          investmentController.personalDetails["first_name"] as String;
      final lastName =
          investmentController.personalDetails["last_name"] as String;
      return (firstName.isNotEmpty ? firstName[0] : '') +
          (lastName.isNotEmpty ? lastName[0] : '');
    } catch (e) {
      return 'U'; // Default if there's an error
    }
  }
}
//changed
