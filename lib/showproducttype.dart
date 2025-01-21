import 'package:flutter/material.dart';
import 'showfiltertype.dart';

class ShowProductType extends StatelessWidget {
  const ShowProductType({super.key});

  // รายการประเภทสินค้า (สามารถเปลี่ยนแปลงได้ตามต้องการ)
  final List<Map<String, String>> productTypes = const [
    {'name': 'Electronics', 'icon': 'devices'},
    {'name': 'Clothing', 'icon': 'shirt'},
    {'name': 'Food', 'icon': 'restaurant'},
    {'name': 'Books', 'icon': 'book'},
  ];

  // ฟังก์ชันเพื่อเลือกไอคอนจากชื่อ
  IconData getIcon(String iconName) {
    switch (iconName) {
      case 'devices':
        return Icons.devices;
      case 'shirt':
        return Icons.checkroom;
      case 'restaurant':
        return Icons.restaurant;
      case 'book':
        return Icons.book;
      default:
        return Icons.help; // กรณีไม่มี icon ที่ตรง
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประเภทสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // แสดง 2 คอลัมน์
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0, // สัดส่วนของ Grid แต่ละอัน
          ),
          itemCount: productTypes.length,
          itemBuilder: (context, index) {
            final type = productTypes[index];
            return GestureDetector(
              onTap: () {
                // เมื่อกดประเภทสินค้า จะไปที่หน้า ShowFilterType และส่ง category ไป
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShowFilterType(category: type['name'] ?? ''),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        getIcon(type['icon'] ?? 'home'), // ใช้ฟังก์ชัน getIcon
                        size: 40,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        type['name'] ?? 'ไม่มีชื่อ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
