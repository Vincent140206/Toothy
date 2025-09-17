# Keep Midtrans SDK classes
-keep class id.co.midtrans.** { *; }
-keep class com.midtrans.** { *; }
-dontwarn id.co.midtrans.**
-dontwarn com.midtrans.**

# Keep Flutter related
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Jangan obfuscate model Java
-keep class java.util.** { *; }
