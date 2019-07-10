package com.example.yyang.listmaker

import android.content.Context
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


class ListDetailFragment : Fragment() {

    private var listener: OnFragmentInteractionListener? = null
    lateinit var listItemsRecyclerView : RecyclerView
    lateinit var list: TaskList

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        arguments?.let {
            list = it.getParcelable(MainActivity.INTENT_LIST_KEY)!!
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_list_detail, container, false)
        view?.let {
            listItemsRecyclerView = it.findViewById(R.id.list_items_reyclerview)
            listItemsRecyclerView.adapter = ListItemsRecyclerViewAdapter(list)
            listItemsRecyclerView.layoutManager = LinearLayoutManager(activity)
        }


        return view
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        if (context is OnFragmentInteractionListener) {
            listener = context
        } else {
            throw RuntimeException(context.toString() + " must implement OnFragmentInteractionListener")
        }
    }

    override fun onDetach() {
        super.onDetach()
        listener = null
    }


    interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        fun onFragmentInteraction(uri: Uri)
    }

    companion object {

        fun newInstance(list: TaskList): ListDetailFragment{
            val fragment = ListDetailFragment()
            val args = Bundle()
            args.putParcelable(MainActivity.INTENT_LIST_KEY, list)
            fragment.arguments = args
            return  fragment
        }

    }

    fun addTask(item: String) {
        list.tasks.add(item)
        val listRecyclerAdapter =  listItemsRecyclerView.adapter as
                ListItemsRecyclerViewAdapter
        listRecyclerAdapter.list = list
        listRecyclerAdapter.notifyDataSetChanged()
    }

}
