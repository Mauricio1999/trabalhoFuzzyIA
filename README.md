<h2 align="justify">
Implementação de um Sistema Especialista Fuzzy para Calcular Ganho de um Funcionário por Produção e Tempo na Fabricação de Peças Eletrônicas 
</h2>
<h3>
Lucas Cordeiro de Souza e Mauricio Demonti Amorim
</h3>
<h4>
1. Introdução
</h4>

<p align="justify">
    Neste relatório será apresentado o detalhamento de implementação de um Sistema Especialista Fuzzy utilizando a ferramenta FuzzyClips, com a finalidade de calcular o ganho (em reais) diário de um funcionário fabricante de peças eletrônicas, considerando como variáveis auxiliares o tempo estimado e a quantidade produzida. 
</p>

<table align="center">
  <thead>
    <tr>
      <th></th>
      <th colspan='3'>TEMPO</th>
    </tr>
    <tr>
      <th>PRODUÇÃO</th>
      <th>POUCO</th>
      <th>MÉDIO</th>
      <th>MUITO</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>MUITO-BAIXA</th>
      <td>Baixo</td>
      <td>Baixo</td>
      <td>Baixo</td>
    </tr>
    <tr>
      <th>BAIXA</th>
      <td>Médio</td>
      <td>Baixo</td>
      <td>Baixo</td>
    </tr>
    <tr>
      <th>MÉDIA</th>
      <td>Alto</td>
      <td>Média</td>
      <td>Baixo</td>
    </tr>
        <tr>
      <th>ALTA</th>
      <td>Alto</td>
      <td>Alto</td>
      <td>Médio</td>
    </tr>
        <tr>
      <th>MUITO-ALTA</th>
      <td>Alto</td>
      <td>Alto</td>
      <td>Alto</td>
    </tr>
  </tbody>
</table>
<h6>
Tabela 1. Variáveis linguísticas para calcular o ganho diário de monetização.
</h6>
<p align="justify">
    Na primeira coluna da tabela estão descritos os valores possíveis de produção de peças, enquanto na primeira linha tempos as possíveis variáveis de tempo (Pouco, médio e muito). Já as demais colunas estão descritos os resultados dos ganhos por produção em seu determinado tempo.
</p>

<h4>
2. Implementação e Testes 
</h4>

<p align="justify">
    Para cada variável linguística foi definido um template. No caso do template Tempo, utilizou-se duas funções pré-definidas (z) no início e (s) para final e uma função trapezoide de três pontos: 
</p>

```
(deftemplate tempo
0 8 tempo_producao_horas
  ((pouco (z 0 4))
    (medio (2 0)(4 1)(6 0))
    (muito (s 5 8))
  )
)
```

<p align="justify">
    A figura 1 ilustra um gráfico com os valores numéricos possíveis para o tempo de trabalho considerando as variáveis linguísticas definidas na Tabela 1 e no template citado.
</p>

![Imagem 1](https://github.com/Mauricio1999/trabalhoFuzzyIA/blob/master/img/plot%20tempo.jpg)
