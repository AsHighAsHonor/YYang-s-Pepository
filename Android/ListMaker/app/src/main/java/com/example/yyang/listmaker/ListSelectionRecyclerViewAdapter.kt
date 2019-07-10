package com.example.yyang.listmaker

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

interface ListSelectionRecyclerViewClickListener {
    fun listItemClicked(list: TaskList)
}


class ListSelectionRecyclerViewAdapter(val lists : ArrayList<TaskList>, val clickListener: ListSelectionRecyclerViewClickListener) : RecyclerView.Adapter<ListSelectionViewHolder>() {
    val listTitles = arrayOf("Shopping List", "Cores", "Android Tutorials","Shopping List", "Cores", "Android Tutorials","Shopping List", "Cores", "Android Tutorials","Shopping List", "Cores", "Android Tutorials","Shopping List", "Cores", "Android Tutorials")

    override fun onBindViewHolder(holder: ListSelectionViewHolder, position: Int) {
        holder.listPosition.text = (position + 1).toString()
        holder.listTitle.text = lists[position].name
        holder.itemView.setOnClickListener({
            clickListener.listItemClicked(lists[position])
        })
    }

    override fun getItemCount(): Int {
        return lists.count()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListSelectionViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.list_selection_view_holder, parent, false)
        return ListSelectionViewHolder(view)
    }

    fun addList(list: TaskList) {
        // 1
        lists.add(list)
// 2
        notifyDataSetChanged()
    }






}