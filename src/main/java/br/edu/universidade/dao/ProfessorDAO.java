package br.edu.universidade.dao;

import java.util.List;
import br.edu.universidade.model.Professor;

public interface ProfessorDAO {
    void inserir(Professor professor);
    List<Professor> listar();
    void excluir(int id);
    void atualizar(Professor professor);
}
