package com.example.goldie

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response
import okio.IOException
import org.json.JSONObject

class MainActivity : AppCompatActivity() {

    private lateinit var loginFragment: LoginFragment
    private val client = OkHttpClient()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Initialiser le fragment de connexion
        loginFragment = LoginFragment()

        // Afficher le fragment de connexion dans le conteneur de fragments
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragmentContainer, loginFragment)
            .commit()
    }

    fun login(email: String, password: String) {
        val jsonBody = JSONObject()
        jsonBody.put("email", email)
        jsonBody.put("password", password)

        val mediaType = "application/json; charset=utf-8".toMediaType()
        val requestBody = RequestBody.create(mediaType, jsonBody.toString())
        val request = Request.Builder()
            .url("http://192.168.0.110:3000/login")
            .post(requestBody)
            .build()

        GlobalScope.launch(Dispatchers.IO) {
            try {
                val response: Response = client.newCall(request).execute()
                val responseData = response.body?.string()
                withContext(Dispatchers.Main) {
                    // Handle the response here on the main thread
                    if (response.isSuccessful) {
                        // Login successful, perform necessary actions
                        // For example, you can parse the responseData if the server returns JSON
                        val jsonResponse = JSONObject(responseData)
                        //val token = jsonResponse.getString("token")
                        // Do something with the token
                    } else {
                        // Login failed, display error message
                        // For example, you can parse the responseData if the server returns JSON
                        val jsonResponse = JSONObject(responseData)
                        val errorMessage = jsonResponse.getString("message")
                        // Show the error message to the user
                    }
                }
            } catch (e: IOException) {
                e.printStackTrace()
                withContext(Dispatchers.Main) {
                    // Handle network errors here on the main thread
                    // Show an error message to the user
                }
            }
        }
    }
}
