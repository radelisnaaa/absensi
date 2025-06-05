import 'package:absen/core/constants/colors.dart';
import 'package:flutter/material.dart';

enum ButtonStyleType { filled, outlined }

class Button extends StatelessWidget {
  final String label;
  final double? width;
  final double height;
  final double borderRadius;
  final Function() onPressed;
  final Widget? icon;
  final Color backgroundColor;
  final Color textColor;
  final bool disable;
  final double fontSize;
  final bool isLoading;

  const Button({
    super.key,
    required this.label,
    this.width = double.infinity,
    this.height = 60,
    this.borderRadius = 16,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.icon,
    this.disable = false,
    this.fontSize = 18,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),        child: isLoading 
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}