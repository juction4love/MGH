import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/booking_provider.dart';
import '../data/models/room_model.dart';
import 'payment_page.dart';
import '../../../shared/widgets/powered_by_widget.dart';

class RoomDetailPage extends StatelessWidget {
  final RoomModel room;
  const RoomDetailPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("कोठा नं ${room.roomNo}")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.hotel, size: 100)),
                  const SizedBox(height: 20),
                  Text(room.type.name.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("मूल्य: रू ${room.price} / रात"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                context.read<BookingProvider>().selectRoom(room);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentPage()));
              },
              child: const Text("अगाडि बढ्नुहोस् (Proceed)"),
            ),
          ),
          const PoweredByWidget(),
        ],
      ),
    );
  }
}
