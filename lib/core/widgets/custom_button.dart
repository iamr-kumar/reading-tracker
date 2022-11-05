import 'package:flutter/material.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/theme/Pallete.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isOutlined;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.text,
      this.isOutlined = false,
      this.isLoading = false,
      this.isDisabled = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: isOutlined ? Colors.white : Pallete.primaryBlue,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
          foregroundColor: isOutlined ? Pallete.primaryBlue : null,
          elevation: 4,
          side: isOutlined
              ? const BorderSide(color: Pallete.primaryBlue, width: 1.0)
              : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Stack(
        children: [
          Visibility(
            visible: isLoading ? false : true,
            child: Text(text,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600)),
          ),
          Visibility(
              visible: isLoading,
              child: Loader(
                color: isOutlined ? Pallete.primaryBlue : Pallete.white,
              ))
        ],
      ),
    );
  }
}
