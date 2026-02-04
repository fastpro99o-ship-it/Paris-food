import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "الإعدادات",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'JotiOne',
            ),
          ),
          const SizedBox(height: 30),
          _sectionTitle("عام"),
          _settingTile(Icons.language, "اللغة", "العربية"),
          _settingTile(Icons.dark_mode, "المظهر", "Dark Mode"),

          const SizedBox(height: 20),
          _sectionTitle("النظام"),
          _settingTile(Icons.print, "إعدادات الطابعة", "Epson TM-T20"),
          _settingTile(Icons.cloud_upload, "النسخ الاحتياطي", "Google Drive"),

          const SizedBox(height: 20),
          _sectionTitle("المنتجات"),
          _settingTile(
            Icons.fastfood,
            "إدارة القائمة",
            "تعديل الأصناف والأسعار",
          ),
          _settingTile(Icons.category, "التصنيفات", "إضافة/حذف"),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFF3A402),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _settingTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white30)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white24,
          size: 16,
        ),
        onTap: () {},
      ),
    );
  }
}
