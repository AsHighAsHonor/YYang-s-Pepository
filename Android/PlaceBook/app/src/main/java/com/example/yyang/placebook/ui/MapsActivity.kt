package com.example.yyang.placebook.ui

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.location.Location
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.yyang.placebook.R
import com.example.yyang.placebook.adapter.BookmarkInfoWindowAdapter
import com.example.yyang.placebook.adapter.BookmarkListAdapter
import com.example.yyang.placebook.viewmodel.BookMarkView
import com.example.yyang.placebook.viewmodel.MapsViewModel
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.api.GoogleApiClient
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationServices
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.*
import com.google.android.libraries.places.api.Places
import com.google.android.libraries.places.api.model.Place
import com.google.android.libraries.places.api.net.FetchPhotoRequest
import com.google.android.libraries.places.api.net.FetchPlaceRequest
import com.google.android.libraries.places.api.net.PlacesClient
import kotlinx.android.synthetic.main.activity_maps.*
import kotlinx.android.synthetic.main.drawer_view_maps.*
import kotlinx.android.synthetic.main.main_view_maps.*
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch


class MapsActivity : AppCompatActivity(), OnMapReadyCallback,
    GoogleApiClient.OnConnectionFailedListener {

    private lateinit var mMap: GoogleMap
    private lateinit var fusedLocationProviderClient: FusedLocationProviderClient
    private var locationResult: LocationRequest? = null
    private lateinit var placesClient: PlacesClient
    private lateinit var mapsViewModel: MapsViewModel
    private lateinit var bookmarkListAdapter: BookmarkListAdapter
    private var markers = HashMap<Long, Marker>()

    companion object {
        private const val REQUEST_LOCATION = 1
        private const val TAG = "MapsActivity"
        const val EXTRA_BOOKMARK_ID = "com.yyang.placebook.EXTRA_BOOKMARK_ID"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_maps)
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        val mapFragment = supportFragmentManager
            .findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)
        setupLocationClient()
        requestLocationPermission()
        // Initialize the SDK
        Places.initialize(this, getString(R.string.google_places_key))
        setupToolbar()
        setupNavigationDrawer()
    }

    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
        setupMapListeners()
        getCurrentLocation()
        setupGoogleClient()
        setupViewModel()
        createBookmarkObserver()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_LOCATION && grantResults.size == 1 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            getCurrentLocation()
        } else {
            println("Location permission denied")
        }
    }

    override fun onConnectionFailed(p0: ConnectionResult) {
        Log.e(TAG, "Google play connection failed: " + p0.errorMessage)
    }


    private fun setupGoogleClient() {
        placesClient = Places.createClient(this)
    }


    private fun setupLocationClient() {
        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this)
    }

    private fun requestLocationPermission() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
            REQUEST_LOCATION
        )
    }

    private fun getCurrentLocation() {
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            requestLocationPermission()
        } else {
            fusedLocationProviderClient.lastLocation.addOnCompleteListener {
                if (it.result != null) {
                    val latlng =
                        LatLng((it.result as Location).latitude, (it.result as Location).longitude)
                    val update = CameraUpdateFactory.newLatLngZoom(latlng, 16.0f)
                    mMap.moveCamera(update)
                } else {
                    println("No location found")
                }
            }
        }
    }

    private fun displayPoiGetPlaceStep(pointOfInterest: PointOfInterest) {
        val placeFields = arrayOf(
            Place.Field.ID,
            Place.Field.NAME,
            Place.Field.PHOTO_METADATAS,
            Place.Field.LAT_LNG
        )
        var request = FetchPlaceRequest.newInstance(
            pointOfInterest.placeId,
            placeFields.toMutableList()
        )

        placesClient.fetchPlace(request)
            .addOnSuccessListener {
                val place = it.place
                Toast.makeText(this, "${place.name} ${place.phoneNumber}", Toast.LENGTH_LONG).show()
                displayPoiGetPhotoMetaDataStep(place)
            }
            .addOnFailureListener {
                Log.e(TAG, "${it.localizedMessage}")
            }

    }

    private fun displayPoiGetPhotoMetaDataStep(place: Place) {
        place.photoMetadatas?.let { metaDatas ->
            if (metaDatas.isNotEmpty()) {
                val data = metaDatas.first()
                var request = FetchPhotoRequest
                    .builder(data)
                    .setMaxHeight(R.dimen.default_image_height)
                    .setMaxWidth(R.dimen.default_image_width)
                    .build()

                placesClient.fetchPhoto(request)
                    .addOnSuccessListener {
                        val image = it.bitmap
                        displayPoiDisplayStep(place, image)

                    }.addOnFailureListener {
                        Log.e(TAG, "${it.localizedMessage}")
                        displayPoiDisplayStep(place, null)
                    }
            }
        }
    }

    fun displayPoiDisplayStep(place: Place, photo: Bitmap?) {
        val iconPhoto = if (photo == null) {
            BitmapDescriptorFactory.defaultMarker()
        } else {
            BitmapDescriptorFactory.fromBitmap(photo)
        }
        place.latLng?.let {
            val option = MarkerOptions()
                .position(it)
                .title(place.name)
                .snippet(place.phoneNumber)
            val marker = mMap.addMarker(option)
            marker?.tag = PlaceInfo(place, photo)
            marker?.showInfoWindow()
        }

    }

    fun setupViewModel() {
        mapsViewModel = ViewModelProviders.of(this).get(MapsViewModel::class.java)
    }

    private fun setupMapListeners() {
        mMap.isMyLocationEnabled = true
        mMap.setInfoWindowAdapter(BookmarkInfoWindowAdapter(this))
        mMap.setOnPoiClickListener {
            displayPoiGetPlaceStep(it)
        }
        mMap.setOnInfoWindowClickListener {
            handleInfoWindowClick(it)
        }
    }

    private fun handleInfoWindowClick(marker: Marker) {
        when (marker.tag) {

            is PlaceInfo -> {
                val placeInfo = (marker.tag as PlaceInfo)
                if (placeInfo.place != null && placeInfo.image != null) {
                    GlobalScope.launch {
                        mapsViewModel.addBookmarkFromPlace(placeInfo.place, placeInfo.image)
                    }
                }
                marker.remove()
            }

            is BookMarkView -> {
                val bookmarkMarkerView = marker.tag as BookMarkView
                marker.hideInfoWindow()
                bookmarkMarkerView.id?.let {
                    startBookmarkDetails(it)
                }
            }

        }


    }

    private fun addPlaceMarker(bookmark: BookMarkView): Marker? {
        val marker = mMap.addMarker(
            MarkerOptions()
                .position(bookmark.location)
                .title(bookmark.name)
                .snippet(bookmark.phone)
                .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE))
                .alpha(0.8f)
        )
        marker.tag = bookmark
        bookmark.id?.let {
            markers.put(it, marker)
        }
        return marker
    }

    private fun displayAllBookmarks(bookmarks: List<BookMarkView>) {
        for (bookmark in bookmarks) {
            addPlaceMarker(bookmark)
        }
    }

    private fun createBookmarkObserver() {
        mapsViewModel.getBookmarkViews()?.observe(
            this,
            androidx.lifecycle.Observer<List<BookMarkView>> {
                mMap.clear()
                it?.let {
                    displayAllBookmarks(it)
                    bookmarkListAdapter.setBookmarkData(it)
                }
            })
    }

    private fun startBookmarkDetails(bookmarkId: Long) {
        val intent = Intent(this, BookmarkDetailsActivity::class.java)
        intent.putExtra(EXTRA_BOOKMARK_ID, bookmarkId)
        startActivity(intent)
    }

    private fun setupToolbar() {
        setSupportActionBar(toolbar)
        val toggle = ActionBarDrawerToggle(
            this,
            drawerLayout,
            toolbar,
            R.string.open_drawer,
            R.string.close_drawer
        )
        toggle.syncState()
    }

    fun setupNavigationDrawer() {

        bookmarkRecyclerView.layoutManager = LinearLayoutManager(this)
        bookmarkListAdapter = BookmarkListAdapter(null, this)
        bookmarkRecyclerView.adapter = bookmarkListAdapter

    }

    fun updateMapToLoaction(location: Location) {
        val latlng = LatLng(location.latitude, location.longitude)
        val update = CameraUpdateFactory.newLatLngZoom(latlng, 16.0f)
        mMap.animateCamera(update)
    }

    fun moveToBookmark(bookmark: BookMarkView) {
        drawerLayout.closeDrawer(drawerView)
        markers[bookmark.id]?.showInfoWindow()
        val location = Location("")
        location.latitude = bookmark.location.latitude
        location.longitude = bookmark.location.longitude
        updateMapToLoaction(location)

    }

}

class PlaceInfo(
    val place: Place? = null,
    val image: Bitmap? = null
)
