package com.example.yyang.placebook

import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.api.GoogleApiClient
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.places.Place
import com.google.android.gms.location.places.PlacePhotoMetadata
import com.google.android.gms.location.places.Places
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.BitmapDescriptorFactory
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.gms.maps.model.PointOfInterest

class MapsActivity : AppCompatActivity(), OnMapReadyCallback, GoogleApiClient.OnConnectionFailedListener {

    //    private var locationRequest: LocationRequest? = null
    private lateinit var mMap: GoogleMap
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var googleApiClient: GoogleApiClient


    companion object{
        private const val REQUEST_LOCATION = 1
        private const val TAG = "MapsActivity"
    }



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_maps)
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        val mapFragment = supportFragmentManager
            .findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)
        setupLocationClient()
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
        getCurrentLocation()
        setGoogleClient()
        mMap.setOnPoiClickListener {
//            Toast.makeText(this, it.name, Toast.LENGTH_LONG).show()
            displayPoi(it)
        }
    }

    override fun onConnectionFailed(p0: ConnectionResult) {
        Log.e(TAG, "Google play connection failed: " +
                p0.errorMessage)
    }


    private  fun setupLocationClient(){
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
    }

    private  fun requestLocationPermissions() {
        ActivityCompat.requestPermissions(this,
            arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION),
            REQUEST_LOCATION)
    }

    private fun getCurrentLocation(){
        if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) !=
            PackageManager.PERMISSION_GRANTED){
                requestLocationPermissions()
        }else{
            mMap.isMyLocationEnabled = true

//            if (locationRequest == null){
//                locationRequest = LocationRequest.create()
//                locationRequest?.priority = LocationRequest.PRIORITY_HIGH_ACCURACY
//                locationRequest?.interval = 5000
//                locationRequest?.fastestInterval = 1000
//
//                val locationCallBack = object : LocationCallback() {
//                    override fun onLocationResult(locationResult: LocationResult?) {
//                        getCurrentLocation()
//                    }
//                }
//
//                fusedLocationClient.requestLocationUpdates(locationRequest, locationCallBack, null)
//            }

            fusedLocationClient.lastLocation.addOnCompleteListener{
                if (it.result != null && it.result?.latitude != null && it.result?.longitude != null){
                    val latlng = LatLng(it.result!!.latitude, it.result!!.longitude)
//                    mMap.clear()
//                    mMap.addMarker(MarkerOptions().position(latlng).title("You are here!"))
                    val update = CameraUpdateFactory.newLatLngZoom(latlng, 16.0f)
                    mMap.moveCamera(update)
                }else{
                    Log.e(TAG,"No location found")
                }
            }

        }


    }

    private fun  setGoogleClient(){
        googleApiClient = GoogleApiClient.Builder(this)
            .enableAutoManage(this, this)
            .addApi(Places.GEO_DATA_API)
            .build()
    }

    private fun displayPoi(pointOfInterest: PointOfInterest) {
        // 1
        displayPoiGetPlaceStep(pointOfInterest)

    }

    private fun displayPoiGetPlaceStep(pointOfInterest: PointOfInterest) {
        Places.GeoDataApi.getPlaceById(
            googleApiClient,
            pointOfInterest.placeId
        ).setResultCallback { places ->
                // 3
                if (places.status.isSuccess && places.count > 0) {
                    // 4
                    val place = places.get(0).freeze()
                    displayPoiGetPhotoMetaDataStep(place)
//                    // 5
//                    Toast.makeText(
//                        this,
//                        "${place.name} ${place.phoneNumber}",
//                        Toast.LENGTH_LONG
//                    ).show()
                } else {
                    Log.e(
                        TAG,
                        "Error with getPlaceById ${places.status.statusMessage}"
                    )
                }
    // 6
                places.release()
            }
    }

    private fun displayPoiGetPhotoMetaDataStep(place: Place) {
        Places.GeoDataApi.getPlacePhotos(googleApiClient, place.id)
            .setResultCallback { placePhotoMetadataResult ->
                if (placePhotoMetadataResult.status.isSuccess) {
                    val photoMetadataBuffer =
                        placePhotoMetadataResult.photoMetadata
                    if (photoMetadataBuffer.count > 0) {
                        val photo = photoMetadataBuffer.get(0).freeze()
                        displayPoiGetPhotoStep(place, photo)
                    }
                    photoMetadataBuffer.release()
                }
            } }

    private fun displayPoiGetPhotoStep(place: Place, photo: PlacePhotoMetadata) {
        photo.getScaledPhoto(googleApiClient,
            resources.getDimensionPixelSize(R.dimen.default_image_width),
            resources.getDimensionPixelSize(R.dimen.default_image_height))
            .setResultCallback { placePhotoResult ->
                if (placePhotoResult.status.isSuccess) {
                    val image = placePhotoResult.bitmap
                    displayPoiDisplayStep(place, image)
                } else {
                    displayPoiDisplayStep(place, null)
                } }
    }

    private fun displayPoiDisplayStep(place: Place, photo: Bitmap?) {
        val iconPhoto = if (photo == null) {
            BitmapDescriptorFactory
                .defaultMarker()
        } else {
            BitmapDescriptorFactory.fromBitmap(photo)
        }
        mMap.addMarker(
            MarkerOptions()
            .position(place.latLng)
            .icon(iconPhoto)
            .title(place.name as String?)
            .snippet(place.phoneNumber as String?)
        ) }

}
