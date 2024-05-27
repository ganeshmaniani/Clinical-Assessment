import 'package:flutter/material.dart';
import '../../home/screen/screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text(
            'Result',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Example'),
          const SizedBox(height: 8),
          const Text('55'),
          const SizedBox(height: 16),
          Button(
              onTap: () {
                Navigator.pop(context);
              },
              text: "Done")
        ],
      ),
    );
  }
}
