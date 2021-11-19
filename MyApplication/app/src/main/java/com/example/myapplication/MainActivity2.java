package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity2 extends AppCompatActivity {

    BancoDeDadosSQL bancoDadosUsuario = new BancoDeDadosSQL(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        ListView listView = findViewById(R.id.listaNome);

        List<Pessoa> listaUsuario =  bancoDadosUsuario.listarTodosUsuarios();
        List<String> listaString = new ArrayList<>();

        for(Pessoa user :  listaUsuario){
            listaString.add(user.Nome);
        }


        ArrayAdapter adapter = new ArrayAdapter(this,android.R.layout.simple_spinner_item,listaString);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        listView.setAdapter(adapter);


    }
}