package com.example.goldie

import com.jakewharton.retrofit2.adapter.kotlin.coroutines.CoroutineCallAdapterFactory
import kotlinx.coroutines.Deferred
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

data class User(
    val id: String,
    val lastname: String,
    val firstname: String,
)

interface UserAPI {
    @GET("/users") // Modifier l'URL selon le chemin de l'API qui renvoie la liste des utilisateurs
    fun getUsers(): Deferred<List<User>>
}

object NetworkManagerNew {

    private val api = Retrofit.Builder()
        .baseUrl("http://10.66.125.36:3000/") // Assurez-vous que l'URL de l'API est correcte
        .addConverterFactory(GsonConverterFactory.create())
        .addCallAdapterFactory(CoroutineCallAdapterFactory())
        .build()
        .create(UserAPI::class.java)

    fun getUsers(): Deferred<List<User>> {
        return api.getUsers()
    }
}