import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  // Brand
  static const primary = Color(0xFF1670E8);   
  static const link = Color(0xFF0058BE);        
  static const primaryLight = Color(0xFFE8F1FD); 
  static const accent = Color(0xFFFB7800);       
  static const purple = Color(0xFF9C48EA);

  static const success = Color(0xFF047857);      
  static const successBg = Color(0xFFECFDF5);
  static const successBorder = Color(0xFFA7F3D0);

  static const discount = accent;
  static const discountBg = Color(0xFFFFF2E5);   

  // Neutrals
  static const background = Color(0xFFF8F9FF);
  static const surface = Colors.white;
  static const subtle = Color(0xFFF1F5F9);       
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF0F172A);
  static const textBody = Color(0xFF334155);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);

  // Splash
  // Splash background gradient (Figma: Linear, stops 0% / 50% / 100%)
  static const splashGradientStart = Color(0xFFD8E2FF);
  static const splashGradientMid = Color(0xFFF0DBFF);
  static const splashGradientEnd = Color(0xFFFFDBC8);

  static const splashTitle = Color(0xFF141B2B);
  static const splashSubtitle = Color(0xFF424754);

  static const star = Color(0xFFF59E0B);
  static const snackbar = Color(0xFF141B2B);
  static const snackbarAction = Color(0xFFB7C8FF);

  // Details screen (from Figma)
  static const chipBg = Color(0xFFE1E8FD);        // rating chip, quantity stepper
  static const moqText = Color(0xFF004395);       // MOQ notice text
  static const warrantyIcon = Color(0xFF994700);  // Warranty icon
  static const shimmerBase = Color(0xFFE9EEF5);
  static const shimmerHighlight = Color(0xFFF8FAFC);
}