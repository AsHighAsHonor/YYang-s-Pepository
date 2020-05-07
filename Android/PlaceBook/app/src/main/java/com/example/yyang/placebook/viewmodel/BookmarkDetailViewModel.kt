package com.example.yyang.placebook.viewmodel

import android.app.Application
import android.content.Context
import android.graphics.Bitmap
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.Transformations
import com.example.yyang.placebook.model.Bookmark
import com.example.yyang.placebook.repository.BookmarkRepo
import com.example.yyang.placebook.util.ImageUtils

class BookmarkDetailViewModel(application: Application) : AndroidViewModel(application) {

    private var bookmarkRepo = BookmarkRepo(getApplication())
    private var bookmarkDetailsView: LiveData<BookmarkDetailsView>? = null

    data class BookmarkDetailsView(
        var id: Long? = null,
        var name: String = "",
        var phone: String = "",
        var address: String = "",
        var notes: String = ""
    ) {
        fun getImage(context: Context): Bitmap? {
            id?.let {
                return ImageUtils.loadBitmapFromFile(context, Bookmark.generateImageFilename(it))
            }
            return null
        }
        fun setImage(context: Context, image: Bitmap) {
            id?.let {
                ImageUtils.saveBitmapToFile(context, image, Bookmark.generateImageFilename(it))
            }
        }
    }

    private fun bookmarkToBookmarkView(bookmark: Bookmark): BookmarkDetailsView {
        return BookmarkDetailsView(
            bookmark.id,
            bookmark.name,
            bookmark.phone,
            bookmark.address,
            bookmark.notes
        )
    }

    private fun mapBookmarkToBookmarkView(bookmarkId: Long) {
        val bookmark = bookmarkRepo.getLiveBookmark(bookmarkId)
        bookmarkDetailsView = Transformations.map(bookmark) { bookmark ->
            val bookmarkView = bookmarkToBookmarkView(bookmark)
            bookmarkView
        }
    }

    fun getBookmark(bookmarkId: Long): LiveData<BookmarkDetailsView>?{
        if (bookmarkDetailsView == null){
            mapBookmarkToBookmarkView(bookmarkId)
        }
        return  bookmarkDetailsView
    }

    private fun bookmarkViewToBookmark(bookmarkView: BookmarkDetailsView): Bookmark? {
        val bookmark = bookmarkView.id?.let {
            bookmarkRepo.getBookmark(it)
        }
        bookmark?.let {
            it.id = bookmarkView.id
            it.name = bookmarkView.name
            it.phone = bookmarkView.phone
            it.address = bookmarkView.address
            it.notes = bookmarkView.address
        }
        return bookmark
    }

    fun updateBookmark(bookmarkView: BookmarkDetailsView) {
        val bookmark = bookmarkViewToBookmark(bookmarkView)
        bookmark?.let { bookmarkRepo.updateBookmark(it) }
    }
}


