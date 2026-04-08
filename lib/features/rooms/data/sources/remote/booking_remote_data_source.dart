import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mgh/core/constants/api_constants.dart';
import 'package:mgh/features/rooms/data/models/room_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<RoomModel>> fetchAllRooms();
  Future<bool> bookRoom(String roomId, Map<String, dynamic> bookingDetails);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;

  BookingRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RoomModel>> fetchAllRooms() async {
    final response = await client.get(
      Uri.parse("${AppConstants.baseUrl}${AppConstants.bookingEndpoint}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => RoomModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch rooms: ${response.statusCode}');
    }
  }

  @override
  Future<bool> bookRoom(String roomId, Map<String, dynamic> bookingDetails) async {
    final response = await client.post(
      Uri.parse("${AppConstants.baseUrl}${AppConstants.bookingEndpoint}"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'room_id': roomId,
        'booking_date': DateTime.now().toIso8601String(),
        ...bookingDetails,
      }),
    ).timeout(const Duration(seconds: 15));

    return response.statusCode == 201 || response.statusCode == 200;
  }
}
