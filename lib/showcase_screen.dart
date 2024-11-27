import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching links

// Define the ProductFeature class
class ProductFeature {
  final String title;
  final String description;
  final String imageUrl;
  final String link;

  ProductFeature({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
  });
}

class ProductFeatureScreen extends StatelessWidget {
  // List of products/features
  final List<ProductFeature> products = [
    ProductFeature(
      title: "Smart Yoga Mat - Version 2.0",
      description: "The latest version of the Smart Yoga Mat with improved sensors and connectivity features.",
      imageUrl: "assets/images/yoga_mat_version_2.png",
      link: "https://www.yogasite.com/product/2.0", // Sample link
    ),
    ProductFeature(
      title: "Breathing Exercise Mode",
      description: "An enhanced breathing exercise mode with real-time feedback.",
      imageUrl: "assets/images/breathing_exercise.png",
      link: "https://www.yogasite.com/features/breathing-exercise", // Sample link
    ),
    ProductFeature(
      title: "Relaxation Mode",
      description: "Relaxation mode with soothing music and haptic feedback to enhance your relaxation.",
      imageUrl: "assets/images/relaxation_mode.png",
      link: "https://www.yogasite.com/features/relaxation-mode", // Sample link
    ),
  ];

  // Function to open the product link
  Future<void> _openLink(BuildContext context, String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch the link.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product & Feature Showcase"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            ProductFeature product = products[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Image.asset(
                    product.imageUrl,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
                  ), // Display product image
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => _openLink(context, product.link),
                          child: const Text("Learn More"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue, // Updated from `primary`
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
