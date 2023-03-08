import 'package:flutter/material.dart';
import 'package:money_tracker/constants/icons.dart';
import 'package:money_tracker/models/ex_category.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Todo: DatabaseProvider
class DatabaseProvider with ChangeNotifier {
  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
    // khi giá trị của văn bản tìm kiếm thay đổi, nó sẽ thông báo cho các widget.
  }

  //Todo: Bộ nhớ trong ứng dụng tạm thời giữ các danh mục chi phí
  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;

  List<Expense> _expenses = [];
  // Khi văn bản tìm kiếm trống, hãy trả lại toàn bộ danh sách, khác tìm kiếm giá trị
  List<Expense> get expenses {
    return _searchText != ''
        ? _expenses
            .where((e) =>
                e.title.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
        : _expenses;
  }

  //Todo: Database
  Database? _database;

  //Todo: Get Data
  Future<Database> get database async {
    //database directory
    final dbDirectory = await getDatabasesPath();
    //database name
    const dbName = 'expense_tc.db';
    //full path
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return _database!;
  }

  //Todo: _create function
  static const cTable = 'categoryTable';
  static const eTable = 'expenseTable';
  //function _createDB
  Future<void> _createDb(Database db, int version) async {
    // phương thức này chỉ chạy một lần. khi cơ sở dữ liệu đang được tạo
    // vì vậy hãy tạo các bảng ở đây và nếu bạn muốn chèn một số giá trị ban đầu
    // chèn nó vào hàm này.
    await db.transaction((txn) async {
      //! category table
      await txn.execute('''CREATE TABLE $cTable(
        title TEXT,
        entries INTERGER,
        totalAmount TEXT
      )''');
      //! expense table
      await txn.execute('''CREATE TABLE $eTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount TEXT,
        date TEXT,
        category TEXT
      )''');

      // chèn danh mục ban đầu.
      // điều này sẽ thêm tất cả các danh mục vào bảng danh mục
      //và khởi tạo 'mục nhập' bằng 0 và 'totalAmount' thành 0,0
      for (int i = 0; i < icons.length; i++) {
        await txn.insert(cTable, {
          'title': icons.keys.toList()[i],
          'entries': 0,
          'totalAmount': (0.0).toString(),
        });
      }
    });
  }

  //Todo: method to fetch categories: phương thức tìm nạp danh mục:
  Future<List<ExpenseCategory>> fetchCategory() async {
    //get the database
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(cTable).then((data) {
        //'data' is our fetched value
        // convert it from "Map<String, object>" to "Map<String, dynamic>"
        final converted = List<Map<String, dynamic>>.from(data);
        // tạo một 'ExpenseCategory' từ mỗi 'bản đồ' trong 'đã chuyển đổi' này
        List<ExpenseCategory> nList = List.generate(converted.length,
            (index) => ExpenseCategory.fromString(converted[index]));
        // đặt giá trị của 'categories' thành 'nList'
        _categories = nList;
        //trả lại '_categories'
        return _categories;
      });
    });
  }

  //Todo: UpdateCategory: Cap Nhat Danh Muc
  Future<void> updateCategory(
    String category,
    int nEntries,
    double nTotalAmount,
  ) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .update(
        cTable, //category table
        {
          'entries': nEntries, // giá trị mới của 'mục nhập'
          'totalAmount':
              nTotalAmount.toString(), // giá trị mới của 'totalAmount'
        },
        where: 'title == ?', // trong bảng có tiêu đề ==
        whereArgs: [category], //Danh Muc
      )
          .then(
        (_) {
          // sau khi cập nhật vào cơ sở dữ liệu. cập nhật nó trong bộ nhớ trong ứng dụng của chúng tôi.
          var file =
              _categories.firstWhere((element) => element.title == category);
          file.entries = nEntries;
          file.totalAmount = nTotalAmount;
          notifyListeners();
        },
      );
    });
  }

  //Todo: phương pháp để thêm một chi phí vào cơ sở dữ liệu
  Future<void> addExpense(Expense exp) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .insert(
        eTable,
        exp.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((generatedId) {
        // sau khi chèn vào cơ sở dữ liệu.
        //chúng tôi lưu trữ nó trong bộ nhớ trong ứng dụng với chi phí mới với id được tạo
        final file = Expense(
          id: generatedId,
          title: exp.title,
          amount: exp.amount,
          date: exp.date,
          category: exp.category,
        );
        // thêm nó vào '_expenses'
        _expenses.add(file);
        // thông báo cho người nghe về sự thay đổi giá trị của '_expenses'
        notifyListeners();
        // sau khi chúng tôi chèn chi phí,
        //chúng tôi cần cập nhật 'mục' và 'totalAmount' của 'danh mục' liên quan
        var ex = findCategory(exp.category);

        updateCategory(
            exp.category, ex.entries + 1, ex.totalAmount + exp.amount);
      });
    });
  }

  //Todo: DeleteExpense: Xóa chi phí
  Future<void> deleteExpense(int expId, String category, double amount) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(eTable, where: 'id == ?', whereArgs: [expId]).then((_) {
        // cũng xóa khỏi bộ nhớ trong ứng dụng
        _expenses.removeWhere((element) => element.id == expId);
        notifyListeners();
        // chúng ta cũng phải cập nhật các mục nhập và tổng số tiền
        var ex = findCategory(category);
        updateCategory(category, ex.entries - 1, ex.totalAmount - amount);
      });
    });
  }

  //Todo: fetchExpense: tìm nạp Chi phí
  Future<List<Expense>> fetchExpenses(String category) async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(eTable,
          where: 'category == ?', whereArgs: [category]).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        //--------//
        List<Expense> nList = List.generate(
            converted.length, (index) => Expense.fromString(converted[index]));
        _expenses = nList;
        return _expenses;
      });
    });
  }

  //Todo: fetchAllExpenses:lấy tất cả các chi phí
  Future<List<Expense>> fetchAllExpenses() async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(eTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<Expense> nList = List.generate(
            converted.length, (index) => Expense.fromString(converted[index]));
        _expenses = nList;
        return _expenses;
      });
    });
  }

  //Todo: ExpenseCategory: Danh Muc Chi Phi
  ExpenseCategory findCategory(String title) {
    return _categories.firstWhere((element) => element.title == title);
  }

  //Todo: calculateEntriesAndAmount : Tính toán mục nhập và số tiền
  Map<String, dynamic> calculateEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _expenses.where((element) => element.category == category);
    for (final i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }

  //Todo: calculateTotalExpense: Tính Tổng chi phí
  double calculateTotalExpenses() {
    return _categories.fold(
        0.0, (previousValue, element) => previousValue + element.totalAmount);
  }

  //Todo: calculateWeekExpenses: Tính Toán Tuần Chi Phí
  List<Map<String, dynamic>> calculateWeekExpenses() {
    List<Map<String, dynamic>> data = [];

    // chúng tôi biết rằng chúng tôi cần 7 mục
    for (int i = 0; i < 7; i++) {
      // 1 tổng cho mỗi mục
      double total = 0.0;
      // trừ i từ ngày hôm nay để lấy ngày trước đó.
      final weekDay = DateTime.now().subtract(Duration(days: i));

      // kiểm tra xem ngày hôm đó có bao nhiêu giao dịch xảy ra
      for (int j = 0; j < _expenses.length; j++) {
        if (_expenses[j].date.year == weekDay.year &&
            _expenses[j].date.month == weekDay.month &&
            _expenses[j].date.day == weekDay.day) {
          // nếu tìm thấy thì thêm số tiền vào tổng
          total += _expenses[j].amount;
        }
      }

      //thêm vào danh sách
      data.add({'day': weekDay, 'amount': total});
    }
    // trả về danh sách
    return data;
  }
}
