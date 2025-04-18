import 'dart:ui';

import 'package:bobhack/constants.dart';
import 'package:bobhack/pages/home/dashboard/finbuddy_bot.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor.withOpacity(0.05),
                  Colors.grey[850]!.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: primaryColor.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.robot,
                              size: 14,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const AppText(
                            text: "FinBuddy AI",
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      const AppText(
                        text: "Your AI-powered financial assistant",
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => FinBuddyBot()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor.withOpacity(0.2),
                    foregroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: primaryColor.withOpacity(0.5)),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.comments, size: 14),
                      SizedBox(width: 8),
                      AppText(
                        text: "Ask FinBuddy",
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
}
