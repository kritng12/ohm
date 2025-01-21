import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlineapp_siwat_secb/showproduct.dart';
import 'package:onlineapp_siwat_secb/showproducttype.dart';
import 'addproduct.dart';

//Method หลักที่ Run
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBzZcb_MUfSxFe-YfeAov-FDNu-QvGS7z8",
            authDomain: "onlinefirebase-3cb48.firebaseapp.com",
            databaseURL:
                "https://onlinefirebase-3cb48-default-rtdb.firebaseio.com",
            projectId: "onlinefirebase-3cb48",
            storageBucket: "onlinefirebase-3cb48.firebasestorage.app",
            messagingSenderId: "889576798136",
            appId: "1:889576798136:web:57ff3256837d95a6a7c14d",
            measurementId: "G-3F7JP3F20Y"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

//Class stateless
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 255, 255)),
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

//Class stateful เรียกใช้การทำงานแบบโต้ตอบ
class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // จัดปุ่มให้อยู่กลางแนวตั้ง
            crossAxisAlignment: CrossAxisAlignment.center, // จัดปุ่มให้อยู่กลางแนวนอน
            children: [
              // โลโก้
              Image.asset(
                'assets/logo.png', // แสดงโลโก้
                width: 300, // ขนาดของโลโก้
                height: 300, // ขนาดของโลโก้
              ),
              SizedBox(height: 40), // เพิ่มระยะห่างจากโลโก้

              // ปุ่มจัดการข้อมูลสินค้า
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addproduct()),
                  );
                },
                child: Text("จัดการข้อมูลสินค้า"),
              ),
              SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม

              // ปุ่มแสดงข้อมูลสินค้า
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowProduct()),
                  );
                },
                child: Text("แสดงข้อมูลสินค้า"),
              ),
              SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม

              // ปุ่มแสดงประเภทสินค้า
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowProductType()),
                  );
                },
                child: Text("แสดงประเภทสินค้า"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
