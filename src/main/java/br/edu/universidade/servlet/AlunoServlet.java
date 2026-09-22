package br.edu.universidade.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import br.edu.universidade.dao.AlunoDAO;
import br.edu.universidade.dao.AlunoDAOImpl;
import br.edu.universidade.model.Aluno;

@WebServlet(name = "alunos", urlPatterns = { "/alunos" })
public class AlunoServlet extends HttpServlet {
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        alunoDAO = new AlunoDAOImpl();
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
                alunoDAO.excluir(id);
            }
            response.sendRedirect("alunos");
            return;
        }

        List<Aluno> alunos = alunoDAO.listar();
        request.setAttribute("alunos", alunos);
        request.getRequestDispatcher("lista.jsp").forward(request, response);
    }

    @Override
    protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response
    ) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String curso = request.getParameter("curso");

        Aluno aluno = new Aluno(nome, email, curso);
        alunoDAO.inserir(aluno);

        response.sendRedirect("alunos");
    }
}
