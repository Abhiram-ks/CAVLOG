import 'package:flutter/material.dart';

class ClipChipMaker {
  static Widget build({
    required String text,
    required Color actionColor, 
    required Color textColor,
    required Color backgroundColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: actionColor,
          hoverColor: actionColor,
          child: Chip(
            label: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor:backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side:  BorderSide(
                style: BorderStyle.solid,
                color: borderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
