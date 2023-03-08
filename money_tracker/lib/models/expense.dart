//Todo: Expense - Chi phi
class Expense {
  final int id; //id duy nhất cho mọi chi phí
  final String title; //chúng ta đang chi tiêu vào việc gì
  final double amount; //số lượng
  final DateTime date; //ngày
  final String category; //loại - Danh muc

  //Todo:contructor
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  //Todo: Expense to Map: Phone -> Server
  Map<String, dynamic> toMap() => {
        // id sẽ tự động tạo
        'title': title,
        'amount': amount,
        'date': date.toString(),
        'category': category,
      };

  //Todo: Map to Expense: Server -> Phone
  factory Expense.fromString(Map<String, dynamic> value) => Expense(
        id: value['id'],
        title: value['title'],
        amount: double.parse(value['amount']),
        date: DateTime.parse(value['date']),
        category: value['category'],
      );
}
