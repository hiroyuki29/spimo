import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_info.freezed.dart';
part 'volume_info.g.dart';

@freezed
class VolumeInfo with _$VolumeInfo {
  const factory VolumeInfo({
    required String title,
    required List<String?> authors,
  }) = _VolumeInfo;

  factory VolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoFromJson(json);
}
