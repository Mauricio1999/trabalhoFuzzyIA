(defglobal
?*g_resultado* = 0
)
 
 
 
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
 
 
 
(deftemplate tempo
0 8 tempo_producao_horas
  (
    (pouco (z 0 4))
    (medio (2 0)(4 1)(6 0))
    (muito (s 5 8))
  )
)
 
 
 
(deftemplate ganho
0 300 ganho_producao/tempo
  (
    (baixo (z 0 110))
    (medio (90 0)(110 1)(190 1)(210 0))
    (alto (s 190 300))
  )
)
 
 
 
;(plot-fuzzy-value t "+*-%@" 0 500 (create-fuzzy-value producao muito-baixa)
;(create-fuzzy-value producao baixa) (create-fuzzy-value producao media)
;(create-fuzzy-value producao alta) (create-fuzzy-value producao muito-alta))


;(plot-fuzzy-value t "+*-" 0 8 (create-fuzzy-value tempo pouco)
;(create-fuzzy-value tempo medio) (create-fuzzy-value tempo muito))


;(plot-fuzzy-value t "+*-" 0 300 (create-fuzzy-value ganho baixo)
;(create-fuzzy-value ganho medio) (create-fuzzy-value ganho alto))

 
 
 
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
 
(deffacts producao/tempo
  (producao muito-alta)
  (tempo pouco)
)

 
;(deffacts producao/tempo
;  (producao muito-baixa)
;  (tempo muito)
;)
