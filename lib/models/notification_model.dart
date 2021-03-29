


class NotificationModel {
  int senderId;
  int receiverId;
  String sendDate;
  bool isRead;
  String createdAt;
  String updatedAt;
  String name;

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'receiverId': receiverId,
        'sendDate': sendDate,
        'name': name,
        'isRead': isRead,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
  NotificationModel();

  NotificationModel.fromMap(Map<String, dynamic> json)
      : senderId = json['senderId'],
        receiverId = json['receiverId'],
        name = json['name'],
        sendDate = json['sendDate'],
        isRead = json['isRead'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
