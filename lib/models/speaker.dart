class Speaker{
Speaker({
  required this.fname,
  required this.id,
  required this.domain,
  required this.experience,
});

late String fname;
late String id;
late String domain;
late String experience;

Speaker.fromJson(Map<String, dynamic> json){
  fname = json['fname'];
  domain = json['domain'];
  id = json['id'];
  experience = json['experience'];
}

Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['fname'] = fname;
  data['domain'] = domain;
  data['id'] = id;
  data['experience'] = experience;
  return data;
  }
}