import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoryStyle {
  final IconData icon;
  final Color color;
  const CategoryStyle(this.icon, this.color);
}

const _indigo = Color(0xFF4F46E5);
const _pink = Color(0xFFDB2777);
const _teal = Color(0xFF0D9488);
const _sky = Color(0xFF0284C7);
const _amber = Color(0xFFD97706);
const _rose = Color(0xFFE11D48);

const _styles = <String, CategoryStyle>{
  'beauty': CategoryStyle(Icons.brush_rounded, AppColors.link),
  'skin-care': CategoryStyle(Icons.spa_rounded, AppColors.success),
  'fragrances': CategoryStyle(Icons.water_drop_rounded, AppColors.accent),
  'groceries': CategoryStyle(Icons.eco_rounded, _teal),
  'furniture': CategoryStyle(Icons.chair_rounded, _amber),
  'home-decoration': CategoryStyle(Icons.home_rounded, _amber),
  'kitchen-accessories': CategoryStyle(Icons.kitchen_rounded, _rose),
  'laptops': CategoryStyle(Icons.laptop_mac_rounded, _sky),
  'smartphones': CategoryStyle(Icons.smartphone_rounded, _indigo),
  'tablets': CategoryStyle(Icons.tablet_mac_rounded, _indigo),
  'mobile-accessories': CategoryStyle(Icons.headphones_rounded, AppColors.purple),
  'mens-shirts': CategoryStyle(Icons.checkroom_rounded, _sky),
  'tops': CategoryStyle(Icons.checkroom_rounded, _pink),
  'womens-dresses': CategoryStyle(Icons.checkroom_rounded, _pink),
  'mens-shoes': CategoryStyle(Icons.directions_walk_rounded, _indigo),
  'womens-shoes': CategoryStyle(Icons.directions_walk_rounded, _pink),
  'mens-watches': CategoryStyle(Icons.watch_rounded, AppColors.link),
  'womens-watches': CategoryStyle(Icons.watch_rounded, AppColors.purple),
  'womens-bags': CategoryStyle(Icons.shopping_bag_rounded, _pink),
  'womens-jewellery': CategoryStyle(Icons.diamond_rounded, AppColors.purple),
  'sunglasses': CategoryStyle(Icons.remove_red_eye_rounded, _teal),
  'sports-accessories': CategoryStyle(Icons.sports_soccer_rounded, AppColors.success),
  'motorcycle': CategoryStyle(Icons.two_wheeler_rounded, _rose),
  'vehicle': CategoryStyle(Icons.directions_car_rounded, _sky),
};

const _fallbackColors = [
  AppColors.link,
  AppColors.success,
  AppColors.accent,
  AppColors.purple,
  _teal,
  _pink,
];


CategoryStyle categoryStyleFor(String slug) =>
    _styles[slug] ??
    CategoryStyle(
      Icons.category_rounded,
      _fallbackColors[slug.hashCode.abs() % _fallbackColors.length],
    );
