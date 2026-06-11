import '../../services/pdf_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> generateResultPdf({
    required String testName,
    required String level,
    required int score,
    required String result,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment:
                pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Laporan Hasil Tes VisionMe',
                style: pw.TextStyle(
                  fontSize: 24,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                  'Tes : $testName'),
              pw.Text(
                  'Level : $level'),
              pw.Text(
                  'Skor : $score'),

              pw.SizedBox(height: 20),

              pw.Text(result),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async =>
          pdf.save(),
    );
  }
}