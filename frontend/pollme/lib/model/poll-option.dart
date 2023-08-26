import 'package:pollme/model/poll.dart';

class PollOption {
  BigInt? id;
  BigInt? pollId;
  String name;

  PollOption({this.id, this.pollId, required this.name});

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'pollId': pollId.toString(),
        'name': name,
      };

  factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
        id: BigInt.parse(json['id'].toString()),
        pollId: BigInt.parse(json['pollId'].toString()),
        name: json['name'] as String,
      );
}
