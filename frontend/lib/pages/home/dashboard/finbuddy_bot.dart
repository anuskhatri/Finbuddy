import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/bot_controller.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FinBuddyBot extends StatelessWidget {
  FinBuddyBot({super.key});

  final FinBuddyBotController finBuddyBotController =
      Get.put(FinBuddyBotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "FinBuddy AI Assistant",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => finBuddyBotController.chatList.isEmpty &&
                        !finBuddyBotController.showGuide.isTrue
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lottie/chatbot_initial.json",
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            const SizedBox(height: 20),
                            const AppText(
                              text: "Banking Optimization Assistant",
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: AppText(
                                text:
                                    "Your personal AI assistant to help optimize your finances and banking needs",
                                color: Colors.grey[400]!,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                alignment: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: primaryColor.withOpacity(0.3)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.tips_and_updates,
                                      size: 18, color: primaryColor),
                                  SizedBox(width: 8),
                                  AppText(
                                    text: "Type @ to see available commands",
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: finBuddyBotController.chatList.length,
                        itemBuilder: (context, index) {
                          final message = finBuddyBotController.chatList[index];
                          final isUser = message.isUser;

                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              isUser ? 64.0 : 16.0,
                              8,
                              isUser ? 16.0 : 64.0,
                              8,
                            ),
                            child: Align(
                              alignment: isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? primaryColor.withOpacity(0.8)
                                      : overlayColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: AppText(
                                    text: message.message,
                                    color: isUser ? Colors.white : Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => finBuddyBotController.showGuide.isTrue
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: overlayColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8, bottom: 8),
                            child: AppText(
                              text: "Available Commands",
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.3),
                            height: 1,
                          ),
                          const SizedBox(height: 8),
                          buildDynamicTextButton(
                              "@transaction", "Chat With Your Bank Account"),
                          buildDynamicTextButton("@loans", "Apply for a Loan"),
                          buildDynamicTextButton(
                              "@investment", "Explore Investment Options"),
                        ],
                      ))
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: overlayColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enableSuggestions: true,
                      maxLines: null,
                      controller: finBuddyBotController.messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Ask FinBuddy a question...",
                        hintStyle: TextStyle(color: subTextColor),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) {
                        finBuddyBotController.messageController.text
                                .contains("@")
                            ? finBuddyBotController.showGuide.value = true
                            : finBuddyBotController.showGuide.value = false;
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        finBuddyBotController.showGuide.value = false;
                        if (finBuddyBotController
                            .messageController.text.isNotEmpty) {
                          finBuddyBotController.getBotResponse(
                            finBuddyBotController.messageController.text.trim(),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      iconSize: 18,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDynamicTextButton(
    String command,
    String description,
  ) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        finBuddyBotController.messageController.text = "$command ";
        finBuddyBotController.showGuide.value = false;
      },
      child: Row(
        children: [
          const Icon(
            Icons.keyboard_command_key,
            color: primaryColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          AppText(
            text: command,
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          const SizedBox(width: 8),
          AppText(
            text: "- $description",
            color: Colors.grey[400]!,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}
