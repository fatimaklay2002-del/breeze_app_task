import 'review.dart';

/// One row of the star distribution (5★ ... 1★).
class RatingBar {
  final int stars;
  final int count;
  final double percent;
  const RatingBar(this.stars, this.count, this.percent);

  double get fraction => percent / 100;
  String get label => '$count (${percent.round()}%)';
}

/// Average + distribution, computed from the reviews array only.
class RatingSummary {
  final double average;
  final int total;
  final List<RatingBar> bars;
  const RatingSummary(this.average, this.total, this.bars);

  factory RatingSummary.fromReviews(List<Review> reviews) {
    final total = reviews.length;
    final counts = {for (var s = 5; s >= 1; s--) s: 0};
    for (final r in reviews) {
      if (counts.containsKey(r.rating)) counts[r.rating] = counts[r.rating]! + 1;
    }
    final sum = reviews.fold<int>(0, (a, r) => a + r.rating);
    return RatingSummary(
      total == 0 ? 0 : sum / total,
      total,
      [
        for (final e in counts.entries)
          RatingBar(e.key, e.value, total == 0 ? 0 : e.value / total * 100),
      ],
    );
  }

  String get averageLabel => average.toStringAsFixed(1);
  int get filledStars => average.round();
}
