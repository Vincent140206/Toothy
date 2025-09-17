# Midtrans SDK
-keep class id.co.midtrans.** { *; }
-keep class com.midtrans.** { *; }
-keep class id.co.veritrans.** { *; }
-dontwarn id.co.midtrans.**
-dontwarn com.midtrans.**
-dontwarn id.co.veritrans.**

# Gson
-keep class com.google.gson.** { *; }
-keepattributes *Annotation*
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keep class * implements com.google.gson.InstanceCreator
-dontwarn com.google.gson.**

# OkHttp & Retrofit
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class retrofit2.** { *; }
-keep interface retrofit2.** { *; }
-dontwarn retrofit2.**
-keep class retrofit2.converter.gson.** { *; }

# Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Parcelable
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Keep your app models (ubah package sesuai projectmu)
-keep class com.toothy.data.models.** { *; }
