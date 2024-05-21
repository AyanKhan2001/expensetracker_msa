import 'package:flutter/material.dart';

class FundCondition extends StatelessWidget {
  final String type;
  final String amount;
  final String icon;

  const FundCondition({
    Key? key,
    required this.type,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.blueGrey,
          ),
        ],
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset("images/$icon.png"),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 22, // Adjust font size as needed
                ),
              ),
              const SizedBox(height: 4), // Adjust spacing between text items
              Padding(
                padding: const EdgeInsets.only(left: 1), // Adjust left padding as needed
                child: Text(
                  "\₹$amount",
                  style: const TextStyle(
                    fontSize: 18, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 14, 16, 41),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class FundConditionExp extends StatelessWidget {
  final String type;
  final String amount;
  final String icon;

  const FundConditionExp({
    Key? key,
    required this.type,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.blueGrey,
          ),
        ],
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset("images/$icon.png"),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22, // Adjust font size as needed
                ),
              ),
              const SizedBox(height: 4), // Adjust spacing between text items
              Padding(
                padding: const EdgeInsets.only(left: 1), // Adjust left padding as needed
                child: Text(
                  "\₹$amount",
                  style: const TextStyle(
                    fontSize: 18, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

