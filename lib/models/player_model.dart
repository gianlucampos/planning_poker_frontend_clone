// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlayerModel {
  final String? name;
  final String? vote;

  PlayerModel({
    required this.name,
    required this.vote,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'vote': vote,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      name: map['name'] != null ? map['name'] as String : null,
      vote: map['vote'] != null ? map['vote'] as String : null,
    );
  }

  @override
  String toString() => '\nPlayerModel(name: $name, vote: $vote)';
}
