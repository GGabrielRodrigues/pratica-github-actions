package br.edu.universidade.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Testes Unitários do Modelo Professor")
class ProfessorTest {

    @Test
    @DisplayName("Deve criar professor com dados completos e validar propriedades")
    void testCriacaoProfessorCompleto() {
        LocalDate nascimento = LocalDate.of(1985, 5, 20);
        Professor professor = new Professor(
            1,
            "Dr. Alan Turing",
            nascimento,
            "Londres",
            "M",
            "http://lattes.cnpq.br/123456789"
        );

        assertEquals(1, professor.getId());
        assertEquals("Dr. Alan Turing", professor.getNome());
        assertEquals(nascimento, professor.getDataNascimento());
        assertEquals("Londres", professor.getNaturalidade());
        assertEquals("M", professor.getSexo());
        assertEquals("http://lattes.cnpq.br/123456789", professor.getLinkLattes());
    }

    @Test
    @DisplayName("Deve permitir alterar os atributos do professor via setters")
    void testModificacaoProfessor() {
        Professor professor = new Professor();
        LocalDate nascimento = LocalDate.of(1990, 10, 15);

        professor.setId(5);
        professor.setNome("Dra. Ada Lovelace");
        professor.setDataNascimento(nascimento);
        professor.setNaturalidade("Londres");
        professor.setSexo("F");
        professor.setLinkLattes("http://lattes.cnpq.br/987654321");

        assertEquals(5, professor.getId());
        assertEquals("Dra. Ada Lovelace", professor.getNome());
        assertEquals(nascimento, professor.getDataNascimento());
        assertEquals("Londres", professor.getNaturalidade());
        assertEquals("F", professor.getSexo());
        assertEquals("http://lattes.cnpq.br/987654321", professor.getLinkLattes());
    }
}
