package br.edu.universidade.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import br.edu.universidade.dao.ProfessorDAO;
import br.edu.universidade.dao.ProfessorDAOImpl;
import br.edu.universidade.model.Professor;

@WebServlet(name = "professores", urlPatterns = { "/professores" })
public class ProfessorServlet extends HttpServlet {
    private ProfessorDAO professorDAO;

    @Override
    public void init() throws ServletException {
        professorDAO = new ProfessorDAOImpl();
    }

    @Override
    protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response
    ) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("excluir".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                professorDAO.excluir(id);
            }
            response.sendRedirect("professores");
            return;
        }

        List<Professor> professores = professorDAO.listar();
        request.setAttribute("professores", professores);
        request.getRequestDispatcher("professores_lista.jsp").forward(request, response);
    }

    @Override
    protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response
    ) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String dataNascimentoStr = request.getParameter("dataNascimento");
        String naturalidade = request.getParameter("naturalidade");
        String sexo = request.getParameter("sexo");
        String linkLattes = request.getParameter("linkLattes");

        LocalDate dataNascimento = null;
        if (dataNascimentoStr != null && !dataNascimentoStr.isEmpty()) {
            dataNascimento = LocalDate.parse(dataNascimentoStr);
        }

        Professor professor = new Professor(nome, dataNascimento, naturalidade, sexo, linkLattes);
        professorDAO.inserir(professor);

        response.sendRedirect("professores");
    }
}
