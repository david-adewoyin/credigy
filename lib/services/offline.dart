import 'dart:math';

import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/commands/add_supplier_command.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/supplier_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

const String _tableInventory = "inventory_table";
const String _columnProductId = "product_id";
const String _columnProductName = "product_name";
const String _columnMeasurementUnit = "product_measurement_unit";
const String _columnQuantity = "product_quantity";
const String _columnCostPrice = "product_cost_price";
const String _columnSellingPrice = "product_selling_price";

const String _tableCustomer = "customer_table";
const String _columnCustomerId = "customer_id";
const String _columnCustomerName = "customer_name";
const String _columnCustomerPhone = "customer_phone";
const String _columnCustomerEmail = "customer_email";
const String _columnCustomerAddress = "customer_address";
const String _columnCustomerDescription = "customer_description";

const String _tableSupplier = "supplier_table";
const String _columnSupplierId = "supplier_id";
const String _columnSupplierName = "supplier_name";
const String _columnSupplierPhone = "supplier_phone";
const String _columnSupplierEmail = "supplier_email";
const String _columnSupplierAddress = "supplier_address";
const String _columnSupplierDescription = "supplier_description";

const String _tableSaleTransaction = "sale_transaction_table";
const String _columnSaleTransactionId = "sale_transaction_id";
const String _columnPaymentType = "payment_type";
const String _columnDate = "sale_date";
const String _columnPaymentMethod = "payment_method";

const String _columnSaleTransactionRecordId = "sale_record_transaction_id";
const String _tableSaleTransactionRecord = "sale_transaction_record_table";
const String _columnSaleRecordProductQuantity = "sale_record_product_quantity";
const String _columnSaleRecordProductId = "sale_record_product_id";
const String _columnSaleRecordProductName = "sale_record_product_name";
const String _columnSaleRecordTransactionId = "sale_record_transaction_id";

const String _columnSaleRecordCostPrice = "sale_record_costPrice";
const String _columnSaleRecordSellingPrice = "sale_record_selling_Price";

const String _columnSaleRecordProductCostPrice = "sale_record_costPrice";
const String _columnSaleRecordProductSellingPrice = "sale_record_selling_Price";

const String _tableExpenseRecord = "expenses_table";
const String _columnExpenseTransactionId = "expense_transaction_id";
const String _columnExpenseName = "expense_name";
const String _columnExpenseDate = "expense_date";
const String _columnExpenseAmount = "expense_amount";
const String _columnExpensePaymentMethod = "expense_payment_method";

const String _tablePurchaseRecord = 'purchases_table';
const String _columnPurchaseTransactionId = "purchase_transaction_id";
const String _columnPurchaseName = "purchase_name";
const String _columnPurchaseDate = "purchase_date";
const String _columnPurchaseAmount = "purchase_amount";
const String _columnPurchasePaymentMethod = "purchase_payment_method";

const String _tableCashTable = "cash_table";
const String _columnCashId = "column_cash_id";
const String _columnCashAmount = "cash_ammount";
const String _columnCashType = "cash_type";
const String _columnCashDate = "column_cash_date";
const String _columnCashBusinessActionType = "cash_buss_action_type";

const String _tableCashInBusiness = "table_cash_total";
const String _columnCashInBusinessId = "table_cash_in_business_id";
const String _columnCashTotal = "column_cash_total";
const String _columnBankTotal = "column_bank_total";

const String _tableInvoice = "table_invoice";
const String _columnInvoiceId = "column_invoice_id";
const String _columnInvoiceStatus = "column_invoice_status";
const String _columnInvoiceDate = "column_invoice_date";

class DbProvider {
  late Database db;

