class UserInformation {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? cardNum;
  String? cvv;
  String? expiryDate;
  String? address;
  String? city;
  String? zipCode;
  String? country;
  String? studentID;

  UserInformation({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.address,
    this.cardNum,
    this.cvv,
    this.expiryDate,
    this.city,
    this.zipCode,
    this.country,
    this.studentID,
  });

  //Get Data from the server
  factory UserInformation.fromMap(map) {
    return UserInformation(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      address: map['address'],
      cardNum: map['cardNum'],
      cvv: map['cvv'],
      expiryDate: map['expiryDate'],
      city: map['city'],
      zipCode: map['zipCode'],
      country: map['country'],
      studentID: map['studentID'],
    );
  }

//Send data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'address': address,
      'cardNum': cardNum,
      'cvv': cvv,
      'expiryDate': expiryDate,
      'city': city,
      'zipCode': zipCode,
      'country': country,
      'studentID': studentID,
    };
  }

  UserInformation fromJson(Map<String, dynamic> json) => UserInformation(
        uid: json['uid'],
        email: json['email'],
        firstName: json['firstName'],
        secondName: json['secondName'],
        address: json['address'],
        cardNum: json['cardNum'],
        cvv: json['cvv'],
        expiryDate: json['expiryDate'],
        city: json['city'],
        zipCode: json['zipCode'],
        country: json['country'],
        studentID: json['studentID'],
      );
}
