# Resolução da Atividade Prática de CI/CD no GitHub Actions

Este documento descreve detalhadamente as etapas, decisões técnicas e ferramentas empregadas para cumprir integralmente os requisitos da atividade de Implantação e Entrega Contínua de Software. O projeto escolhido para a implementação foi o sistema de persistência universitária desenvolvido originalmente na disciplina de Software para Persistência de Dados, sob orientação do professor Elias Batista. A aplicação é baseada em Java 17, utilizando Jakarta EE com Servlets, JSTL e banco de dados PostgreSQL.

## Conteinerização da Aplicação com Docker e Docker Compose

Para viabilizar a implantação contínua e a execução local da aplicação, foi desenvolvido um Dockerfile baseado na estratégia de *multi-stage build*. No primeiro estágio, uma imagem oficial do Maven com Eclipse Temurin 17 é encarregada de baixar as dependências e compilar o código-fonte, gerando o arquivo executável no formato WAR. No segundo estágio, utiliza-se a imagem leve do Apache Tomcat 10.1, para onde o artefato compilado é transferido com a nomenclatura `ROOT.war`, garantindo que a aplicação responda diretamente na raiz do servidor web pela porta 8080.

A orquestração do ambiente foi configurada por meio do Docker Compose, integrando o contêiner da aplicação Java ao banco de dados relacional PostgreSQL na versão 16. Foi criado um script SQL de inicialização responsável por criar as tabelas de alunos e professores, além de popular dados preliminares. Para permitir que o sistema opere tanto em ambiente local convencional quanto dentro de redes conteinerizadas, a classe `ConnectionFactory` foi refatorada para ler parâmetros de conexão a partir de variáveis de ambiente com valores padrão de contingência.

## Estrutura do Pipeline de CI/CD no GitHub Actions

O pipeline automatizado foi definido no arquivo `.github/workflows/ci-cd.yml` e é acionado a cada evento de envio de código (*push*) ou solicitação de integração (*pull request*) na branch principal. O fluxo foi dividido em três trabalhos (*jobs*) encadeados, garantindo que uma versão só avance para o estágio seguinte caso atenda a todos os critérios de qualidade e segurança.

O primeiro trabalho denomina-se `build-and-static-analysis` e concentra as responsabilidades de integração contínua e verificação estática. Ele realiza o clone do repositório, configura o JDK 17 com mecanismo de cache para agilizar o download de dependências Maven e executa a compilação do projeto. Nesse mesmo estágio, o código é submetido à análise estática com a ferramenta SpotBugs e o repositório é inspecionado pelo scanner de vulnerabilidades Trivy. Paralelamente, os testes unitários são executados via JUnit 5, acompanhados da geração do relatório de cobertura de código pelo plugin JaCoCo. Ao final do trabalho, o artefato WAR é empacotado e disponibilizado para download pelos estágios subsequentes.

O segundo trabalho, denominado `deploy-staging`, representa a primeira etapa de entrega contínua voltada ao ambiente de homologação. Ele faz o download do artefato gerado anteriormente e sobe os serviços conteinerizados em portas dedicadas (porta 8081 para a aplicação e porta 5433 para o banco). Com a aplicação no ar, executa-se um teste de fumaça dinâmico via utilitário `curl` para certificar que o Tomcat está apto a responder requisições HTTP válidas. Em seguida, a aplicação é submetida a uma verificação dinâmica de segurança (DAST) utilizando a action oficial do OWASP ZAP Baseline Scan. Uma vez concluídos os testes, o ambiente de staging é automaticamente desmontado.

O terceiro trabalho é o `deploy-production`, encarregado da implantação definitiva no ambiente de produção. Este trabalho somente é iniciado se as etapas de integração contínua e homologação em staging forem concluídas com sucesso. Nele, a aplicação é implantada na porta padrão 8080 com banco na porta 5432, passando por uma validação pós-implantação que assegura a integridade do serviço em produção.

## Ferramentas de Análise Estática (SAST) e Dinâmica (DAST)

A verificação estática atua sem a necessidade de executar o software, inspecionando o código-fonte e seus metadados. Para cumprir essa finalidade em Java, adotou-se o plugin SpotBugs integrado ao ciclo de vida do Maven, capaz de identificar defeitos potenciais como classes serializáveis sem identificador de versão e tratamento inadequado de exceções. Complementarmente, foi utilizada a action Trivy para analisar as dependências declaradas no arquivo `pom.xml`, apontando vulnerabilidades de segurança catalogadas publicamente.

Por outro lado, a verificação dinâmica avalia o comportamento da aplicação em tempo de execução. Para isso, foram criadas classes de teste unitário baseadas em JUnit 5 que validam as regras e comportamentos das entidades de modelo, monitoradas pelo JaCoCo. Além disso, a análise dinâmica de segurança em ambiente ativo é conduzida pelo OWASP ZAP Baseline Scan, que dispara requisições HTTP reais contra o contêiner em funcionamento no ambiente de staging com o intuito de detectar falhas de segurança em cabeçalhos, cookies e configurações de servidor.

## Utilização de Múltiplos Ambientes

O pipeline foi projetado para operar com dois ambientes distintos, cumprindo o requisito sob a ótica dos estágios do ciclo de entrega contínua através das diretivas nativas `environment: staging` e `environment: production` do GitHub Actions. O ambiente de staging funciona como um filtro isolado na porta 8081 para a realização de testes destrutivos e verificações dinâmicas, enquanto o ambiente de produção na porta 8080 é reservado exclusivamente para a versão homologada e pronta para uso final.

Além da diferenciação lógica de estágios, o pipeline também está preparado para atender à interpretação de ambientes físicos ou de infraestrutura de execução. Os estágios de compilação e homologação operam nos executores em nuvem fornecidos pelo GitHub (`ubuntu-latest`), ao passo que o estágio de produção pode ser direcionado para um executor local auto-hospedado (`self-hosted`), caso se deseje realizar o deploy em um servidor próprio ou na máquina de desenvolvimento.

## Automação Local com Makefile

Para permitir que o desenvolvedor reproduza todas as ações do pipeline de forma padronizada em seu próprio computador, foi construído um arquivo `Makefile`. Esse utilitário permite disparar cada etapa de maneira independente ou executar todo o fluxo em cadeia por meio de um único comando.

A execução do comando `make static-analysis` dispara a compilação do projeto e as verificações do SpotBugs, JUnit 5 e JaCoCo. O comando `make staging-dast` constrói e inicializa os contêineres de homologação na porta 8081, aguarda a prontidão do serviço, efetua requisições de teste em todas as rotas da aplicação, aciona a varredura dinâmica do OWASP ZAP e finaliza o ambiente. Para subir a aplicação em produção local na porta 8080, utiliza-se o comando `make prod`.

Por fim, o comando unificado `make all` executa em sequência o processo completo: realiza a análise estática, valida o ambiente de staging com a análise dinâmica e promove o software para o contêiner de produção. O encerramento de todos os serviços pode ser feito a qualquer instante com a instrução `make stop`.
