class User {
  String url;
  int id;
  String firstName;
  String lastName;
  String pass;

  User({this.url, this.id, this.firstName, this.lastName, this.pass});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // url: json['url'],
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      pass: json['password'],
    );
  }
}
