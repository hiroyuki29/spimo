import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/data/google_books_apis/model/image_links.dart';

part 'volume_info.freezed.dart';
part 'volume_info.g.dart';

@freezed
class VolumeInfo with _$VolumeInfo {
  const factory VolumeInfo({
    required String title,
    List<String>? authors,
    int? pageCount,
    ImageLinks? imageLinks,
  }) = _VolumeInfo;

  factory VolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoFromJson(json);
}
