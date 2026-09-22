package br.edu.universidade.factory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
    private static final String URL = "jdbc:postgresql://localhost:5432/universidade";
    private static final String USER = "postgres";
    private static final String PASSWORD = "admin123";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Registra o driver explicitamente
        Class.forName("org.postgresql.Driver");
        return DriverManager.getConnection(
            URL,
            USER,
            PASSWORD
        );
    }
}
