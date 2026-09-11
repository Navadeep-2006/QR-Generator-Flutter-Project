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
      title: 'QR Generator - Experiment 4',
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

  void openQRDetails() {
    if (qrData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generate a QR code first'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRDetailsPage(qrData: qrData),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Generator - Experiment 4'),
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

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: openQRDetails,
            child: const Text('View QR Details'),
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

// Second screen
class QRDetailsPage extends StatelessWidget {
  final String qrData;

  const QRDetailsPage({
    super.key,
    required this.qrData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Generated QR Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 250,
                backgroundColor: Colors.white,
              ),

              const SizedBox(height: 20),

              Text(
                qrData,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}