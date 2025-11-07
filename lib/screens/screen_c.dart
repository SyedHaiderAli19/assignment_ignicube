import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenC extends StatefulWidget {
  const ScreenC({super.key});

  @override
  State<ScreenC> createState() => _ScreenCState();
}

class _ScreenCState extends State<ScreenC> {
  final phraseController = TextEditingController();
  final hashtagsController = TextEditingController();

  bool userManuallyEditedHashtags = false;

  @override
  void initState() {
    super.initState();
    phraseController.addListener(extractHashtags);
    hashtagsController.addListener(() {
      userManuallyEditedHashtags = true;
    });
  }

  @override
  void dispose() {
    phraseController.dispose();
    hashtagsController.dispose();
    super.dispose();
  }

  void extractHashtags() {
    final text = phraseController.text;
    final RegExp exp = RegExp(r'(?:^|\s)(#\w+)');
    final hashtags = exp.allMatches(text).map((e) => e.group(1)!).join(' ');

    if (!userManuallyEditedHashtags) {
      hashtagsController.text = hashtags;
      userManuallyEditedHashtags = false;
    }

    if (text.isEmpty) userManuallyEditedHashtags = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen C"),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: RichText(text: _hashtags(phraseController.text)),
                    ),
                  ),
                ),

                TextField(
                  controller: phraseController,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    height: 1.5,
                  ),
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    labelText: 'Phrase',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextField(
              controller: hashtagsController,
              decoration: const InputDecoration(
                labelText: 'Hashtags',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextButton(
                  onPressed: () {
                    context.go(
                      '/b',
                      extra: {
                        'phrase': phraseController.text,
                        'hashtags': hashtagsController.text,
                      },
                    );
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextSpan _hashtags(String text) {
  final words = text.split(' ');
  return TextSpan(
    children: words.map((word) {
      final isHashtag = word.startsWith('#');
      return TextSpan(
        text: '$word ',
        style: TextStyle(
          color: isHashtag ? Colors.blue : Colors.black,
          fontWeight: isHashtag ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      );
    }).toList(),
  );
}
