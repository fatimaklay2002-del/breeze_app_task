import 'package:equatable/equatable.dart';

class Dimensions extends Equatable {
  final double width;
  final double height;
  final double depth;

  const Dimensions({this.width = 0, this.height = 0, this.depth = 0});

  factory Dimensions.fromJson(Map<String, dynamic>? json) => Dimensions(
        width: (json?['width'] as num?)?.toDouble() ?? 0,
        height: (json?['height'] as num?)?.toDouble() ?? 0,
        depth: (json?['depth'] as num?)?.toDouble() ?? 0,
      );

  String get formatted =>
      '${width.toStringAsFixed(2)} × ${height.toStringAsFixed(2)} × ${depth.toStringAsFixed(2)} cm';

  @override
  List<Object?> get props => [width, height, depth];
}
