import 'package:equatable/equatable.dart';
import '../../../../core/utils/formatters.dart';

class Review extends Equatable {
  final int rating;
  final String comment;
  final DateTime? date;
  final String reviewerName;
  final String reviewerEmail;

  const Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        comment: json['comment'] as String? ?? '',
        date: DateTime.tryParse(json['date'] as String? ?? ''),
        reviewerName: json['reviewerName'] as String? ?? 'Anonymous',
        reviewerEmail: json['reviewerEmail'] as String? ?? '',
      );

  String get dateLabel => formatDate(date);

  /// "Savannah Gomez" -> "SG" | "Madonna" -> "M" | "" -> "?"
  String get initials {
    final parts = reviewerName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  List<Object?> get props =>
      [rating, comment, date, reviewerName, reviewerEmail];
}
