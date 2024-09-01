import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deeplink/post_detail.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_links2/uni_links.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Deeplink'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imageUrls = [
    'https://picsum.photos/200/100',
    'https://picsum.photos/300/200',
    'https://picsum.photos/400/300',
    'https://picsum.photos/500/400',
    'https://picsum.photos/600/500',
    'https://picsum.photos/200/600',
    'https://picsum.photos/300/700',
    'https://picsum.photos/400/800',
    'https://picsum.photos/500/900',
    'https://picsum.photos/600/1000',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>    
      Future.delayed(const Duration(milliseconds: 1),() async {
        navigateToDetail();
      }
    ));
  }
  
  navigateToDetail()async{
    final appLinks = AppLinks();
    // Subscribe to all events (initial link and further)
    if(Platform.isAndroid){
      // Handling deep links for Android
      appLinks.uriLinkStream.listen((uri) async {
        _handleDeepLink(uri);
      }, onError: (Object err) {
        if (kDebugMode) {
          print('Error handling deep link: $err');
        }
      });
    }
    else if(Platform.isIOS){
      final Uri? initialUri = await getInitialUri();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
      // Subscribe to further links
      uriLinkStream.listen((Uri? uri) async {
        _handleDeepLink(uri);
      }, onError: (Object err) {
        if (kDebugMode) {
          print('Error handling deep link: $err');
        }
      });
    }
  }

  void _handleDeepLink(Uri? uri) async {
    if (uri == null) return;
      List<String> parts = uri.toString().split('id=');
      int? code;
      if (parts.length > 1) {
        code = int.tryParse(parts[1])??0;
      }

    if (code != null) {
      await Get.to(() => PostDetailPage(
          imageUrl: imageUrls[code!], 
          postTitle: 'Post #$code', 
          postDescription: 'This is the detail of post #$code.', 
          index: code,
        ),
        preventDuplicates: false
      );
    } else {
      if (kDebugMode) {
        print('Deep link does not contain an id.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Scrollbar(
        thickness: 10,
        radius: const Radius.circular(2.0),
        child: ListView.builder(
          itemCount: 10, 
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                      imageUrl: imageUrls[index],
                      postTitle: 'Post #$index',
                      postDescription: 'This is the detail of post #$index.', 
                      index: index,
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Image.network(
                          fit: BoxFit.cover,
                          imageUrls[index],
                          height: 100,
                          width: double.infinity,
                        )
                      ),
                      ListTile(
                        title: Text('Post #$index'),
                        subtitle: const Text('This is a random post description.'),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.15),
                        child: ButtonBar(
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
                              icon: const Icon(Icons.share),
                              onPressed: () async{
                                String? postId = index.toString();
                                String url = 'https://sagin-mi.github.io/#/post-detail?id=$postId';
                                Share.share(url, subject: 'Check out this link!');
                              },
                            ),
                          ],
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
