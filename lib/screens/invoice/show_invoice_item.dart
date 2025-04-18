import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:simpli/models/invoice_model.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class ShowInvoiceItem extends StatelessWidget {
  final Invoice invoice;

  const ShowInvoiceItem({
    super.key,
    required this.invoice,
  });

  Future<void> _printInvoice(BuildContext context) async {
    try {
      await Printing.layoutPdf(
        onLayout: (format) => _generatePdf(format),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to print: $e')),
      );
    }
  }

  Future<void> _downloadInvoice(BuildContext context) async {
    try {
      final pdfBytes = await _generatePdf(PdfPageFormat.a4);
      
      if (kIsWeb) {
        // Web download
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = 'invoice_${invoice.invoiceNumber}.pdf';
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        // Mobile/desktop download
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/invoice_${invoice.invoiceNumber}.pdf');
        await file.writeAsBytes(pdfBytes);
        await OpenFile.open(file.path);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invoice downloaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download: $e')),
      );
    }
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        margin: const pw.EdgeInsets.only(top:50, left:40,right: 20,),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header section
              _buildPdfHeaderSection(),
              pw.SizedBox(height: 20),
              
              // Customer and delivery info
              _buildPdfCustomerInfoSection(),
              
              // Due date info
              _buildPdfDueDateSection(),
              
              // Invoice items table
              _buildPdfInvoiceTable(),
              
              pw.SizedBox(height: 10),
              pw.Text('NB. This Invoice is System Generated', style: const pw.TextStyle(fontSize: 10)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildPdfHeaderSection() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      
      children: [
        pw.SizedBox(height: 20),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'SimpliNetworks',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              // pw.SizedBox(height: 5),
              pw.Text('WaiyakiWay,Westlands,Nairobi.', style: const pw.TextStyle(fontSize: 10)),
              pw.Text('Tel:+254(020)2042414/8000860', style: const pw.TextStyle(fontSize: 10)),
              pw.Text('0737560962/0722324828/0722-319267', style: const pw.TextStyle(fontSize: 10)),
              pw.Text('info@simplinetworks.io', style: const pw.TextStyle(fontSize: 10)),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Profoma Invoice',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.teal,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                width: 250,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 0.5,
                    color: PdfColors.teal,
                  ),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Table(
                  border: pw.TableBorder.symmetric(
                    inside: const pw.BorderSide(
                      width: 0.5,
                      color: PdfColors.teal,
                    ),
                  ),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            'Date',
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.teal,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            'Invoice Number',
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            '8-Jul-2024',
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.teal,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            '#${invoice.invoiceNumber}',
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPdfCustomerInfoSection() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          // margin: const pw.EdgeInsets.only(top: 0, left: 30.0,),
          width: 200,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              width: 0.5,
              color: PdfColors.teal,
            ),
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              'Customer: ${invoice.customerName}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
        pw.SizedBox(width: 165.0),
        pw.Container(
          width: 170,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              width: 0.5,
              color: PdfColors.teal,
            ),
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Column(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('Delivered To', style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('JUJA EASTMART', style: const pw.TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPdfDueDateSection() {
    return pw.Container(
      width: 260,
      margin: const pw.EdgeInsets.only(left:330,),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          width: 0.5,
          color: PdfColors.teal,
        ),
        borderRadius: pw.BorderRadius.circular(5),
      ),
      child: pw.Table(
        border: pw.TableBorder.symmetric(
          inside: const pw.BorderSide(
            width: 0.5,
            color: PdfColors.teal,
          ),
        ),
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('Due Date', style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('LPO No', style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('Terms', style: const pw.TextStyle(fontSize: 10)),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('19/02/2025', style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(' ', style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('14', style: const pw.TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfInvoiceTable() {
    final totalAmount = invoice.amount;
    const totalDiscount = 0.00;
    const totalVat = 0.00;

    return pw.Container(
      // margin: const pw.EdgeInsets.only(top: 0, left: 30.0,),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          width: 0.5,
          color: PdfColors.teal,
        ),
        borderRadius: pw.BorderRadius.circular(5),
      ),
      child: pw.Column(
        children: [
          // Table header
          pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  width: 0.5,
                  color: PdfColors.teal,
                ),
              ),
            ),
            child: pw.Table(
              border: const pw.TableBorder(
                verticalInside: pw.BorderSide(
                  width: 0.5,
                  color: PdfColors.teal,
                ),
              ),
              columnWidths: const {
                0: pw.FlexColumnWidth(1),
                1: pw.FlexColumnWidth(2),
                2: pw.FlexColumnWidth(0.8),
                3: pw.FlexColumnWidth(0.8),
                4: pw.FlexColumnWidth(1),
                5: pw.FlexColumnWidth(1),
                6: pw.FlexColumnWidth(0.8),
                7: pw.FlexColumnWidth(0.8),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Code', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Description', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Units', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Qty', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Unit Price', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Total', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('VAT', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Disc(%)', 
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Table body
          pw.Table(
            border: const pw.TableBorder(
              verticalInside: pw.BorderSide(
                width: 0.5,
                color: PdfColors.teal,
              ),
            ),
            columnWidths: const {
              0: pw.FlexColumnWidth(1),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(0.8),
              3: pw.FlexColumnWidth(0.8),
              4: pw.FlexColumnWidth(1),
              5: pw.FlexColumnWidth(1),
              6: pw.FlexColumnWidth(0.8),
              7: pw.FlexColumnWidth(0.8),
            },
            children: [
              ...invoice.items.map((item) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('N/A', style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(item.description, style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('N/A', style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(item.quantity.toStringAsFixed(0), style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('\$${item.price.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('\$${item.total.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${item.taxRate.toStringAsFixed(2)}%', style: const pw.TextStyle(fontSize: 9)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('0%', style: const pw.TextStyle(fontSize: 9)),
                      ),
                    ],
                  )),
              pw.TableRow(
                children: List.generate(
                  8,
                  (index) => pw.Container(
                    height: 150,
                  ),
                ),
              ),
            ],
          ),

          // Footer
          pw.Container(
            height: 80,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(
                  width: 0.5,
                  color: PdfColors.teal,
                ),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 250,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(
                        width: 0.5,
                        color: PdfColors.teal,
                      ),
                    ),
                  ),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Approved By: ................................', style: const pw.TextStyle(fontSize: 9)),
                        pw.SizedBox(height: 5),
                        pw.Text('Date: ..............................................', style: const pw.TextStyle(fontSize: 9)),
                        pw.SizedBox(height: 5),
                        pw.Text('Signature: ......................................', style: const pw.TextStyle(fontSize: 9)),
                      ],
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    children: [
                      pw.Expanded(
                        child: pw.Row(
                          children: [
                            pw.Container(
                              width: 100,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  right: pw.BorderSide(
                                    width: 0.5,
                                    color: PdfColors.teal,
                                  ),
                                ),
                              ),
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Exclusive Vat', style: const pw.TextStyle(fontSize: 9)),
                                    pw.Text('Total Discount', style: const pw.TextStyle(fontSize: 9)),
                                    pw.Text('Total Vat', style: const pw.TextStyle(fontSize: 9)),
                                  ],
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Container(
                                decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                    right: pw.BorderSide(
                                      width: 0.5,
                                      color: PdfColors.teal,
                                    ),
                                  ),
                                ),
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        '\$${totalAmount.toStringAsFixed(2)}',
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(height: 2),
                                      pw.Text(
                                        '\$0.00',
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(height: 2),
                                      pw.Text(
                                        '\$0.00',
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Container(
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            top: pw.BorderSide(
                              width: 0.5,
                              color: PdfColors.teal,
                            ),
                          ),
                        ),
                        child: pw.Row(
                          children: [
                            pw.Container(
                              width: 100,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  right: pw.BorderSide(
                                    width: 0.5,
                                    color: PdfColors.teal,
                                  ),
                                ),
                              ),
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text('Grand Total', style: const pw.TextStyle(fontSize: 9)),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Container(
                                decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                    right: pw.BorderSide(
                                      width: 0.5,
                                      color: PdfColors.teal,
                                    ),
                                  ),
                                ),
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(
                                    '\$${(totalAmount - totalDiscount - totalVat).toStringAsFixed(2)}',
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                    textAlign: pw.TextAlign.right,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Action buttons (Print and Download)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.print, color: Color(0xFF114F5A)),
                  onPressed: () => _printInvoice(context),
                  tooltip: 'Print Invoice',
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.download, color: Color(0xFF114F5A)),
                  onPressed: () => _downloadInvoice(context),
                  tooltip: 'Download Invoice',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Header section
            _buildHeaderSection(),
            const SizedBox(height: 20),

            // Customer and delivery info
            _buildCustomerInfoSection(),

            // Due date info
            _buildDueDateSection(),

            // Invoice items table
            _buildInvoiceTable(),

            const SizedBox(height: 10),
            const Text('NB. This Invoice is System Generated', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 70.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SimpliNetworks',
                style: TextStyle(fontSize: 24, letterSpacing: 4.0),
              ),
              SizedBox(height: 8),
              Text('WaiyakiWay,Westlands,Nairobi.'),
              Text('Tel:+254(020)2042414/8000860'),
              Text('0737560962/0722324828/0722-319267'),
              Text('info@simplinetworks.io'),
            ],
          ),
        ),
        const SizedBox(width: 40.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 1.0),
                child: Text(
                  'Profoma Invoice',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                    color: Color(0xFF114F5A),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xFF114F5A),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Table(
                        border: const TableBorder.symmetric(
                          inside: BorderSide(
                            width: 1.0,
                            color: Color(0xFF114F5A),
                          ),
                        ),
                        children: [
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Color(0xFF114F5A),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  'Invoice Number',
                                  style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Color(0xFF114F5A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '8-Jul-2024',
                                  style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Color(0xFF114F5A),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '#${invoice.invoiceNumber}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 2,
                                    color: Color(0xFF114F5A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerInfoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF114F5A),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Table(
                    border: const TableBorder.symmetric(
                      outside: BorderSide.none,
                      inside: BorderSide(
                        width: 1.0,
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                    ),
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Customer: ${invoice.customerName}',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 270,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF114F5A),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Table(
                    border: const TableBorder.symmetric(
                      outside: BorderSide.none,
                      inside: BorderSide(
                        width: 1.0,
                        color: Color(0xFF114F5A),
                        style: BorderStyle.solid,
                      ),
                    ),
                    children: const [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text('Delivered To'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text('JUJA EASTMART'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildHeaderSection() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'SimpliNetworks',
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0),
  //             ),
  //             SizedBox(height: 5),
  //             Text('WaiyakiWay,Westlands,Nairobi.', style: TextStyle(fontSize: 12)),
  //             Text('Tel:+254(020)2042414/8000860', style: TextStyle(fontSize: 12)),
  //             Text('0737560962/0722324828/0722-319267', style: TextStyle(fontSize: 12)),
  //             Text('info@simplinetworks.io', style: TextStyle(fontSize: 12)),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             const Text(
  //               'Profoma Invoice',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //                 color: Color(0xFF114F5A),
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Container(
  //               width: 250,
  //               decoration: BoxDecoration(
  //                 border: Border.all(
  //                   width: 1.0,
  //                   color: const Color(0xFF114F5A),
  //                 ),
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Table(
  //                 border: const TableBorder.symmetric(
  //                   inside: BorderSide(
  //                     width: 1.0,
  //                     color: Color(0xFF114F5A),
  //                   ),
  //                 ),
  //                 children: const [
  //                   TableRow(
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: Text(
  //                           'Date',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Color(0xFF114F5A),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: Text(
  //                           'Invoice Number',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Color(0xFF114F5A),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   TableRow(
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: Text(
  //                           '8-Jul-2024',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Color(0xFF114F5A),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: Text(
  //                           '#12345',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Color(0xFF114F5A),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildCustomerInfoSection() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Expanded(
  //         child: Container(
  //           width: 200,
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               width: 1.0,
  //               color: const Color(0xFF114F5A),
  //             ),
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               'Customer: ${invoice.customerName}',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(width: 10),
  //       Expanded(
  //         child: Container(
  //           width: 200,
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               width: 1.0,
  //               color: const Color(0xFF114F5A),
  //             ),
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           child: const Column(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.all(4.0),
  //                 child: Text('Delivered To', style: TextStyle(fontSize: 12)),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.all(4.0),
  //                 child: Text('JUJA EASTMART', style: TextStyle(fontSize: 12)),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildDueDateSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF114F5A),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Table(
                    border: const TableBorder.symmetric(
                      outside: BorderSide.none,
                      inside: BorderSide(
                        width: 1.0,
                        color: Color(0xFF114F5A),
                        style: BorderStyle.solid,
                      ),
                    ),
                    children: const [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text('Due Date'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text('LPO No'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text('Terms'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('19/02/2025'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(' '),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('14'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildDueDateSection() {
  //   return Container(
  //     width: 300,
  //     margin: const EdgeInsets.only(top: 10, bottom: 10),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         width: 1.0,
  //         color: const Color(0xFF114F5A),
  //       ),
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //     child: Table(
  //       border: const TableBorder.symmetric(
  //         inside: BorderSide(
  //           width: 1.0,
  //           color: Color(0xFF114F5A),
  //         ),
  //       ),
  //       children: const [
  //         TableRow(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.all(4.0),
  //               child: Text('Due Date', style: TextStyle(fontSize: 12)),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(4.0),
  //               child: Text('LPO No', style: TextStyle(fontSize: 12)),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(4.0),
  //               child: Text('Terms', style: TextStyle(fontSize: 12)),
  //             ),
  //           ],
  //         ),
  //         TableRow(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.all(4.0),
  //               child: Text('19/02/2025', style: TextStyle(fontSize: 12)),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(4.0),
  //               child: Text(' ', style: TextStyle(fontSize: 12)),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(4.0),
  //               child: Text('14', style: TextStyle(fontSize: 12)),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

   Widget _buildInvoiceTable() {
    final totalAmount = invoice.amount;
    const totalDiscount = 0.00;
    const totalVat = 0.00;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF114F5A),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          children: [
            // Table header
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Color(0xFF114F5A),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Table(
                border: const TableBorder(
                  verticalInside: BorderSide(
                    width: 0.9,
                    color: Color(0xFF114F5A),
                    style: BorderStyle.solid,
                  ),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(3.0),
                  2: FlexColumnWidth(1.0),
                  3: FlexColumnWidth(1.0),
                  4: FlexColumnWidth(1.5),
                  5: FlexColumnWidth(1.5),
                  6: FlexColumnWidth(1.0),
                  7: FlexColumnWidth(1.0),
                },
                children: const [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Code',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Description',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Units',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Qty',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Unit Price',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('VAT',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Disc(%)',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Table body
            Table(
              border: const TableBorder(
                verticalInside: BorderSide(
                  width: 0.7,
                  color: Color(0xFF114F5A),
                  style: BorderStyle.solid,
                ),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(3.0),
                2: FlexColumnWidth(1.0),
                3: FlexColumnWidth(1.0),
                4: FlexColumnWidth(1.5),
                5: FlexColumnWidth(1.5),
                6: FlexColumnWidth(1.0),
                7: FlexColumnWidth(1.0),
              },
              children: [
                ...invoice.items.map((item) => TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('N/A'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.description),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('N/A'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.quantity.toStringAsFixed(0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('\$${item.price.toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('\$${item.total.toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${item.taxRate.toStringAsFixed(2)}%'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('0%'),
                        ),
                      ],
                    )),
                TableRow(
                  children: List.generate(
                    8,
                    (index) => Container(
                      height: 270,
                    ),
                  ),
                ),
              ],
            ),

            // Footer
            Container(
              height: 120,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Color(0xFF114F5A),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 480,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1.0,
                          color: Color(0xFF114F5A),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
                          Text(
                              'Approved By: .......................................................'),
                          SizedBox(height: 11.0),
                          Text(
                              'Date: ....................................................................'),
                          SizedBox(height: 11.0),
                          Text(
                              'Signature: ............................................................'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 174.5,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 1.0,
                                      color: Color(0xFF114F5A),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Exclusive Vat'),
                                      Text('Total Discount'),
                                      Text('Total Vat'),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        width: 1.0,
                                        color: Color(0xFF114F5A),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${totalAmount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          '\$0.00',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          '\$0.00',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: Color(0xFF114F5A),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 174.5,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 1.0,
                                      color: Color(0xFF114F5A),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Grand Total'),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        width: 1.0,
                                        color: Color(0xFF114F5A),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '\$${(totalAmount - totalDiscount - totalVat).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
