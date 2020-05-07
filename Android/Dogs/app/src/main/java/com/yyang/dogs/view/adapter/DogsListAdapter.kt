package com.yyang.dogs.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.CircularProgressDrawable
import com.yyang.dogs.R
import com.yyang.dogs.databinding.ItemDogBinding
import com.yyang.dogs.model.DogBreed
import com.yyang.dogs.util.getProgressDrawable
import com.yyang.dogs.util.loadImage
import com.yyang.dogs.view.ListFragmentDirections
import com.yyang.dogs.view.SettingFragment
import com.yyang.dogs.view.SettingFragmentDirections
import kotlinx.android.synthetic.main.item_dog.view.*

class DogsListAdapter(val dogsList: ArrayList<DogBreed>) :
    RecyclerView.Adapter<DogsListAdapter.DogViewHolder>(), DogClickListener {

    //    class DogViewHolder(val view: View) : RecyclerView.ViewHolder(view)
    class DogViewHolder(val view: ItemDogBinding) : RecyclerView.ViewHolder(view.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DogViewHolder {
        val inflater = LayoutInflater.from(parent.context)
//        val view = inflater.inflate(R.layout.item_dog, parent, false)
        val view =
            DataBindingUtil.inflate<ItemDogBinding>(inflater, R.layout.item_dog, parent, false)
        return DogViewHolder(view)
    }

    override fun getItemCount(): Int {
        return dogsList.count()
    }

    override fun onBindViewHolder(holder: DogViewHolder, position: Int) {
//        holder.view.name.text = dogsList[position].dogBreed
//        holder.view.lifespan.text = dogsList[position].lifeSpan
//        holder.view.setOnClickListener {
//            val action = ListFragmentDirections.actionDetailFragment()
//            action.dogUuid = dogsList[position].uuid
//            Navigation.findNavController(it).navigate(action)
//        }
//
//        holder.view.imageView.loadImage(dogsList[position].imageUrl, getProgressDrawable(holder.view.context))

        holder.view.dog = dogsList[position]
        holder.view.listener = this
    }

    fun updateDogList(newDogsList: List<DogBreed>) {
        dogsList.removeAll(dogsList)
        dogsList.addAll(newDogsList)
        notifyDataSetChanged()
    }

    override fun onDogViewClicked(view: View) {
        val action = ListFragmentDirections.actionDetailFragment()
        action.dogUuid = view.dogId.text.toString().toInt()
        Navigation.findNavController(view).navigate(action)
    }
}