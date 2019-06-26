import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

/// Code generation command: [flutter pub run build_runner build --delete-conflicting-outputs]
part 'meeting_model.g.dart';

@JsonSerializable()
class MeetingModel extends Equatable {
  final String Title;
  final String IconUri;
  final int EntityStatus;
  final String EntityStatusDesc;
  final String Location;
  final String Description;
  final String ThumbnailUri;
  final DateTime ScheduledStart;
  final DateTime ScheduledEnd;
  final bool HasArchiveStream;
  final DateTime ActualStart;
  final DateTime ActualEnd;
  final DateTime LastModifiedTime;
  final String CommitteeId;
  final String VenueId;
  final int AssemblyProgress;
  final int AssemblyStatus;
  final String ForeignKey;
  final List Handouts;
  final int Id;
  final String Tag;

  MeetingModel(
      {this.Title,
      this.IconUri,
      this.EntityStatus,
      this.EntityStatusDesc,
      this.Location,
      this.Description,
      this.ThumbnailUri,
      this.ScheduledStart,
      this.ScheduledEnd,
      this.HasArchiveStream,
      this.ActualStart,
      this.ActualEnd,
      this.LastModifiedTime,
      this.CommitteeId,
      this.VenueId,
      this.AssemblyProgress,
      this.AssemblyStatus,
      this.ForeignKey,
      this.Handouts,
      this.Id,
      this.Tag})
      : super([
          Title,
          IconUri,
          EntityStatus,
          EntityStatusDesc,
          Location,
          Description,
          ThumbnailUri,
          ScheduledStart,
          ScheduledEnd,
          HasArchiveStream,
          ActualStart,
          ActualEnd,
          LastModifiedTime,
          CommitteeId,
          VenueId,
          AssemblyProgress,
          AssemblyStatus,
          ForeignKey,
          Handouts,
          Id,
          Tag
        ]);

  factory MeetingModel.fromJson(Map<String, dynamic> json) => _$MeetingModelFromJson(json);

  String get scheduledTime {
    var formatter = new DateFormat('HH:mm');
    return formatter.format(this.ScheduledStart) + " - " + formatter.format(this.ScheduledEnd);
  }
}
