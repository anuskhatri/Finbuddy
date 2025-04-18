import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/investment_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OverallInvestment extends StatelessWidget {
  OverallInvestment({super.key});

  final InvestmentController investmentController =
      Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            overlayColor.withOpacity(0.3),
            Colors.grey[850]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.chartPie,
                  color: primaryColor,
                  size: 14,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Your Investments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.all(8),
                  ),
                  minimumSize: WidgetStateProperty.all(
                    const Size(0, 0),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    overlayColor.withOpacity(0.3),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.chartLine,
                  color: Colors.white,
                  size: 15,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'P&L',
                style: TextStyle(
                  color: Color(0xff878787),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      formatter.format(investmentController
                              .overallInvestment['overall_PL'] ??
                          0),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Obx(() {
                    final percentage = investmentController
                            .overallInvestment['overall_PL_percentage'] ??
                        0;
                    final isPositive = investmentController
                            .overallInvestment['total_current_value'] >=
                        investmentController
                            .overallInvestment['total_invested_amount'];

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (isPositive ? Colors.green : Colors.red)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isPositive
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: isPositive ? Colors.green : Colors.red,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$percentage%",
                            style: TextStyle(
                              color: isPositive ? Colors.green : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(
                color: Color.fromARGB(255, 87, 87, 87),
                thickness: 0.5,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Invested',
                          style: TextStyle(
                            color: Color(0xff878787),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(
                          () => Text(
                            formatter.format(
                                investmentController.overallInvestment[
                                        'total_invested_amount'] ??
                                    0),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current',
                          style: TextStyle(
                            color: Color(0xff878787),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(
                          () => Text(
                            formatter.format(investmentController
                                    .overallInvestment['total_current_value'] ??
                                0),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
