package br.edu.universidade.factory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
    private static final String HOST = System.getenv().getOrDefault("DB_HOST", "localhost");
    private static final String PORT = System.getenv().getOrDefault("DB_PORT", "5432");
    private static final String DATABASE = System.getenv().getOrDefault("DB_NAME", "universidade");
    private static final String USER = System.getenv().getOrDefault("DB_USER", "postgres");
    private static final String PASSWORD = System.getenv().getOrDefault("DB_PASSWORD", "admin123");

    private static final String URL = "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DATABASE;

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
