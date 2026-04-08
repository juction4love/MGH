import 'dart:convert';

class BillingModel {
  final String bookingId;
  final double roomCharge;
  final double serviceCharge;
  final double taxAmount;
  final double totalAmount;

  BillingModel({
    required this.bookingId,
    required this.roomCharge,
    this.serviceCharge = 0.0,
    this.taxAmount = 0.0,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'roomCharge': roomCharge,
      'serviceCharge': serviceCharge,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
    };
  }

  factory BillingModel.fromMap(Map<String, dynamic> map) {
    return BillingModel(
      bookingId: map['bookingId'] ?? '',
      roomCharge: (map['roomCharge'] as num?)?.toDouble() ?? 0.0,
      serviceCharge: (map['serviceCharge'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['taxAmount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillingModel.fromJson(String source) => BillingModel.fromMap(json.decode(source));
}
