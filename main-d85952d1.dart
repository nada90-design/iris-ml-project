import 'package:flutter/material.dart';

// Chunk 1: the two screens work, but predict() is a PLACEHOLDER.
// While demoMode is true, the app says clearly that the answer is fake.
// In chunk 2 you will write the real request to Flask, then set this to false.
const bool demoMode = true;

void main() => runApp(const IrisApp());

class IrisApp extends StatelessWidget {
  const IrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Iris Predictor',
      home: InputScreen(),
    );
  }
}

// Screen 1: the user types the 4 measurements.
class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _sepalLength = TextEditingController();
  final _sepalWidth = TextEditingController();
  final _petalLength = TextEditingController();
  final _petalWidth = TextEditingController();

  // Controllers must be released when the screen is closed.
  @override
  void dispose() {
    _sepalLength.dispose();
    _sepalWidth.dispose();
    _petalLength.dispose();
    _petalWidth.dispose();
    super.dispose();
  }

  // Turns the text in a box into a number, or null if it is not a usable number.
  double? _parse(String text) {
    final value = double.tryParse(text.trim());
    if (value == null || !value.isFinite) return null;
    return value;
  }

  // PLACEHOLDER. Chunk 2: replace the body with the real request to Flask
  // (JSON keys: sepal_length, sepal_width, petal_length, petal_width).
  Future<String> predict(Map<String, double> values) async {
    return 'fake-result';
  }

  Future<void> _onPredictPressed() async {
    final values = {
      'sepal_length': _parse(_sepalLength.text),
      'sepal_width': _parse(_sepalWidth.text),
      'petal_length': _parse(_petalLength.text),
      'petal_width': _parse(_petalWidth.text),
    };
    if (values.values.any((v) => v == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter 4 valid numbers')),
      );
      return;
    }
    final result = await predict(
      values.map((key, v) => MapEntry(key, v!)),
    );
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultScreen(result: result)),
    );
  }

  Widget _field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iris Predictor')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (demoMode)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'UI demo: the result is NOT a real model prediction yet.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          _field(_sepalLength, 'Sepal length'),
          _field(_sepalWidth, 'Sepal width'),
          _field(_petalLength, 'Petal length'),
          _field(_petalWidth, 'Petal width'),
          ElevatedButton(
            onPressed: _onPredictPressed,
            child: const Text('Predict'),
          ),
        ],
      ),
    );
  }
}

// Screen 2: shows the answer.
class ResultScreen extends StatelessWidget {
  final String result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (demoMode)
              const Text(
                'UI demo, not a real prediction',
                style: TextStyle(color: Colors.red),
              ),
            Text(
              'Predicted species: $result',
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
