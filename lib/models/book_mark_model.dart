class BookMarkModel {
  final String title;
  final String desc;
  final String name;
  final int countCm;
  final String date;
   bool isExpanded;

  BookMarkModel({
    required this.title,
    required this.desc,
    required this.name,
    required this.countCm,
    required this.date,
  this.isExpanded = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'name': name,
      'countCm': countCm,
      'date': date,
    };
  }

  factory BookMarkModel.fromMap(Map<String, dynamic> map) {
    return BookMarkModel(
      title: map['title'] as String,
      desc: map['desc'] as String,
      name: map['name'] as String,
      countCm: map['countCm'] as int,
      date: map['date'] as String,
    );
  }
}
