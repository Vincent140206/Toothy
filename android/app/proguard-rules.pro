########################################
## ProGuard Rules for Flutter + Midtrans
########################################

# Jangan obfuscate kelas Midtrans SDK
-keep class com.midtrans.sdk.corekit.** { *; }
-keep class com.midtrans.sdk.uikit.** { *; }

# Jangan hilangkan enum (contoh: MidtransEnvironment)
-keepclassmembers enum * { *; }

# Jangan warn kalau ada internal Midtrans yang pakai dependency tertentu
-dontwarn com.midtrans.**
-dontwarn org.jetbrains.annotations.**
-dontwarn kotlin.**

# Biarkan Retrofit / Gson (kadang dipakai Midtrans) tetap jalan
-keep class com.google.gson.** { *; }
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes *Annotation*

# Flutter biasanya butuh ini juga
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Biarkan enum names tetap terbaca (misal status "success", "pending")
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
