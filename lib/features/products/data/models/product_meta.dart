import 'package:equatable/equatable.dart';

class ProductMeta extends Equatable {
  final String barcode;
  final String? qrCode;

  const ProductMeta({this.barcode = '-', this.qrCode});

  factory ProductMeta.fromJson(Map<String, dynamic>? json) => ProductMeta(
        barcode: json?['barcode'] as String? ?? '-',
        qrCode: json?['qrCode'] as String?,
      );

  @override
  List<Object?> get props => [barcode, qrCode];
}
