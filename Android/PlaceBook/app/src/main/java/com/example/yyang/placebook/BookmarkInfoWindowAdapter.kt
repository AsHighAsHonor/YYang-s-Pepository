package com.example.yyang.placebook

import android.app.Activity
import android.graphics.Bitmap
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.Marker

class BookmarkInfoWindowAdapter(context: Activity): GoogleMap.InfoWindowAdapter {
    private val contens: View

    init {
        contens = context.layoutInflater.inflate(R.layout.content_bookmark_info, null)
    }

    override fun getInfoWindow(p0: Marker?): View? {
        return null
    }

    override fun getInfoContents(p0: Marker?): View {
        val titleView = contens.findViewById<TextView>(R.id.title)
        titleView.text = p0?.title?: ""
        val phoneView =contens.findViewById<TextView>(R.id.phone)
        phoneView.text = p0?.snippet?: ""
        val imageView = contens.findViewById<ImageView>(R.id.phone)
        imageView.setImageBitmap(p0?.tag as Bitmap)

        return contens
    }



}