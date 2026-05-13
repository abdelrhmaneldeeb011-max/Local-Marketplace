import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/customer.dart';
import '../models/store.dart';
import '../models/user.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8080';
  static String? _authToken;
  static int? _customerId;

  static String get baseUrl => _baseUrl;

  static Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    if (_customerId != null) {
      headers['X-Customer-Id'] = '$_customerId';
    }
    return headers;
  }

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('auth_token');
    _customerId = prefs.getInt('customer_id');
  }

  static Future<void> setAuth(String token, int customerId) async {
    _authToken = token;
    _customerId = customerId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('customer_id', customerId);
  }

  static Future<void> clearAuth() async {
    _authToken = null;
    _customerId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('customer_id');
  }

  static bool get isAuthenticated => _authToken != null;
  static int? get customerId => _customerId;

  // ==================== AUTH ====================
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final token = data['token'] ?? data['accessToken'] ?? '';
      final customerId = data['customerId'] ?? data['id'] ?? 0;
      await setAuth(token, customerId);
    }
    return data;
  }

  static Future<Map<String, dynamic>> register(
    String fullName,
    String email,
    String password,
    String role,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'role': role,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return jsonDecode(response.body);
  }

  // ==================== CATEGORIES ====================
  static Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/categories'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  // ==================== PRODUCTS ====================
  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/products'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  static Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/api/products/search?q=${Uri.encodeComponent(query)}',
      ),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  // ==================== CART ====================
  static Future<Cart> getCart() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/cart'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    }
    return Cart(items: [], total: 0);
  }

  static Future<Cart> addToCart(int productId, int quantity) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/cart/items'),
      headers: _headers,
      body: jsonEncode({'productId': productId, 'quantity': quantity}),
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    }
    return Cart(items: [], total: 0);
  }

  static Future<Cart> removeFromCart(int productId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/api/cart/items/$productId'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    }
    return Cart(items: [], total: 0);
  }

  static Future<void> clearCart() async {
    await http.delete(Uri.parse('$_baseUrl/api/cart'), headers: _headers);
  }

  static Future<Order> checkout() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/cart/checkout'),
      headers: _headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    }
    throw Exception('Checkout failed: ${response.body}');
  }

  // ==================== ORDERS ====================
  static Future<List<Order>> getMyOrders({String? status}) async {
    final uri = status != null
        ? Uri.parse('$_baseUrl/api/orders/me/status?status=$status')
        : Uri.parse('$_baseUrl/api/orders/me');
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => Order.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Order> getOrder(int orderId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/orders/$orderId'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    }
    throw Exception('Order not found');
  }

  static Future<void> cancelOrder(int orderId) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/orders/$orderId/cancel'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Cancel failed: ${response.body}');
    }
  }

  // ==================== CUSTOMER ====================
  static Future<Customer> getCustomerMe() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/customers/me'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load profile');
  }

  static Future<Customer> updateCustomerMe(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/customers/me'),
      headers: _headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    }
    throw Exception('Update failed: ${response.body}');
  }

  static Future<void> updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/customers/me/password'),
      headers: _headers,
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Password update failed: ${response.body}');
    }
  }

  static Future<void> deleteAccount() async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/api/customers/me'),
      headers: _headers,
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      await clearAuth();
    }
  }

  // ==================== ADMIN ====================
  static Future<List<Store>> getAdminStores() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/admin/stores'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => Store.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Store> createStore(String name, String owner) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/admin/stores'),
      headers: _headers,
      body: jsonEncode({'name': name, 'owner': owner}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Store.fromJson(jsonDecode(response.body));
    }
    throw Exception('Create store failed: ${response.body}');
  }

  static Future<void> updateStoreStatus(int storeId, bool active) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/admin/stores/$storeId/status?active=$active'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Update store status failed: ${response.body}');
    }
  }

  static Future<void> deleteStore(int storeId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/api/admin/stores/$storeId'),
      headers: _headers,
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Delete store failed: ${response.body}');
    }
  }

  static Future<List<User>> getAdminUsers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/admin/users'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => User.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> blockUser(int customerId, bool blocked) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/admin/users/$customerId/block?blocked=$blocked'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Block user failed: ${response.body}');
    }
  }

  static Future<void> deleteUser(int customerId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/api/admin/users/$customerId'),
      headers: _headers,
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Delete user failed: ${response.body}');
    }
  }
}
