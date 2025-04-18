import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/transaction_controller.dart';
import 'package:bobhack/pages/home/dashboard/charts/barchart.dart';
import 'package:bobhack/pages/home/dashboard/charts/piechart.dart';
import 'package:bobhack/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecentTransactions extends StatelessWidget {
  RecentTransactions({super.key});

  final TransactionController transactionController = Get.find();
  final ChartsController chartsController = Get.find();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text(
          "Transactions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: chartsController.toggleplot.toggle,
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FaIcon(
                  chartsController.toggleplot.isTrue
                      ? FontAwesomeIcons.moneyBills
                      : FontAwesomeIcons.chartSimple,
                  color: primaryColor,
                  size: 16,
                ),
              ),
              tooltip: chartsController.toggleplot.isTrue
                  ? "Show List View"
                  : "Show Chart View",
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: overlayColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Obx(
                    () => Text(
                      "${transactionController.transactions.length} transaction${transactionController.transactions.length != 1 ? 's' : ''}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              return chartsController.toggleplot.isTrue
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: overlayColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.chartColumn,
                                  color: primaryColor,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Transaction Analysis",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: PageView(
                              controller: _pageController,
                              children: [
                                PieChart(),
                                BarChart(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: const WormEffect(
                                dotWidth: 10.0,
                                dotHeight: 10.0,
                                spacing: 16.0,
                                radius: 8.0,
                                dotColor: Colors.grey,
                                activeDotColor: primaryColor,
                              ),
                              onDotClicked: (index) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            }),
            Obx(() => chartsController.toggleplot.isTrue
                ? const SizedBox(height: 20)
                : const SizedBox.shrink()),
            Expanded(
              child: Obx(
                () => transactionController.transactions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.receipt,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No Transactions Found",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: transactionController.transactions.length,
                        itemBuilder: (context, index) {
                          var transaction =
                              transactionController.transactions[index];
                          return TransactionTile(transaction: transaction);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
