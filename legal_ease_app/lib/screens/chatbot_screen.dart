import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../widgets/chat_input.dart';
import '../widgets/chat_overlay.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with SingleTickerProviderStateMixin {
  bool _overlayOpen = false;
  bool _isLoading = false;

  // Base URL for FastAPI (override with --dart-define=API_BASE=http://10.0.2.2:8000 on Android emulator)
  static const String apiBase = String.fromEnvironment(
    'API_BASE',
    defaultValue: 'http://127.0.0.1:8000',
  );

  // Start with no initial message
  final List<Map<String, String>> _msgs = [];

  void _toggleOverlay() => setState(() => _overlayOpen = !_overlayOpen);

  Future<void> _send(String text) async {
    // Add user message
    setState(() {
      _msgs.add({
        'id': DateTime.now().toIso8601String(),
        'from': 'user',
        'text': text,
      });
      _isLoading = true;
    });

    try {
      final uri = Uri.parse('$apiBase/query'); // << use /query endpoint
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final reply = (data['response'] ?? 'No response').toString();
        final intent = (data['intent'] ?? '').toString();

        setState(() {
          _msgs.add({
            'id': DateTime.now().toIso8601String(),
            'from': 'bot',
            'text': reply,
          });
          if (intent.isNotEmpty) {
            _msgs.add({
              'id': DateTime.now().toIso8601String(),
              'from': 'bot',
              'text': 'Intent: $intent',
            });
          }
        });
      } else {
        setState(() {
          _msgs.add({
            'id': DateTime.now().toIso8601String(),
            'from': 'bot',
            'text':
                '⚠️ ${response.statusCode}: ${response.reasonPhrase}\n${response.body}',
          });
        });
      }
    } catch (e) {
      setState(() {
        _msgs.add({
          'id': DateTime.now().toIso8601String(),
          'from': 'bot',
          'text': '❌ Connection error: $e',
        });
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // 🔹 Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          'This version of LegalEase can help you with Rwandan law only.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: _toggleOverlay,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // 🔹 Messages list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    itemCount: _msgs.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, i) {
                      if (i == _msgs.length && _isLoading) {
                        // Show loading bubble
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Typing...",
                              style: TextStyle(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        );
                      }

                      final m = _msgs[i];
                      final isBot = m['from'] == 'bot';
                      return Align(
                        alignment: isBot
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isBot ? Colors.white : AppTheme.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            m['text']!,
                            style: TextStyle(
                              color: isBot ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 🔹 Input Field
                ChatInput(onSend: _send),
              ],
            ),

            // 🔹 Overlay for new chat / history / language
            ChatOverlay(open: _overlayOpen, onClose: _toggleOverlay),
          ],
        ),
      ),
    );
  }
}
