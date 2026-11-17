-- Desempenho individual dos jogadores


SELECT
    Jogador,
    MP,
    Começa,
    Min
FROM Estatisticas_Jogadores
ORDER BY Min DESC;

SELECT
    Jogador,
    CrdY,
    CrdR
FROM Estatisticas_Jogadores
ORDER BY CrdY DESC;

SELECT TOP 10
    Jogador,
    Gls,
    Ast,
    Min,
    G_A2 AS Participacoes_Gols_90
FROM Estatisticas_Jogadores
WHERE Min >= 900
ORDER BY G_A2 DESC;

SELECT
    Jogador,
    Gls,
    Ast,
    G_A,
    ROUND(
        G_A * 100.0 /
        NULLIF(
            SUM(G_A) OVER(),
            0
        ),
        2
    ) AS Percentual_Participacao
FROM Estatisticas_Jogadores
ORDER BY G_A DESC;

-- Desempenho clube

SELECT * FROM Estatisticas_Clube

SELECT
    COUNT(*) AS Partidas,

    SUM(CASE WHEN Resultado = 'V' THEN 1 ELSE 0 END) AS Vitorias,
    SUM(CASE WHEN Resultado = 'E' THEN 1 ELSE 0 END) AS Empates,
    SUM(CASE WHEN Resultado = 'D' THEN 1 ELSE 0 END) AS Derrotas,

    SUM(CASE
        WHEN Resultado = 'V' THEN 3
        WHEN Resultado = 'E' THEN 1
        ELSE 0
    END) AS Pontos,

    SUM(TRY_CONVERT(INT, Gols_Marcados)) AS Gols_Marcados,
    SUM(TRY_CONVERT(INT, Gols_Sofridos)) AS Gols_Sofridos,

    SUM(TRY_CONVERT(INT, Gols_Marcados))
    - SUM(TRY_CONVERT(INT, Gols_Sofridos)) AS Saldo_Gols

FROM Estatisticas_Clube
WHERE Competicao = 'Premier League';

SELECT
    Local,
    COUNT(*) AS Partidas,

    SUM(CASE WHEN Resultado = 'V' THEN 1 ELSE 0 END) AS Vitorias,
    SUM(CASE WHEN Resultado = 'E' THEN 1 ELSE 0 END) AS Empates,
    SUM(CASE WHEN Resultado = 'D' THEN 1 ELSE 0 END) AS Derrotas,

    SUM(TRY_CONVERT(INT, Gols_Marcados)) AS Gols_Marcados,
    SUM(TRY_CONVERT(INT, Gols_Sofridos)) AS Gols_Sofridos

FROM Estatisticas_Clube
WHERE Competicao = 'Premier League'
GROUP BY Local;

SELECT
    Adversario,
    COUNT(*) AS Partidas,

    SUM(CASE WHEN Resultado = 'V' THEN 1 ELSE 0 END) AS Vitorias,
    SUM(CASE WHEN Resultado = 'E' THEN 1 ELSE 0 END) AS Empates,
    SUM(CASE WHEN Resultado = 'D' THEN 1 ELSE 0 END) AS Derrotas,

    SUM(TRY_CONVERT(INT, Gols_Marcados)) AS Gols_Marcados,
    SUM(TRY_CONVERT(INT, Gols_Sofridos)) AS Gols_Sofridos

FROM Estatisticas_Clube
WHERE Competicao = 'Premier League'
GROUP BY Adversario
ORDER BY Vitorias DESC;

SELECT
    ROUND(AVG(CAST(Posse_Bola AS FLOAT)), 2) AS Posse_De_Bola_Media
FROM Estatisticas_Clube
WHERE Competicao = 'Premier League';

SELECT
    COUNT(*) AS Total_Clean_Sheets
FROM Estatisticas_Clube
WHERE Competicao = 'Premier League'
AND TRY_CONVERT(INT, Gols_Sofridos) = 0;

SELECT
    Data,
    Adversario,
    Local,
    Gols_Marcados,
    Gols_Sofridos,
    Resultado
