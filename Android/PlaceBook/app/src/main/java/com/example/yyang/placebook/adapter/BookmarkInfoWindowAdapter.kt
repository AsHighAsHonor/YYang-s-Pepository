package com.example.yyang.placebook.adapter

import android.app.Activity
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.example.yyang.placebook.R
import com.example.yyang.placebook.ui.PlaceInfo
import com.example.yyang.placebook.viewmodel.BookMarkView
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.Marker

class BookmarkInfoWindowAdapter(val context: Activity) : GoogleMap.InfoWindowAdapter {

    private val contents: View

    init {
        contents = context.layoutInflater.inflate(R.layout.content_bookmark_info, null)
    }

    override fun getInfoContents(p0: Marker?): View {
        val titleView = contents.findViewById<TextView>(R.id.title)
        titleView.text = p0?.title
        val phoneView = contents.findViewById<TextView>(R.id.phone)
        phoneView.text = p0?.snippet
        val imageView = contents.findViewById<ImageView>(R.id.photo)
        when (p0?.tag) {
            is  PlaceInfo -> {
                imageView.setImageBitmap((p0?.tag as PlaceInfo).image)
            }
            is BookMarkView -> {
                var bookMarkview = p0.tag as BookMarkView
                imageView.setImageBitmap(bookMarkview.getImage(context))
            }
        }


        return contents
    }

    override fun getInfoWindow(p0: Marker?): View? {
        return null
    }


}