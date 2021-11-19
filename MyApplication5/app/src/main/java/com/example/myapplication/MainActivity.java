package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.Executors;
import androidx.annotation.Nullable;

public class MainActivity extends AppCompatActivity {

    BancoDeDadosSQL bancoDeDadosSQL = new BancoDeDadosSQL(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void SalvaBancoDados(View view) {

        EditText nome = findViewById(R.id.Nome);

        Pessoa pessoa = new Pessoa();
        pessoa.Nome = nome.getText().toString();

        bancoDeDadosSQL.salvarUsuario(pessoa);

        nome.setText("");

        Intent intent = new Intent(this, MainActivity2.class);
        startActivity(intent);
    }

    public void DeletarPessoa(View view) {
        EditText Deletar = findViewById(R.id.Deletar);

        AlertDialog.Builder builder = new AlertDialog.Builder(this);

            builder.setTitle("Remoção de usuario");

            builder.setMessage("Deseja excluir o usuário ?")
                    .setCancelable(false)
                    .setPositiveButton("SIM", new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int id) {

                            Optional<Pessoa> op = bancoDeDadosSQL.buscaPessoaPeloNome(Deletar.getText().toString());
                            if(op.isPresent()) {
                                bancoDeDadosSQL.excluirUsuarioPeloNome(Deletar.getText().toString());
                                Toast.makeText(MainActivity.this, "usuario excluido", Toast.LENGTH_LONG).show();
                            }else{
                                Toast.makeText(MainActivity.this, "usuario não existe", Toast.LENGTH_LONG).show();
                            }
                        }
                    })
                    .setNegativeButton("Não", new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int id) {
                            dialog.cancel();
                        }
                    });

            AlertDialog alertDialog = builder.create();
            alertDialog.show();

        }


        public void editarPessoa(View view) {

            EditText Id = findViewById(R.id.NomeP);
            EditText NovoNome = findViewById(R.id.NovoNome);

            if(Id.getText().toString().equals("") || NovoNome.getText().toString().equals("")){

                Toast.makeText(MainActivity.this, "Por favor, preencha o campo senha e login para atualizar", Toast.LENGTH_LONG).show();

            }else{

                Pessoa NomeN = new Pessoa();

                NomeN.Nome = NovoNome.getText().toString();

                Optional<Pessoa> op = bancoDeDadosSQL.buscaPessoaPeloNome(NomeN.Nome);
                if(op.isPresent()) {
                    bancoDeDadosSQL.atualizarUsuario(NomeN);
                    Toast.makeText(MainActivity.this, "Atualizacao realizada com sucesso", Toast.LENGTH_LONG).show();
                    Id.setText("");

                }else{
                    Toast.makeText(MainActivity.this, "Pessoa não existe", Toast.LENGTH_LONG).show();
                }


                // bancoDadosUsuario.atualizarUsuarioSenha(login.getText().toString(),senhaParaAtualizar.getText().toString());
            }

        }

    }
