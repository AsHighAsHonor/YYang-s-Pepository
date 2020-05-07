package com.yyang.dogs.viewmodel

import android.app.Application
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.room.Database
import com.yyang.dogs.database.DogDatabase
import com.yyang.dogs.model.BaseViewModel
import com.yyang.dogs.model.DogBreed
import kotlinx.coroutines.launch

class DetailViewModel(application: Application) : BaseViewModel(application) {

    var dogLiveData = MutableLiveData<DogBreed>()
    var dogUuid: Int? = null

    fun getDogDetail(uuid: Int?) {
        launch {
            uuid?.let {
                dogUuid = it
                val dog = DogDatabase(getApplication()).dogDao().getDog(it)
                dogLiveData.value = dog
            }
        }
    }

}