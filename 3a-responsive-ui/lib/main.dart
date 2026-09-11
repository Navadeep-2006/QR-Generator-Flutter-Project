import 'package:flutter/material.dart';

void main() {
  runApp(const QRGeneratorApp());
}

class QRGeneratorApp extends StatelessWidget {
  const QRGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Generator - 3a',
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

  String enteredText = '';

  void generateQR() {
    setState(() {
      enteredText = textController.text.trim();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the available screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Change layout based on screen width
    bool isLargeScreen = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Generator - 3a'),
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
                    const SizedBox(width: 40),
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
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Icon(
              Icons.qr_code_2,
              size: 120,
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 250,
          child: Text(
            enteredText.isEmpty
                ? 'Enter text and generate a QR code'
                : 'QR generated for: $enteredText',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}