package br.edu.universidade.model;

import java.time.LocalDate;

public class Professor {
    private int id;
    private String nome;
    private LocalDate dataNascimento;
    private String naturalidade;
    private String sexo;
    private String linkLattes;

    public Professor() {
    }

    public Professor(String nome, LocalDate dataNascimento, String naturalidade, String sexo, String linkLattes) {
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.naturalidade = naturalidade;
        this.sexo = sexo;
        this.linkLattes = linkLattes;
    }

    public Professor(int id, String nome, LocalDate dataNascimento, String naturalidade, String sexo, String linkLattes) {
        this.id = id;
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.naturalidade = naturalidade;
        this.sexo = sexo;
        this.linkLattes = linkLattes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getNaturalidade() {
        return naturalidade;
    }

    public void setNaturalidade(String naturalidade) {
        this.naturalidade = naturalidade;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getLinkLattes() {
        return linkLattes;
    }

    public void setLinkLattes(String linkLattes) {
        this.linkLattes = linkLattes;
    }
}
