package com.example.goldie

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
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

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_fragment)
    }
}

class UsersListFragment : Fragment() {

    private val usersAdapter = ProductsAdapter(object : OnUserClickListener {
        override fun onProductClicked(user: User) {
            // Ouvrir l'écran
            //findNavController().navigate(ProductsListFragmentDirections.actionProductsListFragmentToProductFragment(product.barcode))
        }
    })

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.users_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val list = view.findViewById<RecyclerView>(R.id.users_list)
        list.layoutManager = LinearLayoutManager(requireContext())
        list.adapter = usersAdapter

        // Appel de l'API pour récupérer les utilisateurs et les ajouter à la liste data
        GlobalScope.launch(Dispatchers.Main) {
            try {
                val users = NetworkManagerNew.getUsers().await()
                usersAdapter.setData(users)
            } catch (e: Exception) {
                // Gérer les erreurs ici
            }
        }
    }
}

class ProductsAdapter(private val callback: OnUserClickListener) : RecyclerView.Adapter<UserViewHolder>() {
    private val data = mutableListOf<User>()

    // Cette fonction permet de mettre à jour la liste de données avec de nouveaux utilisateurs
    fun setData(users: List<User>) {
        data.clear()
        data.addAll(users)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        return UserViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.users_list_cell, parent, false)
        )
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        Log.d("ESGI", position.toString())
        val user = data[position]
        holder.update(user)
        holder.itemView.setOnClickListener {
            callback.onProductClicked(user)
        }
    }

    override fun getItemCount(): Int {
        return data.size
    }
}


class UserViewHolder(v: View) : RecyclerView.ViewHolder(v) {

    private val lastname: TextView = v.findViewById(R.id.user_lastname)
    private val firstname: TextView = v.findViewById(R.id.user_firstname)
    private val id: TextView = v.findViewById(R.id.user_id)

    fun update(user: User) {
        lastname.text = user.lastname
        firstname.text = user.firstname
        id.text = user.id
    }

}

interface OnUserClickListener {
    fun onProductClicked(user: User)
}

interface OnRequeteClickListener {
    fun onProductClicked(requete: Requete)
}

class RequetesListFragment : Fragment() {

    private val requeteAdapter = RequetesAdapter(object : OnRequeteClickListener {
        override fun onProductClicked(requete: Requete) {
            // Ouvrir l'écran
            //findNavController().navigate(ProductsListFragmentDirections.actionProductsListFragmentToProductFragment(product.barcode))
        }
    })

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.users_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val list = view.findViewById<RecyclerView>(R.id.users_list)
        list.layoutManager = LinearLayoutManager(requireContext())
        list.adapter = requeteAdapter

        // Appel de l'API pour récupérer les utilisateurs et les ajouter à la liste data
        GlobalScope.launch(Dispatchers.Main) {
            try {
                val requetes = NetworkManagerRequete.getRequetes().await()
                requeteAdapter.setData(requetes)
            } catch (e: Exception) {
                // Gérer les erreurs ici
            }
        }
    }
}

class RequetesAdapter(private val callback: OnRequeteClickListener) : RecyclerView.Adapter<RequeteViewHolder>() {
    private val data = mutableListOf<Requete>()

    // Cette fonction permet de mettre à jour la liste de données avec de nouveaux utilisateurs
    fun setData(requetes: List<Requete>) {
        data.clear()
        data.addAll(requetes)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RequeteViewHolder {
        return RequeteViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.requetes_list_cell, parent, false)
        )
    }

    override fun onBindViewHolder(holder: RequeteViewHolder, position: Int) {
        Log.d("ESGI", position.toString())
        val requete = data[position]
        holder.update(requete)
        holder.itemView.setOnClickListener {
            callback.onProductClicked(requete)
        }
    }

    override fun getItemCount(): Int {
        return data.size
    }
}

class RequeteViewHolder(v: View) : RecyclerView.ViewHolder(v) {

    private val id: TextView = v.findViewById(R.id.requete_id)
    private val client: TextView = v.findViewById(R.id.requete_client)
    private val title: TextView = v.findViewById(R.id.requete_title)

    fun update(requete: Requete) {
        client.text = requete.client
        title.text = requete.title
        id.text = requete.id
    }

}