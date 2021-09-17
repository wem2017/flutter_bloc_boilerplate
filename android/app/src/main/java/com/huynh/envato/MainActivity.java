package com.huynh.envato;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.media.AudioAttributes;
import android.net.Uri;
import android.os.Build;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            Uri soundUri = Uri.parse( "android.resource://" + this.getContext().getPackageName() + "/" + R.raw.crash);

            AudioAttributes audioAttributes = new AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                    .build();
            NotificationChannel channel = new NotificationChannel("android_channel", "noti_push_app", NotificationManager.IMPORTANCE_HIGH);
            channel.setSound(soundUri, audioAttributes);

            NotificationManager notificationManager = this.getContext().getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(channel);
        }
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}