package com.yyang.dogs.view


import android.opengl.Visibility
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager

import com.yyang.dogs.R
import com.yyang.dogs.view.adapter.DogsListAdapter
import com.yyang.dogs.viewmodel.ListViewModel
import kotlinx.android.synthetic.main.fragment_detail.*
import kotlinx.android.synthetic.main.fragment_list.*

/**
 * A simple [Fragment] subclass.
 */
class ListFragment : Fragment() {

    private lateinit var viewModel: ListViewModel
    private val dogsListAdapter = DogsListAdapter(arrayListOf())

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        setHasOptionsMenu(true)
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(ListViewModel::class.java)
        viewModel.refresh()
        recyclerView.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = dogsListAdapter
        }

        refreshLayout.setOnRefreshListener {
            recyclerView.visibility = View.GONE
            listError.visibility = View.GONE
            loadingView.visibility = View.VISIBLE
            viewModel.refreshByPassCache()
            refreshLayout.isRefreshing = false
        }
        observeViewModel()


    }

    fun observeViewModel() {
        viewModel.dogs.observe(this, Observer {
            it?.let { dogsList ->
                recyclerView.visibility = View.VISIBLE
                dogsListAdapter.updateDogList(dogsList)
            }
        })

        viewModel.dogsLoadError.observe(this, Observer {
            it?.let { res ->
                listError.visibility = if (res) View.VISIBLE else View.GONE
            }
        })

        viewModel.loading.observe(this, Observer {
            it?.let { res ->
                loadingView.visibility = if (res) View.VISIBLE else View.GONE
                if (it) {
                    listError.visibility = View.GONE
                    recyclerView.visibility = View.GONE
                }
            }
        })

    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)
        inflater.inflate(R.menu.list_menu, menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.listToSettingFragment -> {
                view?.let {
                    Navigation.findNavController(it)
                        .navigate(ListFragmentDirections.listToSettingFragment())
                }
            }
        }
        return super.onOptionsItemSelected(item)
    }

}
