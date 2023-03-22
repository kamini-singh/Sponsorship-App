class Events{
Events({
  required this.eventName,
  required this.start,
  required this.end,
  required this.about,
  required this.id,
  required this.time
});

late String eventName;
late String id;
late String start;
late String end;
late String time;
late String about;

Events.fromJson(Map<String, dynamic> json){
  eventName = json['eventName'];
  start = json['start'];
  id = json['id'];
  end = json['end'];
  about = json['about'];
  time = json['time'];
}

Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['eventname'] = eventName;
  data['about'] = about;
  data['id'] = id;
  data['start'] = start;
  data['end'] = end;
  data['time'] = time;
  return data;
  }
}