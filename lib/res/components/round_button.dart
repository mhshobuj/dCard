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
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading == true // Explicitly check for true
              ? const CircleAvatar()
              : Text(
                  title,
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
