import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfMakerWidget {
  static Future<bool> generateDetails({
    required String barberName,
    required String ventureName,
    required String phoneNumber,
    required String address,
    required String email,
    required String status,
    int? establishedYear,
    String? gender,
  }) async {
    final pdf = pw.Document();
    final imageData = await rootBundle.load('assets/images/applogpng.png');
    final image = pw.MemoryImage(imageData.buffer.asUint8List());

    final orange = PdfColors.orange;
    final lightOrange = PdfColor.fromHex("#FFF3E0");
    final lightGrey = PdfColor.fromHex("#F5F5F5");
    final white = PdfColors.white;

    final dataList = <List<String>>[
      ['Barber Name', barberName],
      ['Venture Name', ventureName],
      ['Phone Number', phoneNumber],
      ['Address', address],
      ['Email', email],
      ['Status', status],
    ];

    if (establishedYear != null) {
      dataList.add(['Established Year', establishedYear.toString()]);
    }
    if (gender != null) {
      dataList.add(['Shop Type', 'Gender : $gender']);
    }

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(20),
          color: lightOrange,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(image, height: 60),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'C A V L O G',
                    style: pw.TextStyle(
                      fontSize: 26,
                      color: orange,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Divider(thickness: 2, color: orange),
              pw.SizedBox(height: 20),
              pw.Text(
                'Venture Details',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(5),
                },
                children: [
                  for (int i = 0; i < dataList.length; i++)
                    pw.TableRow(
                      decoration: pw.BoxDecoration(
                        color: i % 2 == 0 ? white : lightGrey,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            dataList[i][0],
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(dataList[i][1]),
                        ),
                      ],
                    ),
                ],
              ),

              pw.SizedBox(height: 30),

              pw.Text(
                'Team Cavlog',
                style: pw.TextStyle(
                  color: orange,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Innovate | Execute | Succeed',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
              ),
              pw.SizedBox(height: 30),

              pw.Text(
                'Have Questions?',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: orange,
                ),
              ),
              pw.Row(
                children: [
                  pw.Text(
                    'Need help? Contact us at: ',
                    style: pw.TextStyle(color: PdfColors.grey700),
                  ),
                  pw.Text(
                    'cavlogenoia@gmail.com',
                    style: pw.TextStyle(color: PdfColors.blue),
                  ),
                ],
              ),
              pw.Text(
                'and our team will be happy to assist you.',
                style: pw.TextStyle(color: PdfColors.grey700),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/cavlog_details.pdf");
      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);
      return true;
    } catch (e) {
      return false;
    }
  }
}
