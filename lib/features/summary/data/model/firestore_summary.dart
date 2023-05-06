import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/summary/domain/model/summary.dart';
import 'package:spimo/util/converter/timestamp_to_datetime_converter.dart';

part 'firestore_summary.freezed.dart';
part 'firestore_summary.g.dart';

@freezed
class FirestoreSummary with _$FirestoreSummary {
  const FirestoreSummary._();

  const factory FirestoreSummary({
    required String id,
    required String text,
    required String bookId,
    required int startPage,
    required int endPage,
    @TimestampToDatetimeConverter() required DateTime createdAt,
  }) = _FirestoreSummary;

  factory FirestoreSummary.fromJson(Map<String, dynamic> json) =>
      _$FirestoreSummaryFromJson(json);

  Summary transferToSummary() {
    return Summary(
      id: id,
      text: text,
      bookId: bookId,
      startPage: startPage,
      endPage: endPage,
      createdAt: createdAt,
    );
  }
}
