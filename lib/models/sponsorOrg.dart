class SponsorOrg{
SponsorOrg({
  required this.id,
  required this.orgName,
  required this.orgType,
  required this.range,
  required this.gst
});

late String id;
late String orgName;
late String orgType;
late String range;
late String gst;

SponsorOrg.fromJson(Map<String, dynamic> json){
  id = json['id'];
  orgName = json['orgName'];
  orgType = json['orgType'];
  range = json['range'];
  gst = json['gst'];
}

Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['id'] = id;
  data['orgName'] = orgName;
  data['orgType'] = orgType;
  data['range'] = range;
  data['gst'] = gst;
  return data;
  }
}