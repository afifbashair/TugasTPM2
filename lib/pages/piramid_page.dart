import 'package:flutter/material.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({Key? key}) : super(key: key);

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _alasPanjangController = TextEditingController();
  final TextEditingController _alasLebarController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  final TextEditingController _miringTinggiController = TextEditingController();

  double? _luas;
  double? _volume;

  void _calculate() {
    final double? alasPanjang = double.tryParse(_alasPanjangController.text);
    final double? alasLebar = double.tryParse(_alasLebarController.text);
    final double? tinggi = double.tryParse(_tinggiController.text);
    final double? miringTinggi = double.tryParse(_miringTinggiController.text);

    if (alasPanjang == null ||
        alasLebar == null ||
        tinggi == null ||
        miringTinggi == null) {
      setState(() {
        _luas = null;
        _volume = null;
      });
      return;
    }

    // Luas permukaan piramid segi empat:
    // luas = alas Area + Lateral Area
    // alas Area = alasPanjang * alasLebar
    // Lateral Area = (alasPanjang + alasLebar) * miringTinggi / 2
    final double alasArea = alasPanjang * alasLebar;
    final double lateralArea = (alasPanjang + alasLebar) * miringTinggi / 2;
    final double luas = alasArea + lateralArea;

    // Volume piramid:
    // Volume = (1/3) * alasArea * tinggi
    final double volume = (1 / 3) * alasArea * tinggi;

    setState(() {
      _luas = luas;
      _volume = volume;
    });
  }

  @override
  void dispose() {
    _alasPanjangController.dispose();
    _alasLebarController.dispose();
    _tinggiController.dispose();
    _miringTinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luas dan Volume Piramid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Masukkan dimensi piramid segi empat:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alasPanjangController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Panjang alas (alas Panjang)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _alasLebarController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Lebar alas (alas Lebar)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tinggiController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Tinggi piramid (tinggi)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _miringTinggiController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Tinggi sisi miring (slant tinggi)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Hitung Luas dan Volume'),
            ),
            const SizedBox(height: 20),
            if (_luas != null && _volume != null) ...[
              Text(
                'Luas Permukaan: ${_luas!.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Volume: ${_volume!.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ] else
              const Text(
                'Masukkan semua nilai dengan benar untuk menghitung.',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}