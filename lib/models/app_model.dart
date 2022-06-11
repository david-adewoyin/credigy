import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/supplier_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/models/user_business_model.dart';
import 'package:credigy/services/app_service.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  late bool _isFreshInstall;
  UserBusinessModel? _user;
  late final List<InventoryModel> _inventory = [];
  late final List<CustomerModel> _customers = [];
  late final List<SupplierModel> _suppliers = [];
  late final List<TransactionModel> _transactions = [];
  late double _totalExpenses = 0;
  late double _totalCash = 0;
  late double _totalBank = 0;
  late double _totalIncome = 0;

  setTotalCash(double c) {
    _totalCash = c;
    notifyListeners();
  }

  setTotalBank(double c) {
    _totalBank = c;
    notifyListeners();
  }

  double getTotalCash() {
    return _totalCash;
  }

  double getTotalBank() {
    return _totalBank;
  }

  setTotalIncome(double c) {
    _totalIncome = c;
    notifyListeners();
  }

  setTotalExpense(double c) {
    _totalExpenses = c;
    notifyListeners();
  }

  double getTotalExpenses() {
    return _totalExpenses;
  }

  double getTotalIncome() {
    return _totalIncome;
  }

  bool isFreshInstall() {
    return _isFreshInstall;
  }

  setIsFreshInstall(bool fresh) {
    _isFreshInstall = fresh;
    notifyListeners();
  }

  get user => _user;
  setBusinessUser(UserBusinessModel businessUser) {
    _user = businessUser;
    notifyListeners();
  }

  UserBusinessModel getBusinessUser() {
    return _user!;
  }

  addInventoryItem(InventoryModel model) {
    _inventory.add(model);
    notifyListeners();
  }

  populateInventory(List<InventoryModel> products) {
    _inventory.clear();
    _inventory.addAll(products);
    notifyListeners();
  }

  updateProduct(InventoryModel product) {
    var p = _inventory.where((element) => element.id == product.id).first;
    p.productName = product.productName;
    p.costPrice = product.costPrice;
    p.sellingPrice = product.sellingPrice;
    p.quantity = product.quantity;
    p.unit = product.unit;
    notifyListeners();
  }

  List<InventoryModel> inventory() {
    return _inventory;
  }

  deleteInventory(int id) {
    _inventory.removeWhere((element) => element.id! == id);
    notifyListeners();
  }

  deleteCustomer(int id) {
    _customers.removeWhere((element) => element.id! == id);
    notifyListeners();
  }

  populateCustomer(List<CustomerModel> customers) {
    _customers.clear();
    _customers.addAll(customers);
    notifyListeners();
  }

  addCustomer(CustomerModel customer) {
    _customers.add(customer);
    notifyListeners();
  }

  List<CustomerModel> customers() {
    return _customers;
  }

  updateCustomer(CustomerModel customer) {
    var c = _customers.where((element) => element.id == customer.id).first;
    c.name = customer.name;
    c.phone = customer.phone;
    c.email = customer.email;
    c.address = customer.address;
    c.description = customer.description;
    notifyListeners();
  }

  deleteSupplier(int id) {
    _suppliers.removeWhere((element) => element.id! == id);
    notifyListeners();
  }

  populateSuppliers(List<SupplierModel> suppliers) {
    _suppliers.clear();
    _suppliers.addAll(suppliers);
    notifyListeners();
  }

  addSupplier(SupplierModel supplier) {
    _suppliers.add(supplier);
    notifyListeners();
  }

  List<SupplierModel> suppliers() {
    return _suppliers;
  }

  updateSupplier(SupplierModel supplier) {
    var s = _suppliers.where((element) => element.id == supplier.id).first;
    s.name = supplier.name;
    s.phone = supplier.phone;
    s.email = supplier.email;
    s.address = supplier.address;
    s.description = supplier.description;
    notifyListeners();
  }

  List<TransactionModel> recentTransactions(int end) {
    _transactions.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));
    return _transactions.take(end).toList();
  }

  addTransaction(TransactionModel tr) {
    _transactions.add(tr);
    notifyListeners();
  }

  populateTransactions(List<TransactionModel> transactions) {
    _transactions.clear();
    _transactions.addAll(transactions);
    notifyListeners();
  }

  List<TransactionModel> allTransactions() {
    _transactions.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));

    return _transactions;
  }
}
