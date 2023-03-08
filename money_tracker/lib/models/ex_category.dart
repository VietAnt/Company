//Todo: đây là lớp hoặc mô hình danh mục chi phí
//Todo: mọi chi phí sẽ có một danh mục mà nó thuộc về.
import 'package:flutter/material.dart';
import '../constants/icons.dart';

//Todo: Danh mục chi phí
class ExpenseCategory {
  final String title; //tiêu đề của danh mục
  int entries = 0; // bao nhieu chi trong muc nay. nó sẽ thay đổi theo thời gian
  double totalAmount = 0.0; // tổng số chi phí trong danh mục này
  final IconData icon; // Chúng tôi sẽ xác định một số biểu tượng không đổi

  //Todo: Contructor
  ExpenseCategory({
    required this.title,
    required this.entries,
    required this.totalAmount,
    required this.icon,
  });

  //Todo:chúng ta cần một phương thức để chuyển đổi 'mô hình' này thành 'Bản đồ'.
  //Todo: để chúng ta có thể chèn nó vào cơ sở dữ liệu
  Map<String, dynamic> toMap() => {
        'title': title,
        'entries': entries,
        'totalAmount': totalAmount
            .toString(), // cơ sở dữ liệu của chúng tôi sẽ không thể lưu trữ các giá trị kép nên chúng tôi chuyển đổi nó thành một chuỗi
        // không lưu trữ các biểu tượng trong cơ sở dữ liệu. đó là quá nhiều công việc.
      };

  //Todo: khi chúng tôi lấy dữ liệu từ cơ sở dữ liệu, nó sẽ là 'Bản đồ'.
  //Todo: để ứng dụng của chúng tôi hiểu dữ liệu, chúng tôi cần chuyển đổi nó trở lại 'Danh mục chi phí'
  factory ExpenseCategory.fromString(Map<String, dynamic> value) =>
      ExpenseCategory(
        title: value['title'],
        entries: value['entries'],
        totalAmount: double.parse(value['totalAmount']),
        // nó sẽ tìm kiếm bản đồ 'icons' và tìm giá trị liên quan đến tiêu đề.
        icon: icons[value['title']]!,
      );
}
