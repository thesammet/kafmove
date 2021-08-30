class ProfileResponse {
  bool success;
  String message;
  User user;
  Location location;
  Count count;
  String details;

  ProfileResponse(
      {this.success,
      this.message,
      this.user,
      this.location,
      this.count,
      this.details});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.count != null) {
      data['count'] = this.count.toJson();
    }
    data['details'] = this.details;
    return data;
  }
}

class User {
  String username;
  String firstName;
  String lastName;
  String sex;
  String email;
  String phone;
  String profilePhoto;
  Null birthdate;

  User(
      {this.username,
      this.firstName,
      this.lastName,
      this.sex,
      this.email,
      this.phone,
      this.profilePhoto,
      this.birthdate});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sex = json['sex'];
    email = json['email'];
    phone = json['phone'];
    profilePhoto = json['profilePhoto'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['sex'] = this.sex;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['profilePhoto'] = this.profilePhoto;
    data['birthdate'] = this.birthdate;
    return data;
  }
}

class Location {
  String city;
  String country;

  Location({this.city, this.country});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }
}

class Count {
  int follows;
  int friends;

  Count({this.follows, this.friends});

  Count.fromJson(Map<String, dynamic> json) {
    follows = json['follows'];
    friends = json['friends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follows'] = this.follows;
    data['friends'] = this.friends;
    return data;
  }
}
