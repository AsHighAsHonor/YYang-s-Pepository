package com.yyang.dogs.view

import android.os.Bundle
import androidx.preference.PreferenceFragmentCompat
import com.yyang.dogs.R


class SettingFragment : PreferenceFragmentCompat() {

    override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
        setPreferencesFromResource(R.xml.preference, rootKey)
    }

}
