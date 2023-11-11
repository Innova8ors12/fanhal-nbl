class Halloffame {
	int? id;
	String? name;
	String? Class;
	int? status;
	String? createdAt;
	String? updatedAt;

	Halloffame({this.id, this.name, this.Class, this.status, this.createdAt, this.updatedAt});

	Halloffame.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		Class = json['class'];
		status = json['status'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['class'] = this.Class;
		data['status'] = this.status;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}