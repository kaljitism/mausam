import 'package:flutter/material.dart';

class AdditionalInformationWidget extends StatelessWidget {
  const AdditionalInformationWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
  });

  final IconData icon;
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 32,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
