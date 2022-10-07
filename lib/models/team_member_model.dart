class TeamMemberModel {
  String? id;
  String? name;
  String? teamName;
  String? position;
  String? image;

  TeamMemberModel(
      {this.id, this.name, this.teamName, this.position, this.image});

  TeamMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    teamName = json['team_name'];
    position = json['position'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['team_name'] = this.teamName;
    data['position'] = this.position;
    data['image'] = this.image;
    return data;
  }
}
