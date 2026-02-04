import 'package:flutter/material.dart';

// Import new screens
import 'dashboard_screen.dart';
import 'pos_screen.dart';
import 'customers_screen.dart';
import 'staff_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

import 'mobile_home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const PosScreen(),
    const CustomersScreen(),
    const StaffScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width is less than 800px, show the Mobile App UI
        if (constraints.maxWidth < 800) {
          return Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.15, -0.6),
                radius: 1.3,
                colors: [Color(0xFF2C2C2C), Color(0xFF101010)],
                stops: [0.0, 1.0],
              ),
            ),
            child: const MobileHomeScreen(),
          );
        }

        // Otherwise show the Desktop POS/Dashboard UI
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.15, -0.6),
                radius: 1.3,
                colors: [Color(0xFF2C2C2C), Color(0xFF101010)],
                stops: [0.0, 1.0],
              ),
            ),
            child: Row(
              children: [
                // SIDEBAR
                _buildSidebar(),

                // MAIN CONTENT
                Expanded(
                  child: IndexedStack(index: selectedIndex, children: _pages),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Logo or Branding Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3A402),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF3A402).withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.restaurant_menu,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 40),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _sidebarItem(Icons.dashboard_rounded, "Dash", 0),
                const SizedBox(height: 20),
                _sidebarItem(Icons.point_of_sale_rounded, "POS", 1),
                const SizedBox(height: 20),
                _sidebarItem(Icons.people_alt_rounded, "Clients", 2),
                const SizedBox(height: 20),
                _sidebarItem(Icons.badge_rounded, "Staff", 3),
                const SizedBox(height: 20),
                _sidebarItem(Icons.bar_chart_rounded, "Reports", 4),
                const Spacer(), // Push Settings to bottom
                _sidebarItem(Icons.settings_rounded, "Settings", 5),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String label, int index) {
    bool isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFF3A402) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFFF3A402).withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              icon,
              size: 26,
              color: isActive ? Colors.white : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? Colors.white : Colors.grey[600],
              fontFamily: 'Poppins',
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
