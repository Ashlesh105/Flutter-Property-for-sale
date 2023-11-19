class User {
  final int? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;

  User({this.id, required this.name, required this.email, required this.phoneNumber,required this.profileImage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }
}
