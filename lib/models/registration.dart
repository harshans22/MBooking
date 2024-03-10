class UserDetails {
  final String name;
  final String Password;
  final String email;
  final String city;

  UserDetails(
      {required this.Password,
      required this.city,
      required this.email,
      required this.name});

  Map<String, dynamic> toJson() =>
      {"username": name, "email": email, "password": Password, "city": city};
}
