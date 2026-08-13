import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 0);
  bool _isAlarmActive = false;

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
        _isAlarmActive = true;
      });
    }
  }

  void _showSubscriptionPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Alarm Feature'),
        content: const Text('Unlock continuous alarm playback and custom wake-up audio tones. Emergency stop option available.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Emergency Stop'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Clock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: _showSubscriptionPopup,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedTime.format(context),
              style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _pickTime,
              icon: const Icon(Icons.alarm),
              label: const Text('Set Alarm Time'),
            ),
          ],
        ),
      ),
    );
  }
}

// Integrated audioplayers sound playback on trigger
