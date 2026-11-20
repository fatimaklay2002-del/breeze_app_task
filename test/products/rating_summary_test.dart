import 'package:breeze/features/products/data/models/rating_summary.dart';
import 'package:breeze/features/products/data/models/review.dart';
import 'package:flutter_test/flutter_test.dart';

Review r(int stars) => Review(
      rating: stars,
      comment: '',
      date: null,
      reviewerName: 'A B',
      reviewerEmail: '',
    );

void main() {
  test('average and distribution come from the reviews array', () {
    final s = RatingSummary.fromReviews([r(5), r(5), r(4), r(1)]);
    expect(s.total, 4);
    expect(s.average, closeTo(3.75, 0.0001));
    expect(s.averageLabel, '3.8');
    expect(s.bars.map((b) => b.stars), [5, 4, 3, 2, 1]);
    expect(s.bars.map((b) => b.count), [2, 1, 0, 0, 1]);
    expect(s.bars.first.percent, 50);
    expect(s.bars.first.label, '2 (50%)');
  });

  test('no reviews -> zeros, no division by zero', () {
    final s = RatingSummary.fromReviews(const []);
    expect(s.average, 0);
    expect(s.bars.every((b) => b.count == 0 && b.percent == 0), isTrue);
  });

  test('reviewer initials', () {
    expect(r(5).initials, 'AB');
  });
}
