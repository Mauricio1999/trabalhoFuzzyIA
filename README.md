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
