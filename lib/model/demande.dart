class Demande {
  int id;
  int id_user;
  String device_type;
  String description;
  String university;
  String ville;
  String address;

  String phone;

  Demande(this.id, this.id_user, this.device_type, this.university, this.ville,
      this.address, this.phone, this.description);
  
  Demande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id_user = json['id_user'];
    device_type = json['device_type'];
    address = json['address'];
    description = json['description'];
    phone = json['phone'];
   ville= json['ville'];
    
  }
}
