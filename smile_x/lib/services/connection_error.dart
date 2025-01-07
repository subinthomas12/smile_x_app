import 'package:flutter/material.dart';

class NetworkErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_off, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'No internet connection.',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Optionally, retry the action or navigate back
                Navigator.of(context).pop();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
