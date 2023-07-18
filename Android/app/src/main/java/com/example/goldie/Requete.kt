package com.example.goldie

import com.jakewharton.retrofit2.adapter.kotlin.coroutines.CoroutineCallAdapterFactory
import kotlinx.coroutines.Deferred
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

data class Requete(
    val id: String,
    val client: String,
    val title: String,
    val slots: String,
)

interface RequeteAPI {
    @GET("/requetes") // Modifier l'URL selon le chemin de l'API qui renvoie la liste des utilisateurs
    fun getRequetes(): Deferred<List<Requete>>
}

object NetworkManagerRequete {

    private val api = Retrofit.Builder()
        .baseUrl("http://10.66.125.36:3000/") // Assurez-vous que l'URL de l'API est correcte
        .addConverterFactory(GsonConverterFactory.create())
        .addCallAdapterFactory(CoroutineCallAdapterFactory())
        .build()
        .create(RequeteAPI::class.java)

    fun getRequetes(): Deferred<List<Requete>> {
        return api.getRequetes()
    }
}