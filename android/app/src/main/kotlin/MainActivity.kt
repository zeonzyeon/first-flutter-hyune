package com.example.first_flutter_hyune

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.*

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val channel = BasicMessageChannel<String>(flutterEngine.dartExecutor,"myMessageChannel",
            StringCodec.INSTANCE )
        channel.setMessageHandler { message, reply ->
            Log.d("msg", "receive: $message")
            reply.reply("Reply from Android for First page")
            channel.send("Hello from Android for First page"){replay ->
                Log.d("msg", "reply : $replay")
            }
        }

        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "myMethodChannel")
        methodChannel.setMethodCallHandler { call, result ->
            io.flutter.Log.d("flutter", call.toString())
            if (call.method == "oneMethod") {
                val username = call.argument<String>("Username")
                val password = call.argument<String>("Password")
                if (username == "admin" && password == "1234") {
                    result.success(mapOf("status" to "Success"))
                } else {
                    result.success(mapOf("status" to "Failure"))
                }
                methodChannel.invokeMethod("twoMethod", "Hello from Android for Second Page", object : MethodChannel.Result{
                    override fun success(result: Any?) {
                        io.flutter.Log.d("flutter", "${result as String}")
                    }

                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    }

                    override fun notImplemented() {
                    }
                })
            } else {
                result.notImplemented()
            }
        }


        val eventChannel = EventChannel(flutterEngine.dartExecutor, "eventChannel");
        eventChannel.setStreamHandler( object : EventChannel.StreamHandler {
            private var job: Job? = null
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                job = CoroutineScope(Dispatchers.Default).launch {
                    try {
                        var count = 0
                        while (true) {
                            delay(1000)
                            count++
                            withContext(Dispatchers.Main) {
                                events?.success("Stream Count: $count")
                            }
                        }
                    } catch (e: Exception) {
                        withContext(Dispatchers.Main) {
                            events?.error("ERROR", "Stream Error", e.message)
                        }
                    }
                }
            }
            override fun onCancel(arguments: Any?) {
                job?.cancel()
            }
        })
    }
}

