import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  Timer? _timer;

  // WAKTU AWAL 
  Duration initialTime = const Duration(
    hours: 0,
    minutes: 0, 
    seconds: 0);

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();

    // langsung set waktu awal
    _stopwatch = Stopwatch()..start();
    _stopwatch.stop();
  }

  void _start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
        setState(() {});
      });
    }
  }

  void _stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      setState(() {});
    }
  }

  void _reset() {
    _stopwatch.reset();
    setState(() {});
  }

  // 🔥 WAKTU = elapsed + initialTime
  Duration get currentTime => initialTime + _stopwatch.elapsed;

  String formatTime() {
    final t = currentTime;

    final h = t.inHours.remainder(24).toString().padLeft(2, '0');
    final m = t.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = t.inSeconds.remainder(60).toString().padLeft(2, '0');
    final ms =
        (t.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');

    return "$h:$m:$s.$ms";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget tombol(String text, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch Modern"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blue],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, size: 60, color: Colors.blue),

                  const SizedBox(height: 20),

                  // ⏱️ DISPLAY WAKTU
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      formatTime(),
                      key: ValueKey(formatTime()),
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tombol(
                        _stopwatch.isRunning ? "Stop" : "Start",
                        _stopwatch.isRunning
                            ? Icons.pause
                            : Icons.play_arrow,
                        _stopwatch.isRunning
                            ? Colors.red
                            : Colors.green,
                        _stopwatch.isRunning ? _stop : _start,
                      ),

                      const SizedBox(width: 15),

                      tombol(
                        "Reset",
                        Icons.refresh,
                        Colors.grey,
                        _reset,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Start dari: ${initialTime.inHours % 24} jam ${initialTime.inMinutes % 60} menit ${initialTime.inSeconds % 60} detik",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}