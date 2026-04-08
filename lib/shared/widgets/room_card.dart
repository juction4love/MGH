import 'package:flutter/material.dart';
import 'package:mgh/features/rooms/data/models/room_model.dart';
import 'package:mgh/features/rooms/presentation/room_detail_page.dart';

class RoomCard extends StatelessWidget {
  final RoomModel room;
  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => RoomDetailPage(room: room),
      )), // कोठामा ट्याप गर्दा Detail Page खुल्छ
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Image.asset(
              'assets/images/room.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey[200],
                child: const Icon(Icons.hotel, size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Room No: ${room.roomNo}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("रू ${room.price}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
