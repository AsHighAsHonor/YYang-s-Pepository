package com.example.yyang.podplay.ui

import adapter.PodcastListAdapter
import android.app.SearchManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.SearchView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.yyang.podplay.R
import kotlinx.android.synthetic.main.activity_main.*
import repository.ItunesRepo
import repository.PodcastRepo
import service.ItunesService
import viewmodel.PodcastViewModel
import viewmodel.SearchViewModel



class MainActivity : AppCompatActivity(), PodcastListAdapter.PodcastListAdapterListener {
    companion object {
        private val TAG_DETAILS_FRAGMENT = "DetailsFragment"
    }
    private lateinit var searchViewModel: SearchViewModel
    private lateinit var podcastListAdapter: PodcastListAdapter
    private lateinit var searchMenuItem: MenuItem
    private lateinit var podcastViewModel: PodcastViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setupToolbar()
        setupViewModels()
        updateControls()
        handleIntent(intent)
        addBackStackListener()
    }


    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // 1
        val inflater = menuInflater
        inflater.inflate(R.menu.menu_search, menu)
        // 2
        searchMenuItem = menu.findItem(R.id.search_item)
        val searchView = searchMenuItem.actionView as SearchView
        // 3
        val searchManager = getSystemService(Context.SEARCH_SERVICE)
                as SearchManager
        // 4
        searchView.setSearchableInfo(
            searchManager.getSearchableInfo(componentName))
        if (podcastRecyclerView.visibility == View.INVISIBLE) {
            searchMenuItem.isVisible = false
        }
        return true
    }

    private fun performSearch(term: String) {
        showProgressBar()
        searchViewModel.searchPodcasts(term, { results ->
            hideProgressBar()
            toolbar.title = getString(R.string.search_results)
            podcastListAdapter.setSearchData(results)
        })
    }

    private fun handleIntent(intent: Intent) {
        if (Intent.ACTION_SEARCH == intent.action) {
            val query = intent.getStringExtra(SearchManager.QUERY)
            performSearch(query)
        }
    }


    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleIntent(intent)
    }


    private fun setupToolbar() {
        setSupportActionBar(toolbar)
    }

    private fun setupViewModels() {
        val service = ItunesService.instance
        searchViewModel = ViewModelProviders.of(this).get(
            SearchViewModel::class.java)
        searchViewModel.itunesRepo = ItunesRepo(service)
        podcastViewModel = ViewModelProviders.of(this)
            .get(PodcastViewModel::class.java)
        podcastViewModel.podcastRepo = PodcastRepo()
    }

    private fun updateControls() {
        val layoutManager = LinearLayoutManager(this)
        podcastRecyclerView.layoutManager = layoutManager
        podcastListAdapter = PodcastListAdapter(null, this, this)
        podcastRecyclerView.adapter = podcastListAdapter
    }

    override fun onShowDetails(podcastSummaryViewData: SearchViewModel.PodcastSummaryViewData) {
// 1
        val feedUrl = podcastSummaryViewData.feedUrl ?: return
        // 2
        showProgressBar()
        // 3
        podcastViewModel.getPodcast(podcastSummaryViewData, {
            // 4
            hideProgressBar()
            if (it != null) {
// 5
                showDetailsFragment()
            } else {
// 6
                showError("Error loading feed $feedUrl")
            }
        }) }

    private fun showProgressBar() {
        progressBar.visibility = View.VISIBLE
    }
    private fun hideProgressBar() {
        progressBar.visibility = View.INVISIBLE
    }


    private fun createPodcastDetailsFragment():
            PodcastDetailsFragment {
// 1
        var podcastDetailsFragment = supportFragmentManager
            .findFragmentByTag(TAG_DETAILS_FRAGMENT) as
                PodcastDetailsFragment?
// 2
        if (podcastDetailsFragment == null) {
            podcastDetailsFragment = PodcastDetailsFragment.newInstance()
        }
        return podcastDetailsFragment
    }

    private fun showDetailsFragment() {
        // 1
        val podcastDetailsFragment = createPodcastDetailsFragment()
        // 2
        supportFragmentManager.beginTransaction()
            .add(R.id.podcastDetailsContainer, podcastDetailsFragment, TAG_DETAILS_FRAGMENT)
            .addToBackStack("DetailsFragment").commit()
        podcastRecyclerView.visibility = View.INVISIBLE
// 4
        searchMenuItem.isVisible = false
    }

    private fun showError(message: String) {
        AlertDialog.Builder(this)
            .setMessage(message)
            .setPositiveButton(getString(R.string.ok_button), null)
            .create()
            .show()
    }

    private fun addBackStackListener() {
        supportFragmentManager.addOnBackStackChangedListener {
            if (supportFragmentManager.backStackEntryCount == 0) {
                podcastRecyclerView.visibility = View.VISIBLE
            }
        }
    }
}
