



class UserData {

String? email;
String? url;
  String? name;
  UserData({ this.email, this.name,this.url});

  UserData.fromJson(Map<String, dynamic> json) {
   
    
    name = json['name'];
    email = json['email'];
    url = json['url'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['email'] = email;
    data['name'] = name;
    data['url'] = url;
    
    return data;
  }
}
