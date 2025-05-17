import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedIndex = 1; // default to 3 months

  final List<Map<String, String>> plans = [
    {'title': '1 month', 'price': '151.43 INR/wk', 'badge': 'SAVE 45%'},
    {'title': '3 months', 'price': '124.37 INR/wk', 'badge': 'BEST VALUE'},
    {'title': '1 week', 'price': '279 INR', 'badge': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Upgrade to Premium+', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Text(
              'Your likes, up top',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Liked someone amazing? We’ll make sure they see you sooner',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: subscriptionCard(
                      plans[index]['title']!,
                      plans[index]['price']!,
                      plans[index]['badge']!,
                      isSelected,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your payment account will be charged 1599.00 INR for 3 months Bumble Premium+.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Terms & Conditions'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                final selectedPlan = plans[selectedIndex]['title'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected $selectedPlan plan')),
                );
              },
              child: Text('Continue with ${plans[selectedIndex]['title']}', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscriptionCard(String title, String price, String badge, bool isSelected) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.pink : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (badge.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(badge, style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(price, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
