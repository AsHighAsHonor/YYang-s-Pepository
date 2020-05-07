package com.example.yyang.placebook.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.yyang.placebook.R
import com.example.yyang.placebook.ui.MapsActivity
import com.example.yyang.placebook.viewmodel.BookMarkView
import kotlinx.android.synthetic.main.bookmark_item.view.*

class BookmarkListAdapter(
    private var bookmarkData: List<BookMarkView>?,
    private val mapsActivity: MapsActivity
) : RecyclerView.Adapter<BookmarkListAdapter.ViewHolder>() {

    class ViewHolder(v: View, private val mapsActivity: MapsActivity) : RecyclerView.ViewHolder(v) {
        val nameTextView: TextView = v.findViewById(R.id.bookmarkNameTextView) as TextView
        val categoryImageView: ImageView = v.findViewById(R.id.bookmarkIcon) as ImageView
        init {
            v.setOnClickListener {
            val bookmarkView = itemView.tag as BookMarkView
            mapsActivity.moveToBookmark(bookmarkView) }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val viewHolder = ViewHolder(
            LayoutInflater.from(parent.context).inflate(R.layout.bookmark_item, parent, false),
            mapsActivity
        )
        return viewHolder
    }

    override fun getItemCount(): Int {
        return bookmarkData?.count() ?: 0
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        bookmarkData?.let {
            val bookmarkViewData = it[position]
            holder.itemView.tag = bookmarkViewData
            holder.nameTextView.text = bookmarkViewData.name
            holder.categoryImageView.setImageResource(R.drawable.ic_other)
        }
    }

    fun setBookmarkData(bookmarks: List<BookMarkView>) {
        this.bookmarkData = bookmarks
        notifyDataSetChanged()
    }


}