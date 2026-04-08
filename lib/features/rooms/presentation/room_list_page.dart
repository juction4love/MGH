import 'package:flutter/material.dart';
import 'package:mgh/shared/widgets/room_card.dart';
import '../data/models/room_model.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RoomModel> rooms = RoomModel.dummyRooms;

    return Scaffold(
      appBar: AppBar(
        title: const Text("उपलब्ध कोठाहरू छनौट गर्नुहोस्"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return RoomCard(room: rooms[index]);
        },
      ),
    );
  }
}
