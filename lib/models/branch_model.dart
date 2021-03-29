


class BranchModel {
  int id;
  String name;
  bool isVerified;
  String branchAddress;
  int cityId;

BranchModel();
  Map<String, dynamic> toMap() => {'id': id, 'name': name,'isVerified':isVerified,'branchAddress':branchAddress,'cityId':cityId};

  BranchModel.fromMap(Map<String, dynamic> json)
      : id = json['id'],
       name = json['name'],
       isVerified = json['isVerified'],
       branchAddress = json['branchAddress'],
       cityId = json['cityId'];
}
