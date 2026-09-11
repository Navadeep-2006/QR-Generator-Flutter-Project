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
      title: 'QR Generator',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Generator - 2b'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'QR Code Generator',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.qr_code_2, size: 40),
                SizedBox(width: 10),
                Text(
                  'Create Your QR',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 30),

            // Stack
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

            Text(
              enteredText.isEmpty
                  ? 'Enter text and generate a QR code'
                  : 'QR generated for: $enteredText',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}