package com.example.yyang.listmaker

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class TaskList (val name: String, val tasks: ArrayList<String> = ArrayList()) : Parcelable
//{
//
//
//    constructor(parcel: Parcel) : this(
//        parcel.readString(),
//        source.createStringArrayList()
//    )
//
//    override fun writeToParcel(p0: Parcel?, p1: Int) {
//        p0?.writeString(name)
//        p0?.writeStringList(tasks)
//    }
//
//    override fun describeContents(): Int {
//        return 0
//    }
//
//    companion object CREATOR : Parcelable.Creator<TaskList> {
//        override fun createFromParcel(parcel: Parcel): TaskList {
//            return TaskList(parcel)
//        }
//
//        override fun newArray(size: Int): Array<TaskList?> {
//            return arrayOfNulls(size)
//        }
//    }

//}