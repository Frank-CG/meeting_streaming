// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return MeetingModel(
      Title: json['Title'] as String,
      IconUri: json['IconUri'] as String,
      EntityStatus: json['EntityStatus'] as int,
      EntityStatusDesc: json['EntityStatusDesc'] as String,
      Location: json['Location'] as String,
      Description: json['Description'] as String,
      ThumbnailUri: json['ThumbnailUri'] as String,
      ScheduledStart: json['ScheduledStart'] == null
          ? null
          : DateTime.parse(json['ScheduledStart'] as String),
      ScheduledEnd: json['ScheduledEnd'] == null
          ? null
          : DateTime.parse(json['ScheduledEnd'] as String),
      HasArchiveStream: json['HasArchiveStream'] as bool,
      ActualStart: json['ActualStart'] == null
          ? null
          : DateTime.parse(json['ActualStart'] as String),
      ActualEnd: json['ActualEnd'] == null
          ? null
          : DateTime.parse(json['ActualEnd'] as String),
      LastModifiedTime: json['LastModifiedTime'] == null
          ? null
          : DateTime.parse(json['LastModifiedTime'] as String),
      CommitteeId: json['CommitteeId'] as String,
      VenueId: json['VenueId'] as String,
      AssemblyProgress: json['AssemblyProgress'] as int,
      AssemblyStatus: json['AssemblyStatus'] as int,
      ForeignKey: json['ForeignKey'] as String,
      Handouts: json['Handouts'] as List,
      Id: json['Id'] as int,
      Tag: json['Tag'] as String);
}

Map<String, dynamic> _$MeetingModelToJson(MeetingModel instance) =>
    <String, dynamic>{
      'Title': instance.Title,
      'IconUri': instance.IconUri,
      'EntityStatus': instance.EntityStatus,
      'EntityStatusDesc': instance.EntityStatusDesc,
      'Location': instance.Location,
      'Description': instance.Description,
      'ThumbnailUri': instance.ThumbnailUri,
      'ScheduledStart': instance.ScheduledStart?.toIso8601String(),
      'ScheduledEnd': instance.ScheduledEnd?.toIso8601String(),
      'HasArchiveStream': instance.HasArchiveStream,
      'ActualStart': instance.ActualStart?.toIso8601String(),
      'ActualEnd': instance.ActualEnd?.toIso8601String(),
      'LastModifiedTime': instance.LastModifiedTime?.toIso8601String(),
      'CommitteeId': instance.CommitteeId,
      'VenueId': instance.VenueId,
      'AssemblyProgress': instance.AssemblyProgress,
      'AssemblyStatus': instance.AssemblyStatus,
      'ForeignKey': instance.ForeignKey,
      'Handouts': instance.Handouts,
      'Id': instance.Id,
      'Tag': instance.Tag
    };
