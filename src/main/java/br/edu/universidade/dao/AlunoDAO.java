package br.edu.universidade.dao;

import java.util.List;
import br.edu.universidade.model.Aluno;

public interface AlunoDAO {
    void inserir(Aluno aluno);
    List<Aluno> listar();
    void excluir(int id);
    void atualizar(Aluno aluno);
}
