class UserSettingsResponse {
  bool success;
  String message;
  bool update;

  UserSettingsResponse({this.success, this.message, this.update});

  UserSettingsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    update = json['update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['update'] = this.update;
    return data;
  }
}
