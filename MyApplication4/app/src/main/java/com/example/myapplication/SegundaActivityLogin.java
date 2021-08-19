package com.example.myapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class SegundaActivityLogin extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_segunda_login);

            String Usuario = (String) getIntent().getSerializableExtra("DADOS_USUARIO");
            String Senha = (String) getIntent().getSerializableExtra("DADOS_Senha");

            TextView TextUsuario = findViewById(R.id.TextoUsuario);
            TextView TextSenha = findViewById(R.id.SenhaDigitada);

            TextUsuario.setText(Usuario);
            TextSenha.setText(Senha);
        }

}