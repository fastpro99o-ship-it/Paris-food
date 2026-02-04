import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFF3A402),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "إدارة العملاء",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'JotiOne',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                hintText: "بحث عن عميل...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 15, // Mock data
                separatorBuilder: (c, i) =>
                    const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.2),
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    title: Text(
                      "عميل ${index + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "+212 600 000 00$index",
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${(index * 50) + 100} Points",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.edit, color: Colors.white54),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