  Future<void> initDb() async {
    String path = join(await getDatabasesPath(), "credigy00008910.db");
    try {
      await open(path);
    } catch (e) {
      print("unable to open path");
    }
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $_tableCashTable ( 
  $_columnCashId integer primary key autoincrement, 
  $_columnCashAmount double  not null,
  $_columnCashType text not null,
  $_columnCashBusinessActionType text not null,
  $_columnCashDate text not null
  )
''');

      await db.execute('''
create table $_tableCashInBusiness ( 
  $_columnCashInBusinessId integer primary key autoincrement, 
  $_columnCashTotal double  not null,
  $_columnBankTotal double not null
  )
''');

      await db.insert(_tableCashInBusiness, {
        _columnCashTotal: 0,
        _columnBankTotal: 0,
      });

      await db.execute('''
create table $_tableInventory ( 
  $_columnProductId integer primary key autoincrement, 
  $_columnProductName text  unique not null,
  $_columnMeasurementUnit text not null,
  $_columnQuantity int null,
  $_columnCostPrice double not null,
  $_columnSellingPrice double not null
  )
''');
      await db.execute('''
create table $_tableCustomer ( 
  $_columnCustomerId integer primary key autoincrement, 
  $_columnCustomerName text not null,
  $_columnCustomerPhone text  null,
  $_columnCustomerEmail text null,
  $_columnCustomerAddress text  null,
  $_columnCustomerDescription text null
  )
''');
      var c = CustomerModel(name: "walk in Customer", id: 1);
      await db.insert(_tableCustomer, c.toMap());

      await db.execute('''
create table $_tableSupplier ( 
  $_columnSupplierId integer primary key autoincrement, 
  $_columnSupplierName text not null,
  $_columnSupplierPhone text  null,
  $_columnSupplierEmail text null,
  $_columnSupplierAddress text  null,
  $_columnSupplierDescription text null
  )
''');
      await db.execute('''
create table $_tableSaleTransaction ( 
  $_columnSaleTransactionId integer primary key autoincrement, 
  $_columnPaymentType text not null,
  $_columnPaymentMethod text  not  null,
  $_columnCustomerId int not null,
  $_columnDate text  not null
  )
''');

      await db.execute('''
create table $_tableSaleTransactionRecord ( 
  $_columnSaleTransactionRecordId integer primary key autoincrement,
  $_columnSaleTransactionId integer not null, 
  $_columnSaleRecordProductId integer not null, 
  $_columnSaleRecordProductName text null,
  $_columnSaleRecordProductCostPrice double not null,
  $_columnSaleRecordProductSellingPrice double not null,
  $_columnSaleRecordProductQuantity int null
 
  )
''');

      await db.execute('''
create table $_tableInvoice ( 
  $_columnInvoiceId integer primary key autoincrement, 
  $_columnSaleTransactionId integer  not  null,
  $_columnInvoiceStatus text not null,
  $_columnInvoiceDate text not null
  )
''');

      await db.execute('''
create table $_tableExpenseRecord ( 
  $_columnExpenseTransactionId integer primary key autoincrement,
  $_columnExpenseName String not null, 
  $_columnExpenseDate String not null, 
  $_columnExpensePaymentMethod String not null,
  $_columnExpenseAmount double not  null
 
  )
''');
      await db.execute('''
create table $_tablePurchaseRecord ( 
  $_columnPurchaseTransactionId integer primary key autoincrement,
  $_columnPurchaseName String not null, 
  $_columnPurchaseDate String not null, 
  $_columnPurchasePaymentMethod String not null,
  $_columnPurchaseAmount double not  null

  )
''');
    });
  }

  Future<List<double>> getBusinessTotalCash() async {
    List<Map> maps = await db.query(_tableCashInBusiness,
        columns: [
          _columnCashTotal,
          _columnBankTotal,
        ],
        where: '$_columnCashInBusinessId = 1');
    var map = maps.first;
    var bank = map[_columnBankTotal] as double;
    var cash = map[_columnCashTotal] as double;
    return [cash, bank];
  }

  Future<BusinessMoneyModel> insertMoneyIntoBusiness(
      BusinessMoneyModel money) async {
    print("ggggg");
    var id = await db.insert(_tableCashTable, money.toMap());
    var current = await getBusinessTotalCash();

//update value of total money in cashflowtable
/*     if (money.account == CurrentAccount.cash) {
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnCashTotal = ?   WHERE $_columnCashInBusinessId = 1',
          [money.amount + current[0]]);
    } else if (money.account == CurrentAccount.bank) {
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnBankTotal = ?   WHERE $_columnCashInBusinessId = 1',
          [money.amount + current[1]]);
    } */

    money.id = id;
    return money;
  }

  Future<double> payForExpense(CurrentAccount account, double amount) async {
    var current = await getBusinessTotalCash();

    if (account == CurrentAccount.bank) {
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnBankTotal = ?  WHERE $_columnCashInBusinessId = 1',
          [current[1] - amount]);
      return current[1] - amount;
    } else {
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnCashTotal = ?  WHERE $_columnCashInBusinessId = 1',
          [current[0] - amount]);
      return current[0] - amount;
    }
  }

  Future<double> addToCurrentAccount(
      CurrentAccount account, double amount) async {
    List<double> current = await getBusinessTotalCash();

    if (account == CurrentAccount.bank) {
      double t = current[1] + amount;
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnBankTotal = ?  WHERE $_columnCashInBusinessId = 1',
          [t]);

      return t;
    } else {
      double t = current[0] + amount;
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnCashTotal = ?  WHERE $_columnCashInBusinessId = 1',
          [t]);

      return t;
    }
  }

  Future<BusinessMoneyModel> convertMoneyInBusiness(
      BusinessMoneyModel money, CurrentAccount account) async {
    if (money.actionType == BusinessMoneyModelType.add) {
      throw "actiontype must be withdraw";
    }
    money.id = null;
    await db.insert(_tableCashTable, money.toMap());
    var current = await getBusinessTotalCash();
    if (money.account == CurrentAccount.cash) {
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnCashTotal = ? ,$_columnBankTotal = ?  WHERE $_columnCashInBusinessId = 1',
          [current[0] - money.amount, current[1] + money.amount]);
    } else if (money.account == CurrentAccount.bank) {
      await db.rawUpdate(
          'Update $_tableCashInBusiness SET $_columnCashTotal = ? ,$_columnBankTotal = ?  WHERE $_columnCashInBusinessId = 1',
          [current[0] + money.amount, current[1] - money.amount]);
    }

    money.actionType = BusinessMoneyModelType.add;
    money.account = account;
    money.id = null;
    var id = await db.insert(_tableCashTable, money.toMap());
    money.id = id;
    return money;
  }

  Future<List<BusinessMoneyModel>> getAllMoneyIntoBusinessRecord(
      BusinessMoneyModel money) async {
    List<BusinessMoneyModel> list = [];
    List<Map> maps = await db.query(
      _tableCashTable,
      columns: [
        _columnCashId,
        _columnCashAmount,
        _columnCashType,
        _columnCashBusinessActionType,
        _columnCashDate,
      ],
    );
    if (maps.isNotEmpty) {
      for (var m in maps) {
        var map = m as Map<String, Object?>;
        var id = (map[_columnCashId]) as int;
        var amount = (map[_columnCashAmount]) as double;
        var tempDate = map[_columnPurchaseDate] as String;
        var tempAcc = (map[_columnCashType]) as String;
        var tempActionType = map[_columnCashBusinessActionType] as String;

        DateTime date = DateTime.parse(tempDate);
        var account = CurrentAccount.values
            .where((element) => element.toString() == tempAcc)
            .first;
        var actionType = BusinessMoneyModelType.values
            .where((element) => element.toString() == tempActionType)
            .first;

        var s = BusinessMoneyModel(
            amount: amount,
            date: date,
            account: account,
            actionType: actionType);
        list.add(s);
      }
    }
    return list;
  }

  Future<SalesTransactionModel> insertSaleTransaction(
      SalesTransactionModel sale) async {
    var id = await db.insert(_tableSaleTransaction, sale.toMap());
    for (var s in sale.products) {
      var ss = s.toMap();
      ss[_columnSaleTransactionId] = id;

      await db.insert(_tableSaleTransactionRecord, ss);
    }
    sale.id = id;
    return sale;
  }

  Future<ExpenseTransactionModel> insertExpenseTransaction(
      ExpenseTransactionModel exp) async {
    var id = await db.insert(_tableExpenseRecord, exp.toMap());
    exp.id = id;
    return exp;
  }

  Future<PurchaseTransactionModel> insertPurchaseTransaction(
      PurchaseTransactionModel pur) async {
    var id = await db.insert(_tablePurchaseRecord, pur.toMap());
    pur.id = id;
    return pur;
  }

  Future<InvoiceModel> insertInvoice(InvoiceModel inv) async {
    var id = await db.insert(_tableInvoice, inv.toMap());
    inv.id = id;
    return inv;
  }

  Future<int> markInvoiceHasPaid(int id) async {
    return await db.rawUpdate(
        'Update $_tableInvoice SET $_columnInvoiceStatus = ?   WHERE $_columnInvoiceId = ?',
        [InvoiceStatus.paid.toString(), id]);
  }

  Future<List<InvoiceModel>> getAllInvoices() async {
    List<InvoiceModel> list = [];
    try {
      List<Map> maps = await db.query(
        _tableInvoice,
        columns: [
          _columnInvoiceId,
          _columnSaleTransactionId,
          _columnInvoiceDate,
          _columnInvoiceStatus,
        ],
      );

      if (maps.isNotEmpty) {
        for (var m in maps) {
          var map = m as Map<String, Object?>;
          var temp = map[_columnInvoiceDate] as String?;
          var id = (map[_columnInvoiceId]) as int;
          var saleId = map[_columnSaleTransactionId] as int;
          var invoiceStatus = map[_columnInvoiceStatus] as String;
          var status = InvoiceStatus.values
              .where((element) => element.toString() == invoiceStatus)
              .first;
          late DateTime date;
          if (temp != null && temp != "null") {
            date = DateTime.tryParse(temp)!;
          }
          var sale = await getSaleTransactionWithId(saleId);

          var inv = InvoiceModel(
              id: id,
              sale: sale,
              date: date,
              status: status,
              customer: sale.customer);

          list.add(inv);
        }
      }
      return list;
    } catch (e) {
      print(e);
      throw "unable to fetch data";
    }
  }

  Future<List<ExpenseTransactionModel>> getAllExpenseTransaction() async {
    List<ExpenseTransactionModel> list = [];
    List<Map> maps = await db.query(
      _tableExpenseRecord,
      columns: [
        _columnExpenseAmount,
        _columnExpenseDate,
        _columnExpenseName,
        _columnExpenseTransactionId,
        _columnExpensePaymentMethod,
      ],
    );
    if (maps.isNotEmpty) {
      for (var m in maps) {
        var map = m as Map<String, Object?>;
        var temp = map[_columnExpenseDate] as String?;
        var amount = (map[_columnExpenseAmount]) as double;
        var id = (map[_columnExpenseTransactionId]) as int;
        var name = (map[_columnExpenseName]) as String;
        var expenseDesc = ExpenseType.values
            .where((element) => element.toString() == name)
            .first;

        late DateTime date;

        if (temp != null && temp != "null") {
          date = DateTime.tryParse(temp)!;
        }
        var paymentM = (map[_columnExpensePaymentMethod]) as String;
        var paymentMethod = PaymentMethod.values
            .where((element) => element.toString() == paymentM)
            .first;
        var s = ExpenseTransactionModel(
          date: date,
          account: paymentMethod,
          amount: amount,
          expenseDesc: expenseDesc,
          id: id,
        );
        list.add(s);
      }
    }
    return list;
  }

  Future<List<PurchaseTransactionModel>> getAllPurchasesTransaction() async {
    List<PurchaseTransactionModel> list = [];
    List<Map> maps = await db.query(
      _tablePurchaseRecord,
      columns: [
        _columnPurchaseAmount,
        _columnPurchaseDate,
        _columnPurchaseName,
        _columnPurchaseTransactionId,
        _columnPurchasePaymentMethod,
      ],
    );
    if (maps.isNotEmpty) {
      for (var m in maps) {
        var map = m as Map<String, Object?>;
        var temp = map[_columnPurchaseDate] as String?;
        var amount = (map[_columnPurchaseAmount]) as double;
        var id = (map[_columnPurchaseTransactionId]) as int;
        var name = (map[_columnPurchaseName]) as String;

        late DateTime date;

        if (temp != null && temp != "null") {
          date = DateTime.tryParse(temp)!;
        }
        var paymentM = (map[_columnPurchasePaymentMethod]) as String;

        var paymentMethod = PaymentMethod.values
            .where((element) => element.toString() == paymentM)
            .first;
        var s = PurchaseTransactionModel(
          date: date,
          account: paymentMethod,
          amount: amount,
          purchaseName: name,
          id: id,
        );
        list.add(s);
      }
    }
    return list;
  }

  Future<List<SalesTransactionModel>> getSalesTransaction() async {
    List<SalesTransactionModel> list = [];
    List<Map> maps = await db.query(
      _tableSaleTransaction,
      columns: [
        _columnSaleTransactionId,
        _columnPaymentType,
        _columnPaymentMethod,
        _columnDate,
        _columnCustomerId,
      ],
    );
    if (maps.isNotEmpty) {
      for (var m in maps) {
        var map = m as Map<String, Object?>;
        var temp = map[_columnDate] as String?;
        late DateTime date;
        if (temp != null && temp != "null") {
          date = DateTime.tryParse(temp)!;
        }
        var id = (map[_columnSaleTransactionId]) as int;
        var paymentM = (map[_columnPaymentMethod]) as String;
        var paymentT = (map[_columnPaymentType]) as String;
        var custId = (map[_columnCustomerId]) as int;

        CustomerModel customer = await getCustomerWithId(custId);

        var paymentMethod = PaymentMethod.values
            .where((element) => element.toString() == paymentM)
            .first;
        var paymentType = PaymentType.values
            .where((element) => element.toString() == paymentT)
            .first;

        List<Map> pMaps = await db.query(_tableSaleTransactionRecord,
            columns: [
              _columnSaleRecordProductId,
              _columnSaleRecordProductName,
              _columnSaleRecordProductQuantity,
              _columnSaleRecordCostPrice,
              _columnSaleRecordSellingPrice,
              _columnSaleRecordTransactionId,
            ],
            where: "$_columnSaleTransactionId = ?",
            whereArgs: [id]);
        List<ProductTransactionModel> pList = [];
        double totalAmount = 0;
        for (var p in pMaps) {
          var name = (p[_columnSaleRecordProductName]) as String;
          var id = (p[_columnSaleRecordProductId]) as int;
          var saleId = (p[_columnSaleRecordTransactionId]) as int;
          var quantity = (p[_columnSaleRecordProductQuantity]) as int?;
          var costPrice = (p[_columnSaleRecordProductCostPrice]) as double;
          var sellingPrice =
              (p[_columnSaleRecordProductSellingPrice]) as double;
          if (quantity != null) {
            double a = quantity * sellingPrice;
            totalAmount = totalAmount + a;
          } else {
            totalAmount = totalAmount + sellingPrice;
          }
          // print("the total $totalAmount");

          pList.add(ProductTransactionModel(
            costPrice: costPrice,
            name: name,
            id: id,
            quantity: quantity,
            saleId: saleId,
            sellingPrice: sellingPrice,
          ));
        }
        var s = SalesTransactionModel(
          id: id,
          date: date,
          totalAmount: totalAmount,
          paymentMethod: paymentMethod,
          paymentType: paymentType,
          products: pList,
          customer: customer,
        );
        list.add(s);
      }
    }

    return list;
  }

  Future<SalesTransactionModel> getSaleTransactionWithId(int saleId) async {
    List<Map> maps = await db.query(
      _tableSaleTransaction,
      columns: [
        _columnSaleTransactionId,
        _columnPaymentType,
        _columnPaymentMethod,
        _columnDate,
        _columnCustomerId,
      ],
      where: "$_columnSaleTransactionId = ?",
      whereArgs: [saleId],
    );
    var m = maps.first;
    var map = m as Map<String, Object?>;
    var temp = map[_columnDate] as String?;
    late DateTime date;
    if (temp != null && temp != "null") {
      date = DateTime.tryParse(temp)!;
    }
    var id = (map[_columnSaleTransactionId]) as int;
    var paymentM = (map[_columnPaymentMethod]) as String;
    var paymentT = (map[_columnPaymentType]) as String;

    var custId = (map[_columnCustomerId]) as int;
    CustomerModel customer = await getCustomerWithId(custId);

    var paymentMethod = PaymentMethod.values
        .where((element) => element.toString() == paymentM)
        .first;
    var paymentType = PaymentType.values
        .where((element) => element.toString() == paymentT)
        .first;

    List<Map> pMaps = await db.query(_tableSaleTransactionRecord,
        columns: [
          _columnSaleRecordProductId,
          _columnSaleRecordProductName,
          _columnSaleRecordProductQuantity,
          _columnSaleRecordCostPrice,
          _columnSaleRecordSellingPrice,
          _columnSaleRecordTransactionId,
        ],
        where: "$_columnSaleTransactionId = ?",
        whereArgs: [id]);
    List<ProductTransactionModel> pList = [];
    double totalAmount = 0;
    for (var p in pMaps) {
      var name = (p[_columnSaleRecordProductName]) as String;
      var id = (p[_columnSaleRecordProductId]) as int;
      var saleId = (p[_columnSaleRecordTransactionId]) as int;
      var quantity = (p[_columnSaleRecordProductQuantity]) as int?;
      var costPrice = (p[_columnSaleRecordProductCostPrice]) as double;
      var sellingPrice = (p[_columnSaleRecordProductSellingPrice]) as double;
      if (quantity != null) {
        double a = quantity * sellingPrice;
        totalAmount = totalAmount + a;
      } else {
        totalAmount = totalAmount + sellingPrice;
      }
      // print("the total $totalAmount");

      pList.add(ProductTransactionModel(
        costPrice: costPrice,
        name: name,
        id: id,
        quantity: quantity,
        saleId: saleId,
        sellingPrice: sellingPrice,
      ));
    }
    return SalesTransactionModel(
      id: id,
      date: date,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      paymentType: paymentType,
      products: pList,
      customer: customer,
    );
  }

  Future<InventoryModel> insertProduct(InventoryModel product) async {
    var id = await db.insert(_tableInventory, product.toMap());
    product.id = id;
    return product;
  }

  Future<InventoryModel?> getProduct(int id) async {
    List<Map> maps = await db.query(_tableInventory,
        columns: [
          _columnProductId,
          _columnProductName,
          _columnMeasurementUnit,
          _columnQuantity,
          _columnCostPrice,
          _columnSellingPrice,
        ],
        where: '$_columnProductId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      var map = maps.first as Map<String, Object?>;
      var productName = (map[_columnProductName]) as String;
      var costPrice = (map[_columnCostPrice]) as double;
      var quantity = (map[_columnQuantity]) as int?;
      var sellingPrice = (map[_columnSellingPrice]) as double;
      var unit = (map[_columnMeasurementUnit]) as String;
      return InventoryModel(
        id: id,
        productName: productName,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
        unit: MeasurementUnit.values
            .firstWhere((element) => element.toString() == unit),
        quantity: quantity,
      );
    }
    return null;
  }

  Future<List<InventoryModel>> getAllProducts() async {
    List<InventoryModel> products = [];
    List<Map> maps = await db.query(
      _tableInventory,
      columns: [
        _columnProductId,
        _columnProductName,
        _columnMeasurementUnit,
        _columnQuantity,
        _columnCostPrice,
        _columnSellingPrice,
      ],
    );

    for (var map in maps) {
      var id = (map[_columnProductId]) as int;
      var productName = (map[_columnProductName]) as String;
      var costPrice = (map[_columnCostPrice]) as double;
      var quantity = (map[_columnQuantity]) as int?;
      var sellingPrice = (map[_columnSellingPrice]) as double;
      var unit = (map[_columnMeasurementUnit]) as String;
      var p = InventoryModel(
        id: id,
        productName: productName,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
        unit: MeasurementUnit.values
            .firstWhere((element) => element.toString() == unit),
        quantity: quantity,
      );
      products.add(p);
    }
    return products;
  }

  Future<int> deleteInventoryItem(int id) async {
    try {
      return await db.delete(_tableInventory,
          where: '$_columnProductId = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
      throw "unable to delete product";
    }
  }

  Future<InventoryModel> updateProduct(InventoryModel product) async {
    try {
      await db.update(_tableInventory, product.toMap(),
          where: '$_columnProductId = ?', whereArgs: [product.id]);
      return product;
    } catch (e) {
      throw "error while updating product";
    }
  }

  Future<int> updateProductQuantity(String productName, int quantity) async {
    try {
      var c = await getAllProducts();
      var p = c.where((element) => element.productName == productName).first;
      var res = await db.rawUpdate(
          'Update $_tableInventory SET $_columnQuantity = ?   WHERE $_columnProductName = ?',
          [(p.quantity! - quantity), productName]);
      return res;
    } catch (e) {
      throw "error while updating product";
    }
  }

  Future<CustomerModel> getCustomerWithId(int id) async {
    List<Map> maps = await db.query(
      _tableCustomer,
      columns: [
        _columnCustomerId,
        _columnCustomerName,
        _columnCustomerEmail,
        _columnCustomerAddress,
        _columnCustomerPhone,
        _columnCustomerDescription,
      ],
    );

    var map = maps.first;
    var id = (map[_columnCustomerId]) as int;
    var name = (map[_columnCustomerName]) as String;
    var email = (map[_columnCustomerEmail]) as String?;
    var phone = (map[_columnCustomerPhone]) as String?;
    var address = (map[_columnCustomerAddress]) as String?;
    var desc = (map[_columnCustomerDescription]) as String?;
    return CustomerModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: address,
      description: desc,
    );
  }

  Future<List<CustomerModel>> getAllCustomer() async {
    List<CustomerModel> customers = [];
    List<Map> maps = await db.query(
      _tableCustomer,
      columns: [
        _columnCustomerId,
        _columnCustomerName,
        _columnCustomerEmail,
        _columnCustomerAddress,
        _columnCustomerPhone,
        _columnCustomerDescription,
      ],
    );

    for (var map in maps) {
      var id = (map[_columnCustomerId]) as int;
      var name = (map[_columnCustomerName]) as String;
      var email = (map[_columnCustomerEmail]) as String?;
      var phone = (map[_columnCustomerPhone]) as String?;
      var address = (map[_columnCustomerAddress]) as String?;
      var desc = (map[_columnCustomerDescription]) as String?;
      var p = CustomerModel(
        id: id,
        name: name,
        email: email,
        phone: phone,
        address: address,
        description: desc,
      );
      customers.add(p);
    }
    return customers;
  }

  Future<CustomerModel> insertCustomer(CustomerModel customer) async {
    var id = await db.insert(_tableCustomer, customer.toMap());
    customer.id = id;
    return customer;
  }

  Future<CustomerModel> updateCustomer(CustomerModel customer) async {
    try {
      await db.update(_tableCustomer, customer.toMap(),
          where: '$_columnCustomerId = ?', whereArgs: [customer.id]);
      return customer;
    } catch (e) {
      throw "error while updating customer";
    }
  }

  Future<int> deleteCustomer(int id) async {
    try {
      return await db.delete(_tableCustomer,
          where: '$_columnCustomerId = ?', whereArgs: [id]);
    } catch (e) {
      throw "unable to delete customer";
    }
  }

  Future<List<SupplierModel>> getAllSuppliers() async {
    List<SupplierModel> suppliers = [];
    List<Map> maps = await db.query(
      _tableSupplier,
      columns: [
        _columnSupplierId,
        _columnSupplierName,
        _columnSupplierEmail,
        _columnSupplierAddress,
        _columnSupplierPhone,
        _columnSupplierDescription,
      ],
    );

    for (var map in maps) {
      var id = (map[_columnSupplierId]) as int;
      var name = (map[_columnSupplierName]) as String;
      var email = (map[_columnSupplierEmail]) as String?;
      var phone = (map[_columnSupplierPhone]) as String?;
      var address = (map[_columnSupplierAddress]) as String?;
      var desc = (map[_columnSupplierDescription]) as String?;
      var p = SupplierModel(
        id: id,
        name: name,
        email: email,
        phone: phone,
        address: address,
        description: desc,
      );
      suppliers.add(p);
    }
    return suppliers;
  }

  Future<SupplierModel> insertSupplier(SupplierModel supplier) async {
    var id = await db.insert(_tableSupplier, supplier.toMap());
    supplier.id = id;
    return supplier;
  }

  Future<SupplierModel> updateSupplier(SupplierModel supplier) async {
    try {
      await db.update(_tableSupplier, supplier.toMap(),
          where: '$_columnSupplierId = ?', whereArgs: [supplier.id]);
      return supplier;
    } catch (e) {
      throw "error while updating supplier";
    }
  }

  Future<int> deleteSupplier(int id) async {
    try {
      return await db.delete(_tableSupplier,
          where: '$_columnSupplierId = ?', whereArgs: [id]);
    } catch (e) {
      throw "unable to delete supplier";
    }
  }

  Future close() async => db.close();
}
