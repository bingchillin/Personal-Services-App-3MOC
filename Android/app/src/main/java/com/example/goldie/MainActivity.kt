package com.example.goldie

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var loginFragment: LoginFragment

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
        // Implémenter la logique de connexion ici, par exemple, appeler l'API

        // Après une connexion réussie, basculer vers le fragment du connecteur API
        val apiConnectorFragment = ApiConnectorFragment()
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragmentContainer, apiConnectorFragment)
            .addToBackStack(null) // Cela permet la navigation arrière
            .commit()
    }
}
