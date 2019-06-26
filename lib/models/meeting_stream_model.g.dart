// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingStreamModel _$MeetingStreamModelFromJson(Map<String, dynamic> json) {
  return MeetingStreamModel(
      GlobalEssenceFormatId: json['GlobalEssenceFormatId'] as int,
      IsLive: json['IsLive'] as bool,
      Enabled: json['Enabled'] as bool,
      AudioOnly: json['AudioOnly'] as bool,
      VideoIndex: json['VideoIndex'] as int,
      AudioIndex: json['AudioIndex'] as int,
      StreamFormatId: json['StreamFormatId'] as int,
      Url: json['Url'] as String,
      Lang: json['Lang'] as String,
      StreamAssemblerList: json['StreamAssemblerList'] as List,
      PreRoll: (json['PreRoll'] as num)?.toDouble(),
      Duration: (json['Duration'] as num)?.toDouble(),
      Label: json['Label'] as String,
      Description: json['Description'] as String,
      Id: json['Id'] as int,
      Tag: json['Tag'] as String);
}

Map<String, dynamic> _$MeetingStreamModelToJson(MeetingStreamModel instance) =>
    <String, dynamic>{
      'GlobalEssenceFormatId': instance.GlobalEssenceFormatId,
      'IsLive': instance.IsLive,
      'Enabled': instance.Enabled,
      'AudioOnly': instance.AudioOnly,
      'VideoIndex': instance.VideoIndex,
      'AudioIndex': instance.AudioIndex,
      'StreamFormatId': instance.StreamFormatId,
      'Url': instance.Url,
      'Lang': instance.Lang,
      'StreamAssemblerList': instance.StreamAssemblerList,
      'PreRoll': instance.PreRoll,
      'Duration': instance.Duration,
      'Label': instance.Label,
      'Description': instance.Description,
      'Id': instance.Id,
      'Tag': instance.Tag
    };
