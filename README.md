# Flutter Deeplink without Firebase

## DeepLinking For Android

- Used app_links: ^6.3.0 package for deepLinking.
# Process For Deeplink in Android.
- Add Below code to AndroidManifest
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_HOST -->
    <data
    android:scheme="https"
    android:host="sagin-mi.github.io" />
</intent-filter>   
<!-- App Links -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" android:host="sagin-mi.github.io"/>
    <data android:scheme="https" />
</intent-filter>
- host = domain.com and pathPrefix = prefix for url
- upload assetlinks.json with details as below file to the domail .well-known folder
 [
  {
    "relation": [
      "delegate_permission/common.handle_all_urls"
    ],
    "target" : { 
      "namespace": "android_app", 
      "package_name": "com.example.flutter_deeplink",
      "sha256_cert_fingerprints": [
        "49:DC:FD:30:70:CD:88:A5:BB:2F:00:CA:22:34:7B:35:F4:22:03:22:26:B1:7F:BE:0F:6D:28:24:9B:5D:2F:21"
      ] 
    }
  }
]
- click share button to share a deeplink
- on click shared link it checks if the app is installed or not in if installed opens the app and redirect to specfic page as per data else opens the link in browser


## DeepLinking For IOS

- Used uni_links2: ^0.6.2 package for deepLinking.
# Process For Deeplink in IOS.
- Add Below code to AndroidManifest
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_HOST -->
    <data
    android:scheme="https"
    android:host="sagin-mi.github.io" />
</intent-filter>   
<!-- App Links -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" android:host="sagin-mi.github.io"/>
    <data android:scheme="https" />
</intent-filter>
- host = domain.com and pathPrefix = prefix for url
- upload apple-app-site-association with details as below file to the domail .well-known folder this aasa file is without extension
- appIds == teamid.packagename
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appIDs": [
          "P5M6BNFGU8.com.yig.mi.goatusdev.101"
        ],
        "paths": [
          "*"
        ],
        "components": [
          {
            "/": "/*"
          }
        ]
      }
    ]
  },
  "webcredentials": {
    "apps": [
      "P5M6BNFGU8.com.yig.mi.goatusdev.101"
    ]
  }
}
- for this need to create identifiers in https://developer.apple.com/account -> identifiers
- then from xcode need to add Associated Domain as host i.e sagin-mi.github.io

- click share button to share a deeplink
- on click shared link it checks if the app is installed or not in if installed opens the app and redirect to specfic page as per data else opens the link in browser
