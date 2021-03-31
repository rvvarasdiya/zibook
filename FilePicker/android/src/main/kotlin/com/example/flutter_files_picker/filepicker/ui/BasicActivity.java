package com.example.flutter_files_picker.filepicker.ui;

import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.databinding.DataBindingUtil;

import com.example.flutter_files_picker.R;
import com.example.flutter_files_picker.filepicker.local.fragment.BasicFragment;


public class BasicActivity extends AppCompatActivity {
    private static final String TAG = BasicActivity.class.getSimpleName();

    public static Intent createIntent(AppCompatActivity activity) {
        return new Intent(activity, BasicActivity.class);
    }

    // Lifecycle Method ////////////////////////////////////////////////////////////////////////////

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        DataBindingUtil.setContentView(this,R.layout.activity_crop_image);

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction().add(R.id.container, BasicFragment.newInstance()).commit();
        }
/*
    // apply custom font
    FontUtils.setFont(findViewById(R.id.root_layout));*/
        initToolbar();
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return super.onSupportNavigateUp();
    }

    private void initToolbar() {
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        ActionBar actionBar = getSupportActionBar();
        //FontUtils.setTitle(actionBar, "Basic Sample");
        actionBar.setDisplayHomeAsUpEnabled(true);
        actionBar.setHomeButtonEnabled(true);
    }

    public void startResultActivity(Uri uri) {
        if (isFinishing()) return;
        // Start ResultActivity
        //startActivity(ResultActivity.createIntent(this, uri));
    }
}
