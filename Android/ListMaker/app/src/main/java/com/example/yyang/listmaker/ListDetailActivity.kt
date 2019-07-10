package com.example.yyang.listmaker

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class ListDetailActivity : AppCompatActivity() {
    lateinit var list: TaskList


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_detail)
        list= intent.getParcelableExtra(MainActivity.INTENT_LIST_KEY)
        title = list.name


    }
}