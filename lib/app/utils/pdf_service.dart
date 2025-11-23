import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class PdfService {
  static Future<File> generatePDF({
    required Uint8List imageData,
    required String prompt,
    required String fileName,
  }) async {
    // Create PDF document
    final pdf = pw.Document();

    // Decode image to get dimensions
    final image = img.decodeImage(imageData);

    // Add page to PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              // Title
              pw.Header(
                level: 0,
                child: pw.Text(
                  'Generated Image',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 20),

              // Prompt section
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Prompt:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(prompt, style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Image
              pw.Center(
                child: pw.Container(
                  constraints: pw.BoxConstraints(maxWidth: 400, maxHeight: 400),
                  child: pw.Image(
                    pw.MemoryImage(imageData),
                    fit: pw.BoxFit.contain,
                  ),
                ),
              ),

              pw.SizedBox(height: 20),

              // Metadata
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Generated on: ${DateTime.now().toString().split(' ')[0]}',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                    pw.Text(
                      'Size: ${image?.width ?? 0} x ${image?.height ?? 0}',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.pdf');

    // Save PDF
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static Future<String?> saveAndSharePDF({
    required Uint8List imageData,
    required String prompt,
    required String fileName,
  }) async {
    try {
      // Generate PDF file
      final pdfFile = await generatePDF(
        imageData: imageData,
        prompt: prompt,
        fileName: fileName,
      );

      return pdfFile.path;
    } catch (e) {
      print('Error saving PDF: $e');
      return null;
    }
  }

  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    } else if (Platform.isIOS) {
      // On iOS, you might need to request photos permission
      // or just use the app's documents directory which doesn't require permission
      return true;
    }
    return true;
  }
}

class PdfDownloadService {
  static Future<pw.Document> createPDFDocument({
    required Uint8List imageData,
    required String prompt,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'AI Generated Image',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Prompt:',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Text(prompt, style: pw.TextStyle(fontSize: 14)),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Container(
                  constraints: pw.BoxConstraints(maxWidth: 350, maxHeight: 350),
                  child: pw.Image(
                    pw.MemoryImage(imageData),
                    fit: pw.BoxFit.contain,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Text(
                  'Generated on: ${DateTime.now().toString().split(' ')[0]}',
                  style: pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  static Future<void> sharePDF({
    required Uint8List imageData,
    required String prompt,
  }) async {
    try {
      final pdf = await createPDFDocument(imageData: imageData, prompt: prompt);

      // Share the PDF directly
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            'generated-image-${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
    } catch (e) {
      print('Error sharing PDF: $e');
      rethrow;
    }
  }

  static Future<String?> savePDFToDevice({
    required Uint8List imageData,
    required String prompt,
  }) async {
    try {
      // Request permissions for Android
      if (Platform.isAndroid) {
        final status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
      }

      final pdf = await createPDFDocument(imageData: imageData, prompt: prompt);

      // Get documents directory
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/generated_image_$timestamp.pdf');

      await file.writeAsBytes(await pdf.save());

      return file.path;
    } catch (e) {
      print('Error saving PDF: $e');
      return null;
    }
  }

  static Future<void> printPDF({
    required Uint8List imageData,
    required String prompt,
  }) async {
    try {
      final pdf = await createPDFDocument(imageData: imageData, prompt: prompt);

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      print('Error printing PDF: $e');
      rethrow;
    }
  }
}
