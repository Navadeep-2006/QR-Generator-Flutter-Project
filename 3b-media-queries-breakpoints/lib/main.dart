import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const QRGeneratorApp());
}

class QRGeneratorApp extends StatelessWidget {
  const QRGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Generator - 3b',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const QRHomePage(),
    );
  }
}

class QRHomePage extends StatefulWidget {
  const QRHomePage({super.key});

  @override
  State<QRHomePage> createState() => _QRHomePageState();
}

class _QRHomePageState extends State<QRHomePage> {
  final TextEditingController textController = TextEditingController();

  String qrData = '';

  void generateQR() {
    setState(() {
      qrData = textController.text.trim();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery gets the current screen size.
    final double screenWidth = MediaQuery.of(context).size.width;

    // Breakpoint: 600 pixels.
    final bool isLargeScreen = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Generator - 3b'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: isLargeScreen
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInputSection(),
                    const SizedBox(width: 50),
                    buildQRSection(),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildInputSection(),
                    const SizedBox(height: 30),
                    buildQRSection(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildInputSection() {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          const Icon(
            Icons.qr_code_2,
            size: 80,
          ),

          const SizedBox(height: 15),

          const Text(
            'QR Code Generator',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 25),

          TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Enter text or URL',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.edit),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: generateQR,
            child: const Text('Generate QR'),
          ),
        ],
      ),
    );
  }

  Widget buildQRSection() {
    return Column(
      children: [
        Container(
          width: 220,
          height: 220,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: qrData.isEmpty
              ? const Center(
                  child: Text(
                    'QR Code\nwill appear here',
                    textAlign: TextAlign.center,
                  ),
                )
              : QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          width: 250,
          child: Text(
            qrData.isEmpty
                ? 'Enter text or URL and press Generate QR'
                : 'Scan this QR code with your phone',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}