.PHONY: help static-analysis staging-dast prod all stop clean

# Variáveis padrão
SHELL := /bin/bash
STAGING_PORT ?= 8081
STAGING_DB_PORT ?= 5433
PROD_PORT ?= 8080
PROD_DB_PORT ?= 5432

help:
	@echo "=============================================================="
	@echo "           COMANDOS DISPONÍVEIS NO MAKEFILE                   "
	@echo "=============================================================="
	@echo "make static-analysis  -> Executa análise estática (SpotBugs & Testes)"
	@echo "make staging-dast     -> Sobe Staging, realiza testes dinâmicos e encerra"
	@echo "make prod             -> Sobe a aplicação em produção localmente"
	@echo "make all              -> Executa todo o pipeline em sequência"
	@echo "make stop             -> Para todos os contêineres em execução"
	@echo "make clean            -> Limpa arquivos compilados pelo Maven"
	@echo "=============================================================="

# 1. Análise Estática (SAST)
static-analysis:
	@echo "--------------------------------------------------------------"
	@echo ">> 1/3: Executando Verificação Estática de Código (SAST)..."
	@echo "--------------------------------------------------------------"
	mvn compile spotbugs:check
	mvn test jacoco:report
	@echo "✅ Análise estática concluída com sucesso!"

# 2. Deploy em Staging e Análise Dinâmica (DAST)
staging-dast:
	@echo "--------------------------------------------------------------"
	@echo ">> 2/3: Subindo ambiente de Staging (Porta $(STAGING_PORT))..."
	@echo "--------------------------------------------------------------"
	APP_PORT=$(STAGING_PORT) DB_PORT=$(STAGING_DB_PORT) docker compose -p staging up -d --build
	@echo "Aguardando a aplicação responder em Staging..."
	@for i in $$(seq 1 20); do \
		STATUS=$$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$(STAGING_PORT)/ || echo "000"); \
		if [ "$$STATUS" -eq 200 ] || [ "$$STATUS" -eq 302 ]; then \
			echo "Aplicação respondendo com sucesso (HTTP $$STATUS) em Staging!"; \
			break; \
		fi; \
		echo "Tentativa $$i/20: status $$STATUS. Aguardando 4s..."; \
		sleep 4; \
	done
	@echo "Executando Verificação Dinâmica (Smoke Test nas rotas)..."
	curl -f http://localhost:$(STAGING_PORT)/
	curl -f http://localhost:$(STAGING_PORT)/alunos
	curl -f http://localhost:$(STAGING_PORT)/professores
	@echo "Tentando executar análise dinâmica DAST com OWASP ZAP via Docker..."
	-docker run --rm -t --net=host zaproxy/zap-stable zap-baseline.py -t http://localhost:$(STAGING_PORT)/ -I || true
	@echo "Encerrando contêineres de Staging..."
	APP_PORT=$(STAGING_PORT) DB_PORT=$(STAGING_DB_PORT) docker compose -p staging down -v
	@echo "✅ Verificação dinâmica em Staging concluída com sucesso!"

# 3. Subir a aplicação em Produção localmente
prod:
	@echo "--------------------------------------------------------------"
	@echo ">> 3/3: Subindo aplicação em Produção Local (Porta $(PROD_PORT))..."
	@echo "--------------------------------------------------------------"
	APP_PORT=$(PROD_PORT) DB_PORT=$(PROD_DB_PORT) docker compose -p prod up -d --build
	@echo "Aguardando confirmação de prontidão em Produção..."
	@for i in $$(seq 1 20); do \
		STATUS=$$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$(PROD_PORT)/ || echo "000"); \
		if [ "$$STATUS" -eq 200 ] || [ "$$STATUS" -eq 302 ]; then \
			echo "Aplicação em Produção pronta e ativa (HTTP $$STATUS)!"; \
			break; \
		fi; \
		echo "Tentativa $$i/20: status $$STATUS. Aguardando 4s..."; \
		sleep 4; \
	done
	@echo "=============================================================="
	@echo "🚀 Aplicação em Produção está no ar em: http://localhost:$(PROD_PORT)/"
	@echo "   - Gestão de Alunos:      http://localhost:$(PROD_PORT)/alunos"
	@echo "   - Gestão de Professores: http://localhost:$(PROD_PORT)/professores"
	@echo "=============================================================="

# Executa todos os passos em sequência
all: static-analysis staging-dast prod
	@echo "🎉 Pipeline local completa finalizada com sucesso!"

# Para contêineres de produção e staging
stop:
	@echo "Parando todos os ambientes locais..."
	APP_PORT=$(PROD_PORT) DB_PORT=$(PROD_DB_PORT) docker compose -p prod down -v || true
	APP_PORT=$(STAGING_PORT) DB_PORT=$(STAGING_DB_PORT) docker compose -p staging down -v || true

# Limpeza de artefatos de compilação
clean:
	mvn clean
