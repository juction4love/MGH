import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mgh/features/dining/data/models/diet_meal_model.dart';
import 'package:mgh/features/rooms/logic/booking_provider.dart';
import 'package:mgh/core/di/service_locator.dart';
import 'package:mgh/core/utils/notification_service.dart';

class DiningPage extends StatelessWidget {
  const DiningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProd = context.read<BookingProvider>();

    // १. बिरामीका लागि स्वस्थ मेनु (Diet Meal Data)
    final List<DietMeal> dietMenu = [
      DietMeal(
        id: "D1", 
        name: "हेल्दी जाउलो (Soft Rice)", 
        description: "नरम, पचाउन सजिलो जाउलो र मुगको दाल। बिरामीका लागि सबैभन्दा उत्तम।", 
        price: 150.0, 
        calories: "320 kcal"
      ),
      DietMeal(
        id: "D2", 
        name: "Mixed Veg Soup", 
        description: "विभिन्न ताजा तरकारी र हल्का प्रोटिनयुक्त सुप। तागत प्रदान गर्न उपयोगी।", 
        price: 120.0, 
        calories: "180 kcal"
      ),
      DietMeal(
        id: "D3", 
        name: "पोषिलो दाल-भात (Patient Set)", 
        description: "कम मसला/तेल भएको घरकै स्वादको शुद्ध साकाहारी खाना।", 
        price: 180.0, 
        calories: "450 kcal"
      ),
      DietMeal(
        id: "D4", 
        name: "Honey Lemon Tea", 
        description: "रुघाखोकी र घाँटीको खकारका लागि लाभदायक ताजा मह र कागती चिया।", 
        price: 60.0, 
        calories: "90 kcal"
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Dining & Medical Diet"),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // २. सूचना ब्यानर (Medical Note)
            _buildDietBanner(),

            const SizedBox(height: 25),

            // ३. मेनु सूची (Menu List Section)
            const Text(
              "बिरामीका लागि स्वस्थ रोजाई (Diet Selection)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
            ),
            const SizedBox(height: 15),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dietMenu.length,
              itemBuilder: (context, index) {
                final meal = dietMenu[index];
                return _buildMealCard(context, meal, bookingProd);
              },
            ),

            const SizedBox(height: 30),
            
            // ४. होटल स्टाफको विशेष अनुरोध
            _buildStaffNote(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDietBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.health_and_safety, color: Colors.green.shade800, size: 35),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "हामी चिकित्सकको सल्लाह अनुसार बिरामीका लागि नरम, कम मसला र तेल भएको स्वस्थ खाना तयार गर्छौं।",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, DietMeal meal, BookingProvider provider) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // खानाको आइकन
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.restaurant_menu, color: Colors.teal, size: 30),
            ),
            const SizedBox(width: 15),
            
            // विवरण
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(meal.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(meal.description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.bolt, color: Colors.orange, size: 14),
                      Text(" ${meal.calories}", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text("Rs. ${meal.price}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // अर्डर बटन
            ElevatedButton(
              onPressed: () {
                // अटोमेटिक बिलमा जोड्ने (Add to Bill)
                if (provider.currentBooking != null) {
                  provider.addOrder(meal.name, meal.price);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("अर्डर प्राप्त भयो! म्यानेजरले छिट्टै सम्पर्क गर्नुहुनेछ।")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("पहिले गेष्ट चेक-इन गर्नुहोस्। (Check-in Required)")),
                  );
                }
                
                // डेमो: खाना तयार भएको नोटिफिकेसन पठाउने (सिमुलेसन)
                Future.delayed(const Duration(seconds: 5), () async {
                  await sl<NotificationService>().showNotification(
                    id: 2,
                    title: "खाना तयार भयो! 🍽️",
                    body: "तपाईँको अर्डर (${meal.name}) तयार छ।",
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(60, 36),
              ),
              child: const Text("Order"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.teal.shade900,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        children: [
          Icon(Icons.volunteer_activism, color: Colors.white, size: 30),
          SizedBox(height: 10),
          Text(
            "केही विशेष आवश्यकता छ?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "यदि तपाईँलाई चिकित्सकले विशेष डाइट चार्ट दिनुभएको छ भने हाम्रो भान्छालाई जानकारी दिनुहोला। हामी तपाईँकै आवश्यकता अनुसार खाना बनाउन सक्छौँ।",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}
