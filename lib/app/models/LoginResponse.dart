class LoginResponse {
  bool success;
  String message;
  bool login;
  String userToken;

  LoginResponse({this.success, this.message, this.login, this.userToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    login = json['login'];
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['login'] = this.login;
    data['user_token'] = this.userToken;
    return data;
  }
}
