import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "التقارير",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'JotiOne',
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _reportCard(
                        "المبيعات الشهرية",
                        Icons.bar_chart,
                        Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "الأكثر مبيعاً",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 15),
                              _topSellingItem("Cheese Burger", "650 Sold", 1.0),
                              _topSellingItem(
                                "Pizza Margherita",
                                "420 Sold",
                                0.7,
                              ),
                              _topSellingItem("Tacos Poulet", "310 Sold", 0.5),
                              _topSellingItem("Coca Cola", "800 Sold", 0.9),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      _statTile(
                        "إجمالي الأرباح",
                        "45,200 DH",
                        Icons.attach_money,
                        Colors.green,
                      ),
                      _statTile(
                        "إجمالي المصاريف",
                        "12,500 DH",
                        Icons.money_off,
                        Colors.redAccent,
                      ),
                      _statTile(
                        "صافي الربح",
                        "32,700 DH",
                        Icons.account_balance_wallet,
                        const Color(0xFFF3A402),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportCard(String title, IconData icon, Color color) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Mock bars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _bar(40, color),
                _bar(60, color),
                _bar(30, color),
                _bar(80, color),
                _bar(50, color),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(double height, Color color) {
    return Container(
      width: 10,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _topSellingItem(String name, String value, double percent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(color: Colors.white70)),
              Text(value, style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.white10,
            color: const Color(0xFFF3A402),
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  Widget _statTile(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
