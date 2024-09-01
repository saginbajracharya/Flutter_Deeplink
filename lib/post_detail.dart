import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailPage extends StatelessWidget {
  final String imageUrl;
  final int index;
  final String postTitle;
  final String postDescription;

  const PostDetailPage({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.postTitle,
    required this.postDescription, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postTitle),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: Image.network(
                  fit: BoxFit.contain,
                  imageUrl
                )
              )
            )
          ),
          Container(
            color: Colors.grey.withOpacity(0.15),
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    if (kDebugMode) {
                      print('Liked');
                    }  
                    Get.snackbar(
                      '',
                      '',
                      colorText: Colors.white,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      titleText: const Text(
                        'Liked',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white), // Adjust the font size for the title
                      ),
                    );
                  }, 
                  icon: const Icon(Icons.thumb_up)
                ),
                IconButton(
                  onPressed: (){
                    if (kDebugMode) {
                      print('Share');
                    }  
                    String? postId = index.toString();
                    String url = 'https://sagin-mi.github.io/#/post-detail?id=$postId';
                    Share.share(url, subject: 'Check out this link!');
                  }, 
                  icon: const Icon(Icons.share)
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0,right:10.0,bottom: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  postTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  postDescription,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
} 