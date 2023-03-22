class Sponsor{
Sponsor({
  required this.id,
  required this.orgName,
  required this.orgType,
  required this.amount,
  required this.reason,
});

late String id;
late String orgName;
late String orgType;
late String amount;
late String reason;

Sponsor.fromJson(Map<String, dynamic> json){
  id = json['id'];
  orgName = json['orgName'];
  orgType = json['orgType'];
  amount = json['amount'];
  reason = json['reason'];
}

Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['id'] = id;
  data['orgName'] = orgName;
  data['orgType'] = orgType;
  data['amount'] = amount;
  data['reason'] = reason;
  return data;
  }
}