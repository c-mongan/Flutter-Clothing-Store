class UserInformation {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? cardNum;
  String? cvv;
  String? expiryDate;
  String? address;
  // String? bmi;
  // String? tdee;
  // String? activityLevel;
  // String? bmiTime;

  UserInformation({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.address,
    this.cardNum,
    // this.activityLevel,
    this.cvv,
    // this.tdee,
    // this.bmi,
    this.expiryDate,
    // this.bmiTime
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
        expiryDate: map['expiryDate']);
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
      // 'bmi': bmi,
      // 'bmiTime': bmiTime,
      // 'tdee': tdee,
      'expiryDate': expiryDate,
    };
  }

  UserInformation fromJson(Map<String, dynamic> json) => UserInformation(
      cardNum: json['cardNum'],
      cvv: json['cvv'],
      expiryDate: json['expiryDate'],
      address: json['address']);
}
