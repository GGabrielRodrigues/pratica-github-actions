package br.edu.universidade.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import br.edu.universidade.factory.ConnectionFactory;
import br.edu.universidade.model.Professor;

public class ProfessorDAOImpl implements ProfessorDAO {

    @Override
    public void inserir(Professor professor) {
        String sql = "INSERT INTO professor (nome, data_nascimento, naturalidade, sexo, link_lattes) VALUES (?, ?, ?, ?, ?)";
        try (
            Connection conn = ConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, professor.getNome());
            if (professor.getDataNascimento() != null) {
                stmt.setDate(2, Date.valueOf(professor.getDataNascimento()));
            } else {
                stmt.setNull(2, Types.DATE);
            }
            stmt.setString(3, professor.getNaturalidade());
            stmt.setString(4, professor.getSexo());
            stmt.setString(5, professor.getLinkLattes());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Professor> listar() {
        List<Professor> professores = new ArrayList<>();
        String sql = "SELECT id, nome, data_nascimento, naturalidade, sexo, link_lattes FROM professor ORDER BY nome";
        try (
            Connection conn = ConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()
        ) {
            while (rs.next()) {
                Professor professor = new Professor();
                professor.setId(rs.getInt("id"));
                professor.setNome(rs.getString("nome"));
                Date sqlDate = rs.getDate("data_nascimento");
                if (sqlDate != null) {
                    professor.setDataNascimento(sqlDate.toLocalDate());
                }
                professor.setNaturalidade(rs.getString("naturalidade"));
                professor.setSexo(rs.getString("sexo"));
                professor.setLinkLattes(rs.getString("link_lattes"));
                professores.add(professor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return professores;
    }

    @Override
    public void excluir(int id) {
        String sql = "DELETE FROM professor WHERE id = ?";
        try (
            Connection conn = ConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void atualizar(Professor professor) {
        String sql = "UPDATE professor SET nome = ?, data_nascimento = ?, naturalidade = ?, sexo = ?, link_lattes = ? WHERE id = ?";
        try (
            Connection conn = ConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, professor.getNome());
            if (professor.getDataNascimento() != null) {
                stmt.setDate(2, Date.valueOf(professor.getDataNascimento()));
            } else {
                stmt.setNull(2, Types.DATE);
            }
            stmt.setString(3, professor.getNaturalidade());
            stmt.setString(4, professor.getSexo());
            stmt.setString(5, professor.getLinkLattes());
            stmt.setInt(6, professor.getId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
