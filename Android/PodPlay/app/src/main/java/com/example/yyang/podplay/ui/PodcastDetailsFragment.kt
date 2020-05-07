package com.example.yyang.podplay.ui

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.bumptech.glide.Glide
import com.example.yyang.podplay.R
import kotlinx.android.synthetic.main.fragment_podcast_details.*
import viewmodel.PodcastViewModel

class PodcastDetailsFragment : Fragment() {
    private lateinit var podcastViewModel: PodcastViewModel
    companion object {
        fun newInstance(): PodcastDetailsFragment {
            return PodcastDetailsFragment()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 1
        setHasOptionsMenu(true)
        setupViewModel()
    }
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater!!.inflate(R.layout.fragment_podcast_details,
            container, false)
    }
    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        updateControls()
    }
// 2
    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)
        inflater?.inflate(R.menu.menu_details, menu)
    }
    private fun setupViewModel() {
        activity?.let {
            podcastViewModel = ViewModelProviders.of(it).get(PodcastViewModel::class.java)
        }
    }

    private fun updateControls() {
        val viewData = podcastViewModel.activePodcastViewData ?: return
        feedTitleTextView.text = viewData.feedTitle
        feedDescTextView.text = viewData.feedDesc
        activity?.let {
            Glide.with(it).load(viewData.imageUrl)
                .into(feedImageView)
        }
    }



}