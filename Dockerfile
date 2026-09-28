# ==========================================
# Estágio 1: Build da Aplicação com Maven
# ==========================================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /build

# Copia pom.xml e faz download de dependências (otimização de cache)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia código-fonte e compila gerando o WAR
COPY src ./src
RUN mvn clean package -DskipTests

# ==========================================
# Estágio 2: Runtime com Apache Tomcat 10
# ==========================================
FROM tomcat:10.1-jdk17

LABEL maintainer="Gabriel Rodrigues"
LABEL description="Laboratório de Persistência - Jakarta EE / Tomcat 10"

# Remove apps padrão do Tomcat para evitar conflito na raiz
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o WAR gerado no estágio anterior como aplicação raiz (ROOT.war)
COPY --from=builder /build/target/LaboratorioPersistenciaGabriel.war /usr/local/tomcat/webapps/ROOT.war

# Expõe a porta padrão do Tomcat
EXPOSE 8080

# Inicia o Tomcat em primeiro plano
CMD ["catalina.sh", "run"]
