class SearchResponse {
  bool success;
  String message;
  List<Users> users;
  bool search;

  SearchResponse({this.success, this.message, this.users, this.search});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    data['search'] = this.search;
    return data;
  }
}

class Users {
  String username;
  String name;
  String surname;
  String profilePhoto;
  String uid;
  bool isFriend;

  Users(
      {this.username,
      this.name,
      this.surname,
      this.profilePhoto,
      this.uid,
      this.isFriend});

  Users.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    surname = json['surname'];
    profilePhoto = json['profilePhoto'];
    uid = json['uid'];
    isFriend = json['isFriend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['profilePhoto'] = this.profilePhoto;
    data['uid'] = this.uid;
    data['isFriend'] = this.isFriend;
    return data;
  }
}
