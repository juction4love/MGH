import 'package:flutter/material.dart';

class DiningPage extends StatelessWidget {
  const DiningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dining Menu"),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: "FOOD (10)"), Tab(text: "DRINKS (15)")],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(context, [
              {"n": "Thakali Set (Veg)", "p": "450", "d": "Rice, Dal, 5 Curries, Pickle"},
              {"n": "Thakali Set (Chicken)", "p": "650", "d": "With Local Chicken Curry"},
              {"n": "Mutton Thakali", "p": "750", "d": "Premium Goat Meat Set"},
              {"n": "Chicken Momo", "p": "250", "d": "10 pcs Steamed"},
              {"n": "Buff Momo", "p": "220", "d": "10 pcs Fried & Spicy"},
              {"n": "Chicken Chowmein", "p": "200", "d": "Stir-fried Noodles"},
              {"n": "Mixed Thukpa", "p": "220", "d": "Hot Noodle Soup"},
              {"n": "Chicken Sekuwa", "p": "350", "d": "BBQ Stick"},
              {"n": "French Fries", "p": "150", "d": "Crispy Potato"},
              {"n": "Club Sandwich", "p": "300", "d": "Chicken & Cheese"},
            ], Icons.restaurant),
            
            _buildList(context, [
              {"n": "Masala Tea", "p": "50", "d": "Spiced"},
              {"n": "Black Coffee", "p": "80", "d": "Americano"},
              {"n": "Milk Coffee", "p": "100", "d": "Hot"},
              {"n": "Hot Lemon", "p": "60", "d": "With Honey"},
              {"n": "Sweet Lassi", "p": "120", "d": "Yogurt"},
              {"n": "Banana Lassi", "p": "150", "d": "Fruit Blend"},
              {"n": "Coca Cola", "p": "80", "d": "500ml"},
              {"n": "Fanta / Sprite", "p": "80", "d": "500ml"},
              {"n": "Mineral Water", "p": "30", "d": "1 Liter"},
              {"n": "Real Juice", "p": "50", "d": "Mango"},
              {"n": "Gorkha Beer", "p": "550", "d": "Strong 650ml"},
              {"n": "Tuborg Beer", "p": "600", "d": "Premium 650ml"},
              {"n": "Ruslan Vodka", "p": "300", "d": "60ml Shot"},
              {"n": "Old Durbar", "p": "450", "d": "Whiskey 60ml"},
              {"n": "Marpha Brandy", "p": "400", "d": "Local Apple 60ml"},
            ], Icons.local_bar),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Map<String, dynamic>> items, IconData icon) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange.shade50,
              child: Icon(icon, color: Colors.deepOrange),
            ),
            title: Text(item['n'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['d']),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Text("Rs. ${item['p']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ),
            onTap: () {
               ScaffoldMessenger.of(context).hideCurrentSnackBar();
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added ${item['n']} to order"), duration: const Duration(milliseconds: 500)));
            },
          ),
        );
      },
    );
  }
}
