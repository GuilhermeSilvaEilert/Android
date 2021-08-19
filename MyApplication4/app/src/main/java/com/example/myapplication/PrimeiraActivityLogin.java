package com.example.myapplication;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;


public class PrimeiraActivityLogin extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_primeira_login);
    }
    public void ValidaEnvia(View view){
        EditText CampoUsuario = findViewById(R.id.TextoUsuario);
        EditText CampoSenha = findViewById(R.id.Senha);
        TextView UsuSenErr = findViewById(R.id.Incorreto);

        String Usuario = CampoUsuario.getText().toString();
        String Senha = CampoSenha.getText().toString();

        if(Usuario.equals("admin") && (Senha.equals("123"))) {
            Bundle Login = new Bundle();
            Login.putString("DADOS_USUARIO",Usuario);
            Login.putString("DADOS_Senha",Senha);
            Intent intent = new Intent(this, SegundaActivityLogin.class);
            intent.putExtras(Login);
            startActivity(intent);
        }else{
            UsuSenErr.setText("\nSenha ou Usuario Incorretos \n Usuario digitado:"+  Usuario +"\nSenha digitada:" + Senha);
        }
    }

    }
