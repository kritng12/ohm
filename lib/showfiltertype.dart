import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'productdetail.dart'; // นำเข้าไฟล์ที่มีหน้า ProductDetail

class ShowFilterType extends StatefulWidget {
  final String category;

  const ShowFilterType({required this.category, Key? key}) : super(key: key);

  @override
  State<ShowFilterType> createState() => _ShowFilterTypeState();
}

class _ShowFilterTypeState extends State<ShowFilterType> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('products');
  late Stream<DatabaseEvent> _productStream;

  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลสินค้าเฉพาะประเภทที่เลือก
    _productStream = _databaseRef.orderByChild('category').equalTo(widget.category).onValue;
  }

  // ฟังก์ชั่นแปลงวันที่
  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้าในประเภท: ${widget.category}'),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: _productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('ไม่พบสินค้าในประเภทนี้'));
          }

          // แปลงข้อมูลใน Firebase เป็น Map<String, dynamic>
          final data = snapshot.data!.snapshot.value as Map<Object?, Object?>;
          final products = data.entries.map((entry) {
            return Map<String, dynamic>.from(entry.value as Map);
          }).toList();

          return ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 3,
                child: ListTile(
                  title: Text(
                    product['name'] ?? 'ไม่มีชื่อสินค้า',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('รายละเอียด: ${product['description'] ?? 'ไม่มีรายละเอียด'}'),
                      Text('ประเภท: ${product['category'] ?? 'ไม่มีประเภท'}'),
                      Text('วันที่ผลิต: ${formatDate(product['productionDate'] ?? '2024-01-01')}'),
                      Text('จำนวน: ${product['quantity'] ?? 'ไม่ทราบจำนวน'}'),
                    ],
                  ),
                  onTap: () {
                    // เมื่อกดที่รายการสินค้า, นำไปหน้า ProductDetail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
