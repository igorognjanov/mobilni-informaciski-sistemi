class PollOption {
  BigInt? id;
  BigInt? pollId;
  String name;
  BigInt optionName;

  PollOption(
      {this.id, this.pollId, required this.name, required this.optionName});
}
