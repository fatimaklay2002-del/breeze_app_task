import 'package:intl/intl.dart';

String formatPrice(double v) => '\$${v.toStringAsFixed(2)}';

String formatNum(double v) =>
    v == v.roundToDouble() ? v.toInt().toString() : v.toString();

String capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// "mens-shirts" -> "Mens Shirts"
String slugToTitle(String slug) =>
    slug.split('-').where((w) => w.isNotEmpty).map(capitalize).join(' ');

/// April 10, 2026 (empty when the date is missing).
String formatDate(DateTime? date) =>
    date == null ? '' : DateFormat('MMMM d, yyyy').format(date.toLocal());
