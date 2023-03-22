class ChatUser{
ChatUser({
  required this.fname,
  required this.id,
  required this.userType,
  required this.profileImage
});

late String fname;
late String id;
late String userType;
late String profileImage;

ChatUser.fromJson(Map<String, dynamic> json){
  fname = json['fname'];
  profileImage = json['profileImage'];
  id = json['id'];
  userType = json['userType'];
  }

Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['fname'] = fname;
  data['userType'] = userType;
  data['id'] = id;
  data['profileImage'] = profileImage;
  return data;
  }
}