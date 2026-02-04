import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';
import '../models/cart_item.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  String? selectedCategory;
  List<CartItem> currentOrder = [];

  final List<String> categories = [
    'BURGER',
    'SANDWICH',
    'PIZZA',
    'TACOS',
    'PATES',
    'SALADES',
    'BOISSONS',
    'DESSERTS',
  ];

  // Mock Products Database
  final Map<String, List<Map<String, dynamic>>> productData = {
    'BURGER': [
      {'name': 'Cheese Burger', 'price': 35.0},
      {'name': 'Classic Burger', 'price': 30.0},
      {'name': 'Chicken Burger', 'price': 35.0},
      {'name': 'Double Burger', 'price': 55.0},
      {'name': 'Fish Burger', 'price': 40.0},
      {'name': 'Veggie Burger', 'price': 30.0},
    ],
    'PIZZA': [
      {'name': 'Margherita', 'price': 40.0},
      {'name': 'Pepperoni', 'price': 55.0},
      {'name': 'Vegetarian', 'price': 45.0},
      {'name': 'Four Cheese', 'price': 60.0},
    ],
    'BOISSONS': [
      {'name': 'Coca Cola', 'price': 15.0},
      {'name': 'Fanta', 'price': 15.0},
      {'name': 'Water', 'price': 10.0},
      {'name': 'Orange Juice', 'price': 25.0},
    ],
    'TACOS': [
      {'name': 'Tacos Mixte', 'price': 45.0},
      {'name': 'Tacos Poulet', 'price': 35.0},
      {'name': 'Tacos Viande Hachée', 'price': 40.0},
    ],
    'SANDWICH': [
      {'name': 'Bocadillo', 'price': 25.0},
      {'name': 'Sandwich Mixte', 'price': 30.0},
      {'name': 'Panini Poulet', 'price': 25.0},
    ],
  };

  void _addToOrder(String title, double price, String cat) {
    setState(() {
      final existingIndex = currentOrder.indexWhere(
        (item) => item.title == title,
      );
      if (existingIndex >= 0) {
        currentOrder[existingIndex] = CartItem(
          title: title,
          imagePath: currentOrder[existingIndex].imagePath,
          price: price,
          quantity: currentOrder[existingIndex].quantity + 1,
          isSpicy: currentOrder[existingIndex].isSpicy,
        );
      } else {
        currentOrder.add(
          CartItem(
            title: title,
            imagePath: _getImageForCategory(cat),
            price: price,
            quantity: 1,
            isSpicy: false,
          ),
        );
      }
    });
  }

  void _removeFromOrder(int index) {
    setState(() {
      currentOrder.removeAt(index);
    });
  }

  void _clearOrder() {
    setState(() {
      currentOrder.clear();
    });
  }

  String _getImageForCategory(String cat) {
    switch (cat) {
      case 'BURGER':
        return 'assets/burger.png';
      case 'PIZZA':
        return 'assets/pizza.png';
      case 'TACOS':
        return 'assets/Tacos.png';
      case 'SANDWICH':
        return 'assets/sandwich.png';
      case 'SALADES':
        return 'assets/salad.png';
      default:
        return 'assets/burger.png';
    }
  }

  void _showPaymentDialog() {
    if (currentOrder.isEmpty) return;

    final double totalAmount = currentOrder.fold(0.0, (s, i) => s + i.total);
    double tenderedAmount = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            double change = tenderedAmount > 0
                ? tenderedAmount - totalAmount
                : 0.0;
            return AlertDialog(
              backgroundColor: const Color(0xFF2C2C2C),
              title: const Text(
                'الدفع',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "المجموع: ${totalAmount.toStringAsFixed(2)} DH",
                      style: const TextStyle(
                        color: Color(0xFFF3A402),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "طريقة الدفع",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _paymentMethodBtn("Cash", Icons.money, true),
                        _paymentMethodBtn("Card", Icons.credit_card, false),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'المبلغ المستلم',
                        labelStyle: TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF3A402)),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setDialogState(() {
                          tenderedAmount = double.tryParse(val) ?? 0.0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    if (tenderedAmount > 0)
                      Text(
                        change >= 0
                            ? "الباقي: ${change.toStringAsFixed(2)} DH"
                            : "مبلغ غير كاف!",
                        style: TextStyle(
                          color: change >= 0
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "إلغاء",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (tenderedAmount >= totalAmount ||
                        tenderedAmount == 0.0) {
                      // Allow 0 for card or trust
                      _processSuccess();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3A402),
                  ),
                  child: const Text(
                    "تأكيد وطباعة",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _processSuccess() async {
    // 1. Create Order Model
    final order = OrderModel(
      id: '', // Supabase will generate this or we can use ID.unique() if we had it
      items: List.from(currentOrder),
      total: currentOrder.fold(0.0, (s, i) => s + i.total),
      timestamp: DateTime.now(),
      tableNumber: "POS-Desktop", // Identification for orders from POS
      status: 'paid', // POS orders are usually paid immediately
    );

    // 2. Save to Supabase
    try {
      await OrderService().createOrder(order);
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("تم بنجاح! 🎉"),
            content: const Text("تم تسجيل الطلب والدفع."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("موافق"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("خطأ في الاتصال ❌"),
            content: Text("التفاصيل: $e"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("موافق"),
              ),
            ],
          ),
        );
      }
    }

    // 3. Clear UI
    _clearOrder();
  }

  Widget _paymentMethodBtn(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF3A402) : Colors.white10,
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? null : Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Icon(icon, color: isSelected ? Colors.black : Colors.white),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // LEFT: Selection Area
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header / Back Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    if (selectedCategory != null)
                      IconButton(
                        onPressed: () =>
                            setState(() => selectedCategory = null),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFF3A402),
                        ),
                      ),
                    Text(
                      selectedCategory ?? "الأصناف الرئيسية",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'JotiOne',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Grid Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: selectedCategory == null
                        ? categories.length
                        : (productData[selectedCategory]?.length ?? 6),
                    itemBuilder: (context, index) {
                      if (selectedCategory == null) {
                        // Category Grid
                        final catName = categories[index];
                        return MenuCard(
                          title: catName,
                          imagePath: _getImageForCategory(catName),
                          accentColor: const Color(0xFFF3A402),
                          onTap: () =>
                              setState(() => selectedCategory = catName),
                        );
                      } else {
                        // Product Grid
                        final items = productData[selectedCategory];
                        final name = items != null && index < items.length
                            ? items[index]['name']
                            : "$selectedCategory #$index";
                        final price = items != null && index < items.length
                            ? items[index]['price'] as double
                            : 30.0;

                        return MenuCard(
                          title: name,
                          imagePath: _getImageForCategory(selectedCategory!),
                          accentColor: const Color(0xFFF3A402),
                          onTap: () =>
                              _addToOrder(name, price, selectedCategory!),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // RIGHT: Cart / Ticket
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "الطلب الحالي",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _clearOrder,
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Colors.redAccent,
                        ),
                        tooltip: "مسح الكل",
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white10),

                // Cart List
                Expanded(
                  child: ListView.separated(
                    itemCount: currentOrder.length,
                    separatorBuilder: (c, i) =>
                        const Divider(color: Colors.white10, height: 1),
                    itemBuilder: (context, index) {
                      final item = currentOrder[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          "${item.quantity} x ${item.price} DH",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${item.total.toStringAsFixed(0)} DH",
                              style: const TextStyle(
                                color: Color(0xFFF3A402),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => _removeFromOrder(index),
                              child: const Icon(
                                Icons.close,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Calculations
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "الضريبة (0%)",
                            style: TextStyle(color: Colors.white54),
                          ),
                          const Text(
                            "0.00 DH",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "المجموع الكلي",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${currentOrder.fold(0.0, (s, i) => s + i.total).toStringAsFixed(2)} DH",
                            style: const TextStyle(
                              color: Color(0xFFF3A402), // Gold
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showPaymentDialog,
                          icon: const Icon(
                            Icons.payments_outlined,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "دفع الآن",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3A402), // Gold
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
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
      ],
    );
  }
}
