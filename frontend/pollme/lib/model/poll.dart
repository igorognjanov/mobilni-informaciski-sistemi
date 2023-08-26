class Poll {
  BigInt? id;
  String pollName;
  String questionName;

  Poll({required this.pollName, required this.questionName, this.id});

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'pollName': pollName,
        'questionName': questionName,
      };

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        id: BigInt.parse(json['id'].toString()),
        pollName: json['pollName'] as String,
        questionName: json['questionName'] as String,
      );
}
