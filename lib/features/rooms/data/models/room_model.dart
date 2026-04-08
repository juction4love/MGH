enum RoomType { deluxe, standard, family, suite }

class RoomModel {
  final String id;
  final String roomNo;
  final RoomType type;
  final double price;
  final List<String> amenities; // AC, TV, WiFi आदि

  RoomModel({
    required this.id,
    required this.roomNo,
    required this.type,
    required this.price,
    required this.amenities,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id']?.toString() ?? '',
      roomNo: json['roomNo']?.toString() ?? json['roomNumber']?.toString() ?? '',
      type: RoomType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => RoomType.standard,
      ),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNo': roomNo,
      'type': type.name,
      'price': price,
      'amenities': amenities,
    };
  }

  static List<RoomModel> get dummyRooms {
    return [
      RoomModel(
        id: "1",
        roomNo: "101",
        type: RoomType.standard,
        price: 1200.0,
        amenities: ["WiFi", "TV"],
      ),
      RoomModel(
        id: "2",
        roomNo: "202",
        type: RoomType.deluxe,
        price: 2500.0,
        amenities: ["AC", "WiFi", "TV", "Geyser"],
      ),
    ];
  }
}
