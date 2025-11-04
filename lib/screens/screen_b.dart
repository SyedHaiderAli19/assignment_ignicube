import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenB extends StatefulWidget {
  final Map<String, dynamic>? params;
  const ScreenB({super.key, this.params});

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  @override
  Widget build(BuildContext context) {
    final String phrase = widget.params?['phrase'] ?? '';
    final String hashtags = widget.params?['hashtags'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen B"),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Go to Screen C'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (phrase.isNotEmpty || hashtags.isNotEmpty) ...[
                RichText(text: _hashtags(phrase)),
                const SizedBox(height: 16),
                RichText(text: _hashtags(hashtags)),
              ],
              const Spacer(),
              // if (phrase.isNotEmpty || hashtags.isNotEmpty)
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      context.go('/');
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Congratulations!'),
                            content: const Text("Task Completed"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    child: const Text('Done'),
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

TextSpan _hashtags(String text) {
  final words = text.split('');
  return TextSpan(
    children: words.map((word) {
      final isHashtag = word.startsWith('#');
      return TextSpan(
        text: word,
        style: TextStyle(
          color: isHashtag ? Colors.blue : Colors.black,
          fontWeight: isHashtag ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      );
    }).toList(),
  );
}
