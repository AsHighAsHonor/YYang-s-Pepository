package com.example.yyang.placebook.viewmodel

import android.app.Application
import android.content.Context
import android.graphics.Bitmap
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.Transformations
import com.example.yyang.placebook.model.Bookmark
import com.example.yyang.placebook.repository.BookmarkRepo
import com.example.yyang.placebook.util.ImageUtils
import com.google.android.gms.maps.model.LatLng
import com.google.android.libraries.places.api.model.Place

class MapsViewModel(application: Application): AndroidViewModel(application) {

    private val TAG = "MapsViewModel"
    private var bookmarkRepo: BookmarkRepo = BookmarkRepo(getApplication())
    private var bookmarks: LiveData<List<BookMarkView>>? = null

    fun addBookmarkFromPlace(place: Place, image: Bitmap) {
        var bookmark = bookmarkRepo.createBookmark()
        bookmark.placeId = place.id
        bookmark.name = place.name ?: ""
        bookmark.longitue = place.latLng?.longitude ?: 1.0
        bookmark.latitude = place.latLng?.latitude ?: 1.0
        bookmark.phone = place.phoneNumber.toString()
        bookmark.address = place.address.toString()
        val newId = bookmarkRepo.addBookmark(bookmark)
        bookmark.setImage(image, getApplication())
        Log.i(TAG, "New bookmark $newId added to the database.")
    }

    private fun bookmarkToMarkerView(bookmark: Bookmark): BookMarkView {
        return BookMarkView( bookmark.id,
            LatLng(bookmark.latitude, bookmark.longitue), bookmark.name, bookmark.phone)
    }

    private fun mapBookmarksToBookmarkView() {
        val allBookmarks = bookmarkRepo.allBookmarks
        bookmarks = Transformations.map(allBookmarks) { bookmarks ->
            val bookmarkMarkerViews = bookmarks.map { bookmark ->
                bookmarkToMarkerView(bookmark)
            }
            bookmarkMarkerViews
        }
    }

    fun getBookmarkViews(): LiveData<List<BookMarkView>>? {
        if (bookmarks == null) {
            mapBookmarksToBookmarkView()
        }
        return bookmarks
    }

}

data class BookMarkView(var id: Long? = null, var location: LatLng = LatLng(0.0, 0.0), var name: String?, var phone: String?) {
    fun getImage(context: Context): Bitmap? {
        id?.let {
            return  ImageUtils.loadBitmapFromFile(context, Bookmark.generateImageFilename(it))
        }

        return null
    }
}