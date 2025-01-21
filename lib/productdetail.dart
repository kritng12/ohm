import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // นำเข้า intl สำหรับการแปลงวันที่

class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetail({required this.product, Key? key}) : super(key: key);

  // ฟังก์ชั่นแปลงวันที่
  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date); // แปลงจาก string เป็น DateTime
      return DateFormat('dd MMMM yyyy').format(parsedDate); // เปลี่ยนรูปแบบวันที่
    } catch (e) {
      return 'ไม่ทราบวันที่'; // หากวันที่ไม่ถูกต้องหรือไม่มีการแปลง
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'] ?? 'รายละเอียดสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อสินค้า: ${product['name'] ?? 'ไม่ทราบชื่อ'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'รายละเอียดสินค้า: ${product['description'] ?? 'ไม่มีรายละเอียด'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'ราคา: ${product['price'] ?? 'ไม่ทราบราคา'} บาท',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'จำนวนสินค้า: ${product['quantity'] ?? 'ไม่ทราบจำนวน'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
