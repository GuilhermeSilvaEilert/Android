package com.example.myapplication;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
import androidx.annotation.Nullable;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BancoDeDadosSQL extends SQLiteOpenHelper {

    private static String NOME_BANCO = "nomes";
    private static int VERSAO = 2;

    public BancoDeDadosSQL(@Nullable Context context) {
        super(context, NOME_BANCO, null, VERSAO);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        String sql = "create table pessoa( pessoa TEXT)";
        sqLiteDatabase.execSQL(sql);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int oldVersion, int newVersion) {

        if(newVersion == 2) {
            String sql = "create table produto( nome TEXT, preco real)";
            sqLiteDatabase.execSQL(sql);
            Log.i("aula","Criando tabela produto na versao " +newVersion );
        }
        if(newVersion == 4){
            String sql = "create table item( nome TEXT, descricao TEXT)";
            sqLiteDatabase.execSQL(sql);
            Log.i("aula","Criando tabela item na versao " +newVersion );
        }

    }

    public void salvarUsuario(Pessoa usuario){
        ContentValues valores = new ContentValues();
        valores.put("pessoa",usuario.Nome);
        final long ret = getWritableDatabase().insert("pessoa", null, valores);
        Log.i("aula","Salvo usuário no banco de dados -  " +  ret);
    }

    public List<Pessoa> listarTodosUsuarios(){
        List<Pessoa> lista = new ArrayList<>();
        String sql = "select * from pessoa";
        Cursor cursor =  getReadableDatabase().rawQuery(sql,null);
        cursor.moveToFirst();
        for(int i=0; i < cursor.getCount(); i++){
            Pessoa usuario = new Pessoa();
            usuario.Nome  = cursor.getString(0);
            lista.add(usuario);
            cursor.moveToNext();
        }
        cursor.close();
        return lista;
    }

    public void excluirUsuarioPeloNome(String pessoa){
        String sql = "delete from pessoa where pessoa = ?";
        getWritableDatabase().execSQL(sql,new String[] {pessoa});
        Log.i("aula","Excluido usuário no banco de dados pelo login -  " +  pessoa);
    }

    public void atualizarUsuario(Pessoa pessoa){
        String sql = "update pessoa set Nome = ? where pessoa = ?";
        getWritableDatabase().execSQL(sql,new String[] {pessoa.Nome});
        Log.i("aula","Atualizado usuário no banco de dados pelo login -  " + pessoa.Nome);
    }

    public Optional<Pessoa> buscaPessoaPeloNome(String Nome){

        Optional<Pessoa> retorno = Optional.empty();
        String sql = "select * from Pessoa where Nome = ? ";
        Cursor cursor =  getReadableDatabase().rawQuery(sql,new String[]{Nome});
        cursor.moveToFirst();
        Pessoa pessoa = new Pessoa();
        for(int i=0; i < cursor.getCount(); i++){
            pessoa.Nome = cursor.getString(0);
            cursor.moveToNext();
            retorno = Optional.of(pessoa);
        }
        cursor.close();
        return retorno;
    }

}
