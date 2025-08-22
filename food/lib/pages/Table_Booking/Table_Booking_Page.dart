import 'package:flutter/material.dart';
import 'package:food/pages/Table_Booking/widget/booking_summary_page.dart';
import 'package:food/pages/Table_Booking/widget/table_grid.dart';

class TableBookingPage extends StatefulWidget {
  const TableBookingPage({super.key});

  @override
  State<TableBookingPage> createState() => _TableBookingPageState();
}

class _TableBookingPageState extends State<TableBookingPage> {
  List<bool> tables = List.generate(25, (index) => false);

  void _confirmBooking() {
    List<int> bookedTables = [];
    for (int i = 0; i < tables.length; i++) {
      if (tables[i]) bookedTables.add(i + 1);
    }

    if (bookedTables.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one table")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingSummaryPage(bookedTables: bookedTables),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          "Reserve a Table",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.redAccent,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const Text(
              "Select Your Table",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TableGrid(
                tables: tables,
                onTap: (index) {
                  setState(() {
                    tables[index] = !tables[index];
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                shadowColor: Colors.redAccent.withOpacity(0.5),
              ),
              onPressed: _confirmBooking,
              child: const Text(
                "Confirm Booking",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
