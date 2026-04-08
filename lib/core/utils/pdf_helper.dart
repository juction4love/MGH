import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:mgh/features/rooms/data/models/billing_model.dart';

class PdfHelper {
  /// १. PDF बिल तयार गर्ने (Generate Professional Invoice PDF)
  static Future<File> generateInvoice({
    required BillingModel billing,
    required String guestName,
    required String guestPhone,
  }) async {
    final pdf = pw.Document();

    // Map Link (अस्पतालबाट पठाउन सहज होस् भनेर)
    const String mapLink = "https://maps.app.goo.gl/Lykqf979o29mE3P67"; // Placeholder

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header (Professional Branding)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Muktinath Guesthouse", style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.teal)),
                        pw.Text("Bharatpur-7, Chitwan (Near BP Cancer Hospital)", style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                        pw.Text("Contact: +977-9847634444", style: const pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                    pw.Text("INVOICE", style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold, color: PdfColors.grey)),
                  ],
                ),
                pw.Divider(thickness: 2, height: 40),

                // Bill Details
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Bill To:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(guestName, style: const pw.TextStyle(fontSize: 16)),
                        pw.Text(guestPhone),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Invoice ID: ${billing.bookingId}"),
                        pw.Text("Date: ${DateTime.now().toString().split(' ')[0]}"),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),

                // Table Header
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: const pw.BoxDecoration(color: PdfColors.teal900),
                  child: pw.Row(
                    children: [
                      pw.Expanded(child: pw.Text("Description", style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold))),
                      pw.Text("Amount (Rs.)", style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),

                // Table Items
                _invoiceRow("Room Stay Charge", billing.roomCharge.toString()),
                _invoiceRow("Service Charge", billing.serviceCharge.toString()),
                _invoiceRow("Taxes (Govt)", billing.taxAmount.toString()),

                pw.Divider(thickness: 1),

                // Total
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text("Total Amount: ", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Rs. ${billing.totalAmount}", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.teal900)),
                  ],
                ),
                pw.SizedBox(height: 50),

                // Footer (Health Care Context & Emergency)
                pw.Text("Important Notes:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Bullet(text: "We prioritize patient hygiene and care."),
                pw.Bullet(text: "Doctor Recommended diet available in our dining."),
                pw.Bullet(text: "Emergency Help: Call +977-9847634444 (24h)."),
                pw.SizedBox(height: 20),
                pw.Text("Find us on Maps: $mapLink", style: const pw.TextStyle(fontSize: 8, color: PdfColors.blue)),
                
                pw.Spacer(),
                pw.Center(
                  child: pw.Text("Thank you for choosing Muktinath Guesthouse!", style: pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey600)),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save PDF to temp directory
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Invoice_${billing.bookingId}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _invoiceRow(String label, String amount) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(label)),
          pw.Text("Rs. $amount"),
        ],
      ),
    );
  }

  /// २. PDF शेयर गर्ने (Share to WhatsApp or Email)
  static Future<void> shareInvoice(File file, String guestName) async {
    final String message = "Invoice for $guestName stay at Muktinath Guesthouse.";
    await Share.shareXFiles(
      [XFile(file.path)],
      text: message,
      subject: "Room Booking Invoice",
    );
  }
}
