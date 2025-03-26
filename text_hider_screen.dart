import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class TextHiderScreen extends StatefulWidget {
  const TextHiderScreen({super.key});

  @override
  State<TextHiderScreen> createState() => _TextHiderScreenState();
}

class _TextHiderScreenState extends State<TextHiderScreen> {
  final TextEditingController _controller = TextEditingController();
  String _hiddenText = '';

  void _hideText() {
    setState(() {
      _hiddenText = _controller.text.split('').reversed.join();
    });
  }

  void _revealText() {
    setState(() {
      _hiddenText = _hiddenText.split('').reversed.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إخفاء النصوص'),
        backgroundColor: isDarkMode ? const Color(0xFF000000) : Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'أدخل النص',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _hideText,
                      child: const Text('إخفاء النص'),
                    ),
                    ElevatedButton(
                      onPressed: _revealText,
                      child: const Text('كشف النص'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'النص المخفي: $_hiddenText',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}