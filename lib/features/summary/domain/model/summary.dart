import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary.freezed.dart';
part 'summary.g.dart';

@freezed
class Summary with _$Summary {
  const factory Summary({
    required String id,
    required String text,
    required String bookId,
    required int startPage,
    required int endPage,
    required DateTime createdAt,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);
}