FROM Estatisticas_Clube
WHERE Competicao = 'Premier League'
AND TRY_CONVERT(INT, Gols_Sofridos) = 0
ORDER BY Data;

SELECT
    COUNT(*) AS Total_Partidas,

    ROUND(AVG(TRY_CONVERT(FLOAT, Gols_Marcados)), 2)
        AS Media_Gols_Marcados,

    ROUND(AVG(TRY_CONVERT(FLOAT, Gols_Sofridos)), 2)
        AS Media_Gols_Sofridos

FROM Estatisticas_Clube
WHERE Competicao = 'Premier League';

SELECT
    Data,
    Rodada,
    Adversario,
    Resultado,

    CASE
        WHEN Resultado = 'V' THEN 3
        WHEN Resultado = 'E' THEN 1
        WHEN Resultado = 'D' THEN 0
        ELSE NULL
    END AS Pontos,

    TRY_CONVERT(INT, Gols_Marcados) AS Gols_Marcados,
    TRY_CONVERT(INT, Gols_Sofridos) AS Gols_Sofridos

FROM Estatisticas_Clube
WHERE Competicao = 'Premier League'
ORDER BY Data;

-- Desempenho Jogadores

SELECT * FROM Estatisticas_Jogadores

SELECT TOP 10
    Jogador,
    Gols
FROM Estatisticas_Jogadores
ORDER BY Gols DESC;


SELECT TOP 10
    Jogador,
    Assistencias
FROM Estatisticas_Jogadores
ORDER BY Assistencias DESC;

SELECT
    Jogador,
    Partidas_Disputadas,
    Partidas_Titular,
    Minutos_Jogados
FROM Estatisticas_Jogadores
ORDER BY Minutos_Jogados DESC;

SELECT
    Jogador,
    Cartao_Amarelo,
    Cartao_Vermelho
FROM Estatisticas_Jogadores
ORDER BY Cartao_Amarelo DESC;

SELECT TOP 10
    Jogador,
    Gols,
    Assistencias,
    Minutos_Jogados,
    GolsAssist_90min AS Participacoes_Gols_90
FROM Estatisticas_Jogadores
WHERE Minutos_Jogados >= 900
ORDER BY GolsAssist_90min DESC;

SELECT
    Jogador,
    Gols,
    Assistencias,
    Gols_Assistencias AS Participacoes_Gols,

    ROUND(
        Gols_Assistencias * 100.0 /
        NULLIF(SUM(Gols_Assistencias) OVER(), 0),
        2
    ) AS Percentual_Participacao

FROM Estatisticas_Jogadores
ORDER BY Gols_Assistencias DESC;

SELECT * FROM Estatisticas_Clube
SELECT * FROM Estatisticas_Jogadores

UPDATE Estatisticas_Clube
SET Formacao = CASE
    WHEN Formacao LIKE '2003-03-04%' THEN '4-3-3'
    WHEN Formacao LIKE '2003-04-03%' THEN '3-4-3'
    WHEN Formacao LIKE '2002-03-05%' THEN '5-3-2'
    WHEN Formacao LIKE '2002-04-04%' THEN '4-4-2'
    WHEN Formacao LIKE '% 04:02:03%' THEN '4-2-3-1'
    WHEN Formacao LIKE '% 04:01:04%' THEN '4-1-4-1'
    ELSE Formacao END;

    SELECT Formacao_Adversario FROM Estatisticas_Clube


    
-- 1. Estrutura da tabela de partidas
SELECT
    TABLE_NAME AS Tabela,
    COLUMN_NAME AS Coluna,
    DATA_TYPE AS Tipo_Dado,
    CHARACTER_MAXIMUM_LENGTH AS Tamanho,
    IS_NULLABLE AS Aceita_Nulo
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('Estatisticas_Clube', 'Estatisticas_Jogadores')
ORDER BY TABLE_NAME, ORDINAL_POSITION;


-- 2. Todos os dados das partidas
SELECT *
FROM dbo.Estatisticas_Clube
ORDER BY Data;


-- 3. Todos os dados dos jogadores
SELECT *
FROM dbo.Estatisticas_Jogadores
ORDER BY Jogador;