import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../rooms/logic/booking_provider.dart';
import '../data/models/diet_meal_model.dart';

/// १. बिरामीका लागि स्वस्थ मेनु पेज (Diet Menu UI Page)
class DietMenuPage extends StatelessWidget {
  DietMenuPage({super.key});

  // २. मेनु विवरण (Menu Data)
  final List<DietMeal> meals = [
    DietMeal(id: "1", name: "सादा नरम जाउलो", description: "बिरामीका लागि उपयुक्त, कम नुन र तेल भएको।", price: 150, calories: "200 kcal"),
    DietMeal(id: "2", name: "मुगीको दाल र सुप", description: "प्रोटिनयुक्त र पचाउन सजिलो सुप।", price: 120, calories: "150 kcal"),
    DietMeal(id: "3", name: "उसिनेको सागसब्जी", description: "भिटामिनले भरिपूर्ण, चिल्लो रहित।", price: 180, calories: "100 kcal"),
    DietMeal(id: "4", name: "ताजा फलफूलको रस", description: "बिना चिनीको ताजा मौसमी फलफूलको रस।", price: 100, calories: "80 kcal"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Healthy Diet Menu", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // ३. सूचना बक्स (Health Info Box)
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.green[50],
            child: const Row(
              children: [
                Icon(Icons.health_and_safety, color: Colors.green, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "यो मेनु विशेषगरी सोही क्यान्सर अस्पतालका बिरामीहरूको स्वास्थ्यलाई ध्यानमा राखेर बनाइएको हो।",
                    style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          
          // ४. मेनु लिस्ट (Scrollable Menu List)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // खानाको मुख्य विवरण
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(meal.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(meal.description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.flash_on, color: Colors.orange, size: 14),
                                  Text(" ऊर्जा: ${meal.calories}", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // मूल्य र अर्डर बटन
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Rs. ${meal.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2E7D32))),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                onPressed: () {
                                  // ५. अर्डर थप्ने र अटोमेटिक बिल अपडेट गर्ने (Order Action)
                                  context.read<BookingProvider>().addOrder(meal.name, meal.price);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${meal.name} अर्डर गरियो। बिल अपडेट भयो!"),
                                      backgroundColor: Colors.green[800],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                ),
                                child: const Text("अर्डर (Add)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
