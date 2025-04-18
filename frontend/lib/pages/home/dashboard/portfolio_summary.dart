import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/investment_controller.dart';
import 'package:bobhack/controllers/summary_controller.dart';
import 'package:bobhack/controllers/transaction_controller.dart';
import 'package:bobhack/pages/home/dashboard/charts/piechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PortfolioSummary extends StatelessWidget {
  PortfolioSummary({super.key});

  final InvestmentController investmentController =
      Get.put(InvestmentController());
  final ChartsController chartsController = Get.put(ChartsController());
  final SummaryController summaryController = Get.put(SummaryController());
  final PageController _pageController = PageController();

  // Initialize FlutterTts
  final FlutterTts flutterTts = FlutterTts();

  // Function to trigger TTS
  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  // Function to stop TTS
  Future<void> _stop() async {
    await flutterTts.stop();
  }

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
          "Portfolio Summary",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Portfolio Visualization Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.1),
                      Colors.grey[850]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
                            FontAwesomeIcons.chartSimple,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Portfolio Visualization",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          LoanPieChart(),
                          PieChart(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
              ),

              const SizedBox(height: 24),

              // Expert Analysis Section
              Obx(
                () => summaryController.loading.isTrue
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 30),
                        decoration: BoxDecoration(
                          color: overlayColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.1)),
                        ),
                        child: const Column(
                          children: [
                            SpinKitWaveSpinner(color: primaryColor, size: 50.0),
                            SizedBox(height: 24),
                            Text(
                              "Analyzing your portfolio data",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "This may take a few seconds...",
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: overlayColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.1)),
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
                                    FontAwesomeIcons.lightbulb,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Expert Analysis",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _speak(summaryController
                                              .profileSummary.value);
                                        },
                                        icon: const Icon(
                                          Icons.volume_up,
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                        tooltip: "Read Aloud",
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        onPressed: _stop,
                                        icon: const Icon(
                                          Icons.volume_off,
                                          color: Colors.redAccent,
                                          size: 18,
                                        ),
                                        tooltip: "Stop Reading",
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Improved expert analysis text presentation
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.grey[850]!.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.user,
                                        color: primaryColor,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 10),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Hello ",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  investmentController.name.value,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.2,
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      summaryController.profileSummary.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w400,
                                        height: 1.7,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // Back to Dashboard Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text(
                    "Back to Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
