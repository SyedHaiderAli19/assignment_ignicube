import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen A'),
        backgroundColor: Colors.white,
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Go to Screen B'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
