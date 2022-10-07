class TeamModel {
  String? id;
  String? clubName;
  String? image;

  TeamModel({this.id, this.clubName, this.image});

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubName = json['club_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_name'] = this.clubName;
    data['image'] = this.image;
    return data;
  }
}
