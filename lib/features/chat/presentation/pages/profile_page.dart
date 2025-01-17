import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vibematch/core/theme.dart';

class ProfilePage extends StatelessWidget {
  final String image;
  final String name;
  const ProfilePage({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                image,
                scale: 1.0,
              ),
              maxRadius: 150,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.large,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
