import 'package:flutter/material.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: const Center(child: Text('topic', style: TextStyle(color: Colors.black54))),
    );
  }
}
