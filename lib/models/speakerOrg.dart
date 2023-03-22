class SpeakerOrg{
SpeakerOrg({
  required this.id,
  required this.orgName,
  required this.orgType,
  required this.about
});

late String id;
late String orgName;
late String orgType;
late String about;

SpeakerOrg.fromJson(Map<String, dynamic> json){
  id = json['id'];
  orgName = json['orgName'];
  orgType = json['orgType'];
  about = json['about'];
}

Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['id'] = id;
  data['orgName'] = orgName;
  data['orgType'] = orgType;
  data['about'] = about;
  return data;
  }
}