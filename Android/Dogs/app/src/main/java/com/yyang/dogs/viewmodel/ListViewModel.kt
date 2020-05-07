package com.yyang.dogs.viewmodel

import android.app.Application
import android.widget.Toast
import androidx.lifecycle.MutableLiveData
import com.yyang.dogs.database.DogDatabase
import com.yyang.dogs.model.BaseViewModel
import com.yyang.dogs.model.DogBreed
import com.yyang.dogs.service.DogsApiService
import com.yyang.dogs.util.NotificationHelper
import com.yyang.dogs.util.SharedPreferencesHelper
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.observers.DisposableSingleObserver
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.launch
import java.lang.NumberFormatException

class ListViewModel(application: Application) : BaseViewModel(application) {

    val dogs = MutableLiveData<List<DogBreed>>()
    val dogsLoadError = MutableLiveData<Boolean>()
    val loading = MutableLiveData<Boolean>()

    private val dogsService = DogsApiService()
    private val disposable = CompositeDisposable()
    private val prefHelper = SharedPreferencesHelper()
    private var refreshTime = 5 * 60 * 1000 * 1000 * 1000L

    fun refresh() {
        checkCacheDuration()
        val updateTime = prefHelper.getUpdateTime()
        if (updateTime != null && updateTime != 0L && System.nanoTime() - updateTime < refreshTime) {
            fetchFromDatabase()
        } else {
            fetchFromRemote()
        }
    }

    fun refreshByPassCache() {
        fetchFromRemote()
    }

    private fun fetchFromDatabase() {
        loading.value = true
        launch {
            val dogs = DogDatabase(getApplication()).dogDao().getAllDogs()
            dogsRetrieved(dogs)
            Toast.makeText(getApplication(), "Dogs get from database", Toast.LENGTH_LONG).show()
        }
    }

    private fun fetchFromRemote() {
        loading.value = true
        disposable.add(
            dogsService.getDogs()
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(object : DisposableSingleObserver<List<DogBreed>>() {
                    override fun onSuccess(t: List<DogBreed>) {
                        storeDogsLocally(t)
                        Toast.makeText(getApplication(), "Dogs get from endpoint", Toast.LENGTH_LONG).show()
                        NotificationHelper(getApplication()).createNotification()
                    }
                    override fun onError(e: Throwable) {
                        loading.value = false
                        dogsLoadError.value = true
                        e.printStackTrace()
                    }
                })
        )
    }

    fun checkCacheDuration() {
        val cachePreference = prefHelper.getCacheDuration()
        try {
            val cachePreferenceInt = cachePreference?.toInt() ?: 5 * 60
            refreshTime = cachePreferenceInt.times(1000 * 1000 * 1000L)
        } catch (e: NumberFormatException) {
            e.printStackTrace()
        }

    }

    private fun dogsRetrieved(dogList: List<DogBreed>) {
        dogs.value = dogList
        loading.value = false
        dogsLoadError.value = false
    }

    private fun storeDogsLocally(list: List<DogBreed>) {
        launch {
            val dao = DogDatabase(getApplication()).dogDao()
            dao.deleteAllDog()
            var result = dao.insertAll(*list.toTypedArray())
            var i = 0
            while (i < list.size) {
                list[i].uuid = result[i].toInt()
                i++
            }
            dogsRetrieved(list)
        }
        prefHelper.saveUpdateTime(System.nanoTime())
    }

    override fun onCleared() {
        super.onCleared()
        disposable.clear()
    }

}