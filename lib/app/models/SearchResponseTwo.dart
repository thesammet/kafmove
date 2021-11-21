class SearchResponseTwo {
  bool success;
  String message;
  List<Places> places;
  bool search;

  SearchResponseTwo({this.success, this.message, this.places, this.search});

  SearchResponseTwo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['places'] != null) {
      places = new List<Places>();
      json['places'].forEach((v) {
        places.add(new Places.fromJson(v));
      });
    }
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.places != null) {
      data['places'] = this.places.map((v) => v.toJson()).toList();
    }
    data['search'] = this.search;
    return data;
  }
}

class Places {
  String name;
  String photo;
  String uid;

  Places({this.name, this.photo, this.uid});

  Places.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['uid'] = this.uid;
    return data;
  }
}
