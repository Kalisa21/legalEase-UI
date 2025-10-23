import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatOverlay extends StatelessWidget {
  final bool open;
  final VoidCallback onClose;
  const ChatOverlay({super.key, required this.open, required this.onClose});

  @override
  Widget build(BuildContext context) {
    if (!open) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onClose,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: open ? 1.0 : 0.0,
        child: Container(
          color: Colors.black54,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('New Chat', style: TextStyle(fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: onClose)]),
                  const SizedBox(height: 8),
                  const Text('Languages', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(children: const [Text('En 🇬🇧'), SizedBox(width: 12), Text('Rw 🇷🇼'), SizedBox(width: 12), Text('Fr 🇫🇷')]),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('History', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('An example history'),
                  const Text('An example history'),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
