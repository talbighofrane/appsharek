class Don {
  int id;
  int id_user;
  String device_type;

  String address;
  String description;
  String phone;
  String etat;
  String status;

  Don(this.id, this.id_user, this.device_type, this.address, this.phone,
      this.description, this.etat, this.status);
  Don.fromJson(Map<String, dynamic> json) {
    id = json['id'];id_user = json['id_user'];device_type = json['device_type'];address = json['address'];description = json['description'];phone = json['phone'];etat = json['etat'];status = json['status'];
  }
}
