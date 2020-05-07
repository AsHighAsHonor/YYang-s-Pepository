package com.example.yyang.placebook.ui

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.MediaStore
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import androidx.core.content.FileProvider
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.example.yyang.placebook.R
import com.example.yyang.placebook.model.Bookmark
import com.example.yyang.placebook.util.ImageUtils
import com.example.yyang.placebook.viewmodel.BookmarkDetailViewModel
import kotlinx.android.synthetic.main.activity_bookmark_details.*
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.File

class BookmarkDetailsActivity : AppCompatActivity(),
    PhotoOptionDialogFragment.PhotoOptionDialogListener {

    private lateinit var bookmarkDetailsViewModel: BookmarkDetailViewModel
    private var bookmarkDetailsView: BookmarkDetailViewModel.BookmarkDetailsView? = null
    private var photoFile: File? = null

    companion object {
        private const val REQUEST_CAPTURE_IMAGE = 1
        private const val REQUEST_GALLERY_IMAGE = 2
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_bookmark_details)
        setupToolBar()
        setupViewModel()
        getIntentData()
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        val inflater = menuInflater
        inflater.inflate(R.menu.menu_bookmark_details, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.action_save -> {
                saveChanges()
                return true
            }
            else -> return super.onOptionsItemSelected(item)
        }
    }

    override fun onCaptureClick() {
//        Toast.makeText(this, "Camera Capture", Toast.LENGTH_LONG).show()
        // 1
        photoFile = null
        try {
// 2
            photoFile = ImageUtils.createUniqueImageFile(this) // 3
            if (photoFile == null) {
                return
            }
        } catch (ex: java.io.IOException) {
// 4
            return
        }
// 5
        val captureIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE) // 6
        val photoUri = FileProvider.getUriForFile(
            this,
            "com.raywenderlich.placebook.fileprovider",
            photoFile!!
        )
// 7
        captureIntent.putExtra(
            android.provider.MediaStore.EXTRA_OUTPUT,
            photoUri
        )
// 8
        val intentActivities =
            packageManager.queryIntentActivities(captureIntent, PackageManager.MATCH_DEFAULT_ONLY)
        intentActivities
            .map { it.activityInfo.packageName }
            .forEach {
                grantUriPermission(
                    it,
                    photoUri,
                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                )
            }
// 9
        startActivityForResult(captureIntent, REQUEST_CAPTURE_IMAGE)
    }

    override fun onPickClick() {
//        Toast.makeText(this, "Gallery Pick", Toast.LENGTH_LONG).show()
        val pickIntent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
        startActivityForResult(pickIntent, REQUEST_GALLERY_IMAGE)
    }


    override fun onActivityResult(
        requestCode: Int, resultCode: Int,
        data: Intent?
    ) {
        super.onActivityResult(requestCode, resultCode, data) // 1
        if (resultCode == android.app.Activity.RESULT_OK) {
// 2
            when (requestCode) {
                // 3
                REQUEST_CAPTURE_IMAGE -> {
// 4
                    val photoFile = photoFile ?: return
// 5
                    val uri = FileProvider.getUriForFile(
                        this,
                        "com.raywenderlich.placebook.fileprovider",
                        photoFile
                    )
                    revokeUriPermission(
                        uri,
                        Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                    )
// 6
                    val image = getImageWithPath(photoFile.absolutePath)
                    image?.let { updateImage(it) }
                }

                REQUEST_GALLERY_IMAGE -> if (data != null && data.data != null) {
                    data.data?.let {
                        val image = getImageWithAuthority(it)
                        image?.let { im ->
                            updateImage(im)
                        }
                    }

                }
            }
        }
    }

    fun setupToolBar() {
        setSupportActionBar(toolbar)
    }

    fun setupViewModel() {
        bookmarkDetailsViewModel =
            ViewModelProviders.of(this).get(BookmarkDetailViewModel::class.java)
    }

    private fun populateFields() {
        bookmarkDetailsView?.let {
            editTextName.setText(it.name)
            editTextPhone.setText(it.phone)
            editTextNotes.setText(it.notes)
            editTextAddress.setText(it.address)
        }
    }

    private fun populateImageView() {
        bookmarkDetailsView?.let {
            val placeImage = it.getImage(this)
            placeImage?.let {
                imageViewPlace.setImageBitmap(placeImage)
            }
        }
        imageViewPlace.setOnClickListener {
            replaceImage()
        }
    }

    private fun getIntentData() {
        val bookmarkId = intent.getLongExtra(MapsActivity.Companion.EXTRA_BOOKMARK_ID, 0)
        bookmarkDetailsViewModel.getBookmark(bookmarkId)
            ?.observe(this, Observer<BookmarkDetailViewModel.BookmarkDetailsView> {
                it?.let {
                    bookmarkDetailsView = it
                    populateFields()
                    populateImageView()
                }
            })
    }

    private fun saveChanges() {
        val name = editTextName.text.toString()
        if (name.isEmpty()) {
            return
        }
        bookmarkDetailsView?.let { bookmarkView ->
            bookmarkView.name = editTextName.text.toString()
            bookmarkView.notes = editTextNotes.text.toString()
            bookmarkView.address = editTextAddress.text.toString()
            bookmarkView.phone = editTextPhone.text.toString()
            GlobalScope.launch {
                bookmarkDetailsViewModel.updateBookmark(bookmarkView)
            }

        }
        finish()
    }

    private fun replaceImage() {
        PhotoOptionDialogFragment.newInstance(this)
            ?.show(supportFragmentManager, "photoOptionDialog")
    }

    private fun updateImage(image: Bitmap) {
        val bookmarkView = bookmarkDetailsView ?: return imageViewPlace.setImageBitmap(image)
        bookmarkView.setImage(this, image)
    }

    private fun getImageWithPath(filePath: String): Bitmap? {
        return ImageUtils.decodeFileToSize(
            filePath,
            resources.getDimensionPixelSize(R.dimen.default_image_width),
            resources.getDimensionPixelSize(R.dimen.default_image_height)
        )
    }

    private fun getImageWithAuthority(uri: Uri): Bitmap? {
        return ImageUtils.decodeUriStreamToSize(
            uri,
            resources.getDimensionPixelSize(R.dimen.default_image_width),
            resources.getDimensionPixelSize(R.dimen.default_image_height),
            this
        )
    }

}
