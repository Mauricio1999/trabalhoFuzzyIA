<h2 align="justify">
Implementação de um Sistema Especialista Fuzzy para Calcular o Ganho de um Funcionário por Produção e Tempo na Fabricação de Peças Eletrônicas 
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
<p align="justify">
    As variáveis linguísticas de entrada e saída são mostradas na Tabela 1:
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
      <td>Médio</td>
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
<h6>Tabela 1. Variáveis linguísticas para calcular o ganho diário de monetização.</h6>
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
  (
    (pouco (z 0 4))
    (medio (2 0)(4 1)(6 0))
    (muito (s 5 8))
  )
)
```

<p align="justify">
    A figura 1 ilustra um gráfico com os valores numéricos possíveis para o tempo de trabalho considerando as variáveis linguísticas definidas na Tabela 1 e no template citado.
</p>

![Imagem 1](https://github.com/Mauricio1999/trabalhoFuzzyIA/blob/master/img/plot%20tempo.jpg)
<h6>Figura 1. Plotagem dos Valores numéricos possíveis para o tempo de trabalho</h6>

<p align="justify">
    A Figura 2 ilustra agora os valores numéricos possíveis para a quantidade de produção de peças, sendo utilizadas duas funções pré-definidas (z e s), e três trapezoides:
</p>

```
(deftemplate producao
0 500 qtd_produzida
  (
    (muito-baixa (z 0 110))
    (baixa (90 0)(110 1)(190 1)(210 0))
    (media (190 0)(210 1)(290 1)(310 0))
    (alta (290 0)(310 1)(390 1)(410 0))
    (muito-alta (s 390 500))
  )
)
```
![Imagem 2](https://github.com/Mauricio1999/trabalhoFuzzyIA/blob/master/img/plot%20producao.jpg)
<h6>Figura 2. Plotagem dos Valores numéricos possíveis para a quantidade de produção</h6>

<p align="justify">
    A Figura 3 ilustra os possíveis ganhos diários relacionados a produção e o tempo de trabalho,  sendo composta por duas funções pré-definidas (z e s) e um trapezoide:
</p>

```
(deftemplate ganho
0 300 ganho_producao/tempo
  (
    (baixo (z 0 110))
    (medio (90 0)(110 1)(190 1)(210 0))
    (alto (s 190 300))
  )
)
```
![Imagem 3](https://github.com/Mauricio1999/trabalhoFuzzyIA/blob/master/img/plot%20ganho.jpg)
<h6>Figura 3 Plotagem dos Valores numéricos possíveis para o ganho diário.</h6>

<p align="justify">
    A definição do resultado de Ganho é gerada por três regras distintas (defrule baixo, defrule medio e defrule alto), uma para cada variável linguística. Foi utilizada a declaração da salience para que as regras fossem executadas antes da regra de defuzzificação.
</p>

```
(defrule baixo
  (declare (salience 10))
  (or (and (producao muito-baixa) (tempo pouco))
      (and (producao muito-baixa) (tempo medio))
      (and (producao muito-baixa) (tempo muito))
      (and (producao baixa) (tempo medio))
      (and (producao baixa) (tempo muito))
      (and (producao media) (tempo muito))
)
=>
  (assert (ganho baixo))
)
 
(defrule medio
  (declare (salience 10))
  (or (and (producao baixa) (tempo pouco))
      (and (producao media) (tempo medio))
      (and (producao alta) (tempo muito))
)
=>
  (assert (ganho medio))
)
 
(defrule alto
  (declare (salience 10))
  (or (and (producao media) (tempo pouco))
      (and (producao alta) (tempo pouco))
      (and (producao alta) (tempo medio))
      (and (producao muito-alta) (tempo pouco))
      (and (producao muito-alta) (tempo medio))
      (and (producao muito-alta) (tempo muito))
)
=>
  (assert (ganho alto))
)
```
<p align="justify">
   Foi utilizado o procedimento de defuzzificação para se obtermos um resultado. Para a defuzzificação, é criada uma variável global e uma regra que também faz a plotagem do valor numérico encontrado. A regra defuzifica foi declarada com salience 0, forçando-a a ser executada após as demais regras.
</p>

```
(defglobal
?*g_resultado* = 0
)

(defrule defuzifica
  (declare (salience 0))
  ?v_tmp <- (ganho ?)
=>
  (bind ?*g_resultado* (moment-defuzzify ?v_tmp))
  (plot-fuzzy-value t "*" nil nil ?v_tmp)
  (retract ?v_tmp)
  (printout t "Ganho: ")
  (printout t ?*g_resultado* crlf)
)
```
<p align="justify">
   Para testar as regras apresentadas, geramos os deffacts, obtendo valores numéricos como resultado para as regras e fatos apresentados, devido a defuzificação citada acima.
</p>

Deffacts - 1

```
(deffacts producao/tempo
  (producao muito-alta)
  (tempo pouco)
)
```

<p align="justify">
A figura 4 ilustra o resultado obtido a partir dos fatos citados acima.
</p>

![Imagem 4](https://github.com/Mauricio1999/trabalhoFuzzyIA/blob/master/img/muito-alta%20pouco.jpg "muito alta/pouco tempo")
<h6 align="justify">Figura 4. Plotagem do Deffacts – 1. Ganho de uma produção muito alta em pouco tempo.</h6>

Deffacts - 2

```
(deffacts producao/tempo
  (producao muito-baixa)
  (tempo muito)
)
```

<p align="justify">
A figura 5 ilustra o resultado utilizando as informações contidas no Deffacts - 2.
</p>

![Imagem 5](https://github.com/Mauricio1999/trabalhoFuzzyIA/blob/master/img/muito-baixa%20muito.jpg "muito baixa/muito tempo")
<h6 align="justify">Figura 5. Plotagem do Deffacts – 2. Ganho de uma produção muito baixa em muito tempo.</h6>

<h4>3. Conclusão</h4>

<p align="justify">
   Nos testes apresentados verificamos que implementação de um Sistema Especialista Fuzzy em empresa pode ser muito importante. Com regras e templates bem detalhados podemos ter uma ferramenta capaz de emitir diagnósticos precisos sobre a situação operativa. Como vimos, o sistema trabalha com grandes variedades de entradas, vagas e incertas, as quais podem ser traduzidas para valores reais, onde resulta no valor mais preciso possível.
</p>
<p align="justify">
	Um sistema como esse poderia ser muito bem aplicado em qualquer área de produção ou até mesmo adaptado para outros fatores do cotidiano.
</p>

