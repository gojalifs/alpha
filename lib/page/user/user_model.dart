class UserDataModel {
  String? id;
  String? name;
  String? avatar;
  String? status;
  String? dept;
  String? salary;
  String? subGrup;
  String? joinDate;
  String? phone;
  String? birth;
  String? gender;
  String? address;

  UserDataModel(
      {this.id,
      this.name,
      this.avatar,
      this.status,
      this.dept,
      this.salary,
      this.subGrup,
      this.joinDate,
      this.phone,
      this.birth,
      this.gender,
      this.address});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    status = json['status'];
    dept = json['dept'];
    salary = json['salary'];
    subGrup = json['sub_grup'];
    joinDate = json['join_date'];
    phone = json['phone'];
    birth = json['birth'];
    gender = json['gender'];
    address = json['address'];
  }

  // factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
  //       id: json['id'],
  //       name: json['name'],
  //       avatar: json['avatar'],
  //       status: json['status'],
  //       dept: json['dept'],
  //       salary: json['salary'],
  //       subGrup: json['sub_grup'],
  //       joinDate: json['join_date'],
  //       phone: json['phone'],
  //       birth: json['birth'],
  //       gender: json['gender'],
  //       address: json['address'],
  //     );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['dept'] = this.dept;
    data['salary'] = this.salary;
    data['sub_grup'] = this.subGrup;
    data['join_date'] = this.joinDate;
    data['phone'] = this.phone;
    data['birth'] = this.birth;
    data['gender'] = this.gender;
    data['address'] = this.address;
    return data;
  }
}


// class UserDataModel {
//   String id;
//   String name;
//   String avatar;
//   String status;
//   String dept;
//   String salary;
//   String subGrup;
//   String joinDate;
//   String phone;
//   String birth;
//   String gender;
//   String address;

//   UserDataModel(
//       {required this.id,
//       required this.name,
//       required this.avatar,
//       required this.status,
//       required this.dept,
//       required this.salary,
//       required this.subGrup,
//       required this.joinDate,
//       required this.phone,
//       required this.birth,
//       required this.gender,
//       required this.address});

//   factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
//         id : json['id'],
//         name : json['name'],
//         avatar : json['avatar'],
//         status : json['status'],
//         dept : json['dept'],
//         subGrup : json['sub_grup'],
//         salary : json['salary'],
//         joinDate : json['join_date'],
//         phone : json['phone'],
//         birth : json['birth'],
//         gender : json['gender'],
//         address : json['address'],
//       );

//   // factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
//   //       id: json['id'],
//   //       name: json['name'],
//   //       avatar: json['avatar'],
//   //       status: json['status'],
//   //       dept: json['dept'],
//   //       salary: json['salary'],
//   //       subGrup: json['sub_grup'],
//   //       joinDate: json['join_date'],
//   //       phone: json['phone'],
//   //       birth: json['birth'],
//   //       gender: json['gender'],
//   //       address: json['address'],
//   //     );

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['avatar'] = this.avatar;
//     data['status'] = this.status;
//     data['dept'] = this.dept;
//     data['salary'] = this.salary;
//     data['sub_grup'] = this.subGrup;
//     data['join_date'] = this.joinDate;
//     data['phone'] = this.phone;
//     data['birth'] = this.birth;
//     data['gender'] = this.gender;
//     data['address'] = this.address;
//     return data;
//   }
// }

