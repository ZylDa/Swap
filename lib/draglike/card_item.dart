import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread of the shadow
            blurRadius: 5, // Blur radius of the shadow
            offset: const Offset(0, 3), // Offset of the shadow
          ),
        ],
      ), // Add shadow to the card
      child: Column(
        children: [
          const Row(
            children: [
              Text('Justin'),
            ],
          ),
          // Row with an image
          Row(
            children: [
              Container(
                width: 261, // Set the width of the image container
                height: 268, // Set the height of the image container
                child: Image.network(
                  'https://example.com/your_image_url.jpg', // Replace with your image URL
                  fit: BoxFit.cover, // Fit the image within the container
                ),
              ),
            ],
          ),
          // First row of text
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '卡帶',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          // Second row of text
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '生活用品、黑色、黃色',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
