import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  
  // ROOM TYPES & PRICES
  String _selectedRoomType = "Deluxe";
  final Map<String, double> _roomRates = {
    "Normal": 1000.0,
    "Deluxe": 2000.0,
    "Super Deluxe (AC)": 3500.0,
  };

  DateTime _selectedDate = DateTime.now();
  int _days = 1;
  int _guests = 2;
  final String _frontDeskNumber = "9847634444";

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (!await launchUrl(launchUri)) throw 'Could not launch call';
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double roomPrice = _roomRates[_selectedRoomType]!;
    double totalCost = _days * roomPrice;

    return Scaffold(
      appBar: AppBar(title: const Text("Book Your Stay")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- ROOM SELECTION CARD ---
              Card(
                elevation: 4,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Select Room Category", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: _selectedRoomType,
                        decoration: const InputDecoration(border: InputBorder.none),
                        isExpanded: true,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        items: _roomRates.keys.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(type),
                                Text("Rs. ${_roomRates[type]!.toStringAsFixed(0)}", 
                                  style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() { _selectedRoomType = newValue!; });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- DATE PICKER ---
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Check-in Date", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}", 
                  style: const TextStyle(fontSize: 16, color: Colors.black87)),
                trailing: const Icon(Icons.calendar_month, color: Colors.deepOrange),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  );
                  if (picked != null) setState(() { _selectedDate = picked; });
                },
              ),
              const Divider(),
              
              // --- GUEST DETAILS FORM ---
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Guest Name", 
                  border: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.person)
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number", 
                  border: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.phone)
                ),
                validator: (v) => v!.length < 10 ? "Invalid Number" : null,
              ),
              
              const SizedBox(height: 25),
              
              // --- COUNTERS (NIGHTS & GUESTS) ---
              Row(
                children: [
                  Expanded(child: _buildCounter("Nights", _days, (val) => setState(() => _days = val))),
                  const SizedBox(width: 15),
                  Expanded(child: _buildCounter("Guests", _guests, (val) => setState(() => _guests = val))),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // --- TOTAL BILL ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Estimate:", style: TextStyle(fontSize: 16)),
                    Text("Rs. ${totalCost.toStringAsFixed(0)}", 
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // --- ACTION BUTTONS ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Confirm Booking"),
                          content: Text(
                            "Room: $_selectedRoomType\n"
                            "Duration: $_days Night(s)\n"
                            "Total: Rs. ${totalCost.toStringAsFixed(0)}\n\n"
                            "Call Front Desk to confirm?"
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
                            FilledButton.icon(
                              onPressed: () {
                                Navigator.pop(ctx);
                                _makePhoneCall(_frontDeskNumber);
                              },
                              icon: const Icon(Icons.call),
                              label: const Text("Call Now"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("BOOK NOW", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(onTap: () => value > 1 ? onChanged(value - 1) : null, child: const Icon(Icons.remove_circle_outline)),
              Text("$value", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              InkWell(onTap: () => onChanged(value + 1), child: const Icon(Icons.add_circle_outline)),
            ],
          ),
        ],
      ),
    );
  }
}
