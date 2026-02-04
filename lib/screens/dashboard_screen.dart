import 'package:flutter/material.dart';
import '../services/order_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "لوحة التحكم",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'JotiOne',
            ),
          ),
          const SizedBox(height: 20),
          // Stats Row
          const Row(
            children: [
              Expanded(
                child: StatCard(
                  title: "مبيعات اليوم",
                  value: "1,250 DH",
                  icon: Icons.attach_money,
                  color: Color(0xFFF3A402),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: "الطلبات",
                  value: "45",
                  icon: Icons.shopping_bag,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: "قيد التحضير",
                  value: "3",
                  icon: Icons.timelapse,
                  color: Colors.orangeAccent,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: "مكتملة",
                  value: "42",
                  icon: Icons.check_circle,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          Expanded(
            child: Row(
              children: [
                // Recent Orders
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "آخر الطلبات (Real-time)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: AnimatedBuilder(
                            animation: OrderService(),
                            builder: (context, _) {
                              final orders = OrderService().orders;
                              if (orders.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No active orders",
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                );
                              }
                              return ListView.separated(
                                itemCount: orders.length,
                                separatorBuilder: (c, i) =>
                                    const Divider(color: Colors.white12),
                                itemBuilder: (context, index) {
                                  final order = orders[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: const Color(
                                        0xFFF3A402,
                                      ).withOpacity(0.2),
                                      child: const Icon(
                                        Icons.receipt,
                                        color: Color(0xFFF3A402),
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      "${order.tableNumber} • ${order.total.toStringAsFixed(0)} DH",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${order.items.length} items • ${order.status}",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                    ),
                                    trailing: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: order.status == 'pending'
                                            ? Colors.orange.withOpacity(0.2)
                                            : Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        order.status.toUpperCase(),
                                        style: TextStyle(
                                          color: order.status == 'pending'
                                              ? Colors.orange
                                              : Colors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Quick Actions / Notifications
                Expanded(
                  child: Column(
                    children: [
                      _buildActionCard(Icons.add, "طلب جديد", () {}),
                      const SizedBox(height: 15),
                      _buildActionCard(Icons.person_add, "عميل جديد", () {}),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.redAccent.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "تنبيهات المخزون",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _stockItem("Coca Cola", "Low Stock (5)"),
                              _stockItem("Cheese", "Low Stock (2kg)"),
                            ],
                          ),
                        ),
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

  Widget _stockItem(String name, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white70)),
          Text(
            status,
            style: const TextStyle(color: Colors.white30, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF3A402),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.black, size: 30),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
