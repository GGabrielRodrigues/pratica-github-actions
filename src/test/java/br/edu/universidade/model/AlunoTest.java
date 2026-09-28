package br.edu.universidade.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Testes Unitários do Modelo Aluno")
class AlunoTest {

    @Test
    @DisplayName("Deve criar aluno com dados válidos e recuperar via getters")
    void testCriacaoAlunoCompleto() {
        Aluno aluno = new Aluno(1, "Gabriel Rodrigues", "gabriel@email.com", "Engenharia de Software");

        assertEquals(1, aluno.getId());
        assertEquals("Gabriel Rodrigues", aluno.getNome());
        assertEquals("gabriel@email.com", aluno.getEmail());
        assertEquals("Engenharia de Software", aluno.getCurso());
    }

    @Test
    @DisplayName("Deve criar aluno sem ID e alterar valores via setters")
    void testModificacaoAluno() {
        Aluno aluno = new Aluno("Maria Silva", "maria@email.com", "Ciência da Computação");

        aluno.setId(10);
        aluno.setNome("Maria Santos");
        aluno.setEmail("maria.santos@email.com");
        aluno.setCurso("Sistemas de Informação");

        assertEquals(10, aluno.getId());
        assertEquals("Maria Santos", aluno.getNome());
        assertEquals("maria.santos@email.com", aluno.getEmail());
        assertEquals("Sistemas de Informação", aluno.getCurso());
    }
}
