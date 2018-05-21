export 'package:invoiceninja/data/models/entities.dart';

class User {
  final String token;
  final int id;

  User(this.token, this.id);

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'token': this.token,
    'id': this.id
  };

  factory User.fromJSON(Map<String, dynamic> json) => new User(
    json['token'],
    json['id'],
  );

  @override
  String toString() {
    return '{token: $token, id: $id}';
  }
}
