package com.bear.demo;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import com.lib.net.Util;

public class Test extends Activity {


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        Log.d("Test", Util.LIB_NAME);
    }

    public void onResume() {
        super.onResume();
    }

}
