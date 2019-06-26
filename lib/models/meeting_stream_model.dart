import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meeting_stream_model.g.dart';

@JsonSerializable()
class MeetingStreamModel extends Equatable {
  final int GlobalEssenceFormatId;
  final bool IsLive;
  final bool Enabled;
  final bool AudioOnly;
  final int VideoIndex;
  final int AudioIndex;
  final int StreamFormatId;
  final String Url;
  final String Lang;
  final List StreamAssemblerList;
  final double PreRoll;
  final double Duration;
  final String Label;
  final String Description;
  final int Id;
  final String Tag;

  MeetingStreamModel({this.GlobalEssenceFormatId, this.IsLive, this.Enabled, this.AudioOnly, this.VideoIndex, this.AudioIndex, this.StreamFormatId, this.Url, this.Lang, this.StreamAssemblerList, this.PreRoll, this.Duration, this.Label, this.Description, this.Id, this.Tag})
    : super([GlobalEssenceFormatId,IsLive,Enabled,AudioOnly,VideoIndex,AudioIndex,StreamFormatId,Url,Lang,StreamAssemblerList,PreRoll,Duration,Label,Description,Id,Tag]);
  
  factory MeetingStreamModel.fromJson(Map<String, dynamic> json) => _$MeetingStreamModelFromJson(json);
}
