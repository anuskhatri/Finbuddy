import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/login_controller.dart';
import 'package:bobhack/controllers/summary_controller.dart';
import 'package:bobhack/controllers/transaction_controller.dart';
import 'package:bobhack/pages/home/dashboard/balance.dart';
import 'package:bobhack/pages/home/dashboard/chat_bot.dart';
import 'package:bobhack/pages/home/dashboard/header.dart';
import 'package:bobhack/pages/home/dashboard/linked_accounts.dart';
import 'package:bobhack/pages/home/dashboard/overall_investment.dart';
import 'package:bobhack/pages/home/dashboard/portfolio_summary.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BobDashboard extends StatefulWidget {
  const BobDashboard({super.key});

  @override
  State<BobDashboard> createState() => _BobDashboardState();
}

class _BobDashboardState extends State<BobDashboard> {
  final ChartsController chartsController = Get.put(ChartsController());
  final SummaryController summaryController = Get.put(SummaryController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BobHeader(),
            LinkedAccounts(),
            YourBalance(),
            OverallInvestment(),
            const ChatBot(),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => PortfolioSummary());
                  chartsController.fetchTransactionPieChartData();
                  chartsController.fetchLoanChartData();
                  summaryController.getPortfolioSummary();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.chartPie,
                      size: 16,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Generate Portfolio Summary",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              indent: MediaQuery.of(context).size.width * 0.05,
              endIndent: MediaQuery.of(context).size.width * 0.05,
              color: Colors.grey.withOpacity(0.3),
              thickness: 0.5,
            ),
            Container(
              alignment: Alignment.center,
              child: TextButton.icon(
                onPressed: () {
                  LoginController().deleteSessionKey();
                  Get.back();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.redAccent,
                  size: 18,
                ),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
