import 'dart:ui';
import 'package:flutter/material.dart';

class OrderTypeBottomSheet extends StatefulWidget {
  final VoidCallback onConfirm; // ADDED

  const OrderTypeBottomSheet({super.key, required this.onConfirm}); // UPDATED

  @override
  State<OrderTypeBottomSheet> createState() => _OrderTypeBottomSheetState();
}

class _OrderTypeBottomSheetState extends State<OrderTypeBottomSheet> {
  String? selectedMode;
  int? selectedTable;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                "Finaliser la commande",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'JotiOne',
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildOption('Sur Place', Icons.table_restaurant, 'table'),
                  _buildOption('A Emporter', Icons.shopping_bag, 'takeaway'),
                  _buildOption('Livraison', Icons.delivery_dining, 'delivery'),
                ],
              ),
              const SizedBox(height: 20),
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choisissez votre table :",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          int tableNum = index + 1;
                          bool isSelected = selectedTable == tableNum;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedTable = tableNum),
                            child: Container(
                              width: 50,
                              margin: const EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFF3A402)
                                    : Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 2)
                                    : null,
                              ),
                              child: Text(
                                "$tableNum",
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                crossFadeState: selectedMode == 'table'
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onConfirm(); // CALL CALLBACK
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Commande Envoyée! 🚀",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3A402),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Confirmer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String label, IconData icon, String value) {
    bool isSelected = selectedMode == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = value;
          if (value != 'table') selectedTable = null;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFF3A402)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFFF3A402).withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFF3A402) : Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
