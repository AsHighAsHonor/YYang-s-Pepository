package viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import repository.ItunesRepo
import service.PodcastResponse
import util.DateUtil

class SearchViewModel (application: Application): AndroidViewModel(application){
    var itunesRepo: ItunesRepo? = null

    data class PodcastSummaryViewData(
        var name: String? = "",
        var lastUpdated: String? = "",
        var imageUrl: String? = "",
        var feedUrl: String? = "")

    private fun itunesPodcastToPodcastSummaryView(itunesPodcast: PodcastResponse.ItunesPodcast): PodcastSummaryViewData {
        return PodcastSummaryViewData(
            itunesPodcast.collectionCensoredName,
            DateUtil.DateUtils.jsonDateToShortDate(itunesPodcast.releaseDate),
            itunesPodcast.artworkUrl30,
            itunesPodcast.feedUrl)
    }

    // 1
    fun searchPodcasts(term: String, callback: (List<PodcastSummaryViewData>) -> Unit) {
        // 2
        itunesRepo?.searchByTerm(term, { results ->
            if (results == null) {
                // 3
                callback(emptyList())
            } else {
// 4
                val searchViews = results.map { podcast ->
                    itunesPodcastToPodcastSummaryView(podcast)
                }
// 5
                searchViews.let { it -> callback(it) }
            }
        }) }

}