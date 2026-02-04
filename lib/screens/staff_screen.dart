import 'package:flutter/material.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "طاقم العمل",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'JotiOne',
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1.2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final roles = [
                  'Manager',
                  'Cashier',
                  'Chef',
                  'Waiter',
                  'Cleaner',
                  'Guard',
                ];
                final names = [
                  'Ahmed',
                  'Sami',
                  'Karim',
                  'Sara',
                  'Mona',
                  'Omar',
                ];

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=11',
                        ), // Placeholder
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        names[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        roles[index],
                        style: const TextStyle(color: Color(0xFFF3A402)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: index < 3 ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          index < 3 ? "Clocked In" : "Clocked Out",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
