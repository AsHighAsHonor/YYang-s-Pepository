package com.example.yyang.placebook.ui

import android.app.Dialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.DialogFragment

class PhotoOptionDialogFragment : DialogFragment() {

    // 1
    interface PhotoOptionDialogListener {
        fun onCaptureClick()
        fun onPickClick()
    }

    // 2
    private lateinit var listener: PhotoOptionDialogListener

    // 3
    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
// 4
        listener = activity as PhotoOptionDialogListener // 5
        var captureSelectIdx = -1
        var pickSelectIdx = -1
// 6
        val options = ArrayList<String>() // 7
        this.context?.let {
            if (canCapture(it)) {
                options.add("Camera")
                captureSelectIdx = 0
            }
            if (canPick(it)) {
                options.add("Gallery")
                pickSelectIdx = if (captureSelectIdx == 0) 1 else 0
            }
        }
// 9
        return AlertDialog.Builder(activity!!)
            .setTitle("Photo Option")
            .setItems(options.toTypedArray<CharSequence>()) { _, which ->
                if (which == captureSelectIdx) {
// 10
                    listener.onCaptureClick()
                } else if (which == pickSelectIdx) {
// 11
                    listener.onPickClick()
                }
            }
            .setNegativeButton("Cancel", null).create()
    }

    companion object {
        // 12
        fun canPick(context: Context): Boolean {

            val pickIntent =
                Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
            return (pickIntent.resolveActivity(context.packageManager) != null)
        }

        // 13
        fun canCapture(context: Context): Boolean {
            val captureIntent = Intent(
                MediaStore.ACTION_IMAGE_CAPTURE
            )
            return (captureIntent.resolveActivity(
                context.packageManager
            ) != null)
        }

        // 14
        fun newInstance(context: Context): PhotoOptionDialogFragment? {
            return if (canPick(context) || canCapture(context)) {
                PhotoOptionDialogFragment()
            } else {
                null
            }
        }
    }
}
