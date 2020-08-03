class User {
  int id;
  String username;
  String email;
  String profileImage;
  String gender;
  String city;
  bool roomInvite = false;
  bool roomMember = false;

  User(
      {this.id,
      this.username,
      this.profileImage,
      this.email,
      this.gender,
      this.city}):super();

  User.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] ?? '',
        username = parsedJson['username'] ?? '',
        profileImage = parsedJson['profileImage'] ?? '',
        email = parsedJson['email'] ?? '',
        gender = parsedJson['gender'] ?? '',
        city = parsedJson['city'] ?? '';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "username": username,
      "profileImage": profileImage,
      "email": email,
      "gender": gender,
      "city": city
    };
  }

  set isInvited(bool invited) {
    this.roomInvite = invited;
  }

  bool get isInvited {
    return roomInvite;
  }

  set isRoomMember(bool roomMember) {
    roomMember = roomMember;
  }

  get isRoomMember {
    return roomMember;
  }

  @override
  String toString() =>
      'User { id: $id, username: $username, profileImage: $profileImage, ' +
      'email: $email, gender: $gender, city: $city }';
}
