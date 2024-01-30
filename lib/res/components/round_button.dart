import 'package:dma_card/res/components/color.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool? loading;
  final VoidCallback onPress;

  const RoundButton({
    super.key,
    required this.title,
    this.loading, // No need for "required" here
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50, // Adjusted height to match TextFields
          width: double.infinity, // Expand to fill available space
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(30), // Match TextField border radius
          ),
          child: Center(
            child: loading == true
                ? const CircleAvatar()
                : Text(
              title,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18, // Adjust font size as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
