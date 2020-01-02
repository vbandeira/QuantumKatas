# Quantum Katas

## Notas
- Todos os operadores rotacionam o estado por metade do ângulo do argumento;
- A amplitude equivale aos valores de $\alpha$ e $\beta$ em $\lvert \psi \rangle = \alpha \lvert 0 \rangle + \beta \vert 1 \rangle$
- ```Rest(qs)```retorna um vetor pulando o primeiro elemento;
- Entrelaçado $\neq$ Superposição
- Estado W: $\lvert W \rangle=\frac 1 {\sqrt{3}} \lparen \lvert 001 \rangle + \lvert 010 \rangle + \lvert 100 \rangle \rparen$
- Estado GHZ: $\lvert GHZ \rangle = \frac {{\lvert 0 \rangle}^{\otimes M} + {\lvert 1 \rangle}^{\otimes M}}  {\sqrt{2}}$
    - Menor estado: $\lvert GHZ \rangle = \frac {\lvert 000 \rangle + \lvert 111 \rangle} {\sqrt{2}}$
- O estado Bell pode assumir quatro valores:
    
    1. $\lvert \phi^+ \rangle = \frac {\Bigl( \lvert 00 \rangle + \lvert 11 \rangle \Bigr)} {\sqrt{2}}$
    1. $\lvert \phi^- \rangle = \frac {\Bigl( \lvert 00 \rangle - \lvert 11 \rangle \Bigr)} {\sqrt{2}}$
    1. $\lvert \Psi^+ \rangle = \frac {\Bigl( \lvert 01 \rangle + \lvert 10 \rangle \Bigr)} {\sqrt{2}}$
    1. $\lvert \Psi^+ \rangle = \frac {\Bigl( \lvert 01 \rangle - \lvert 10 \rangle \Bigr)} {\sqrt{2}}$
- ```PrepareQubit(pauliAxis, qubit)```- Transforma o estado do Qubit da seguinte forma:
    - Se $\lvert 0 \rangle$, então o qubit é preparado no eigenstate +1 do operador Pauli informado;
    - Se o estado do qubit for diferente de $\lvert 0 \rangle$, então o qubit é preparado no equivalente ao estado $\lvert 1 \rangle$ de acordo com o eixo, ou seja:
        - PauliX - $H(qubit)$
        - PauliY - $HS(qubit)$
        - PauliZ - $I(qubit)$
- ```CCNOT(controlQ1, controlQ2, targetQ)``` -  Aplica uma negação controlada (```CNOT```) em cenários com 3 qubits usando 2 qubits como controle.
- ```MResetZ(Qubit)```- Mede um qubit na base informada e faz reset para $\lvert 0 \rangle$. Existem variações para outros eixos: ```MResetX(Qubit)``` e ```MResetY(Qubit)```.


## Gates

### X

$\begin{bmatrix} 0 & 1 \\ 1 & 0 \end{bmatrix}$

### Y

$\begin{bmatrix} 0 & -i \\ i & 0 \end{bmatrix}$

### Z

$\begin{bmatrix} 1 & 0 \\ 0 & -1 \end{bmatrix}$

## Katas

### Measurement

#### Tarefa 1.14:

- Aplicamos ```H(qs[1])``` para que cada uma das entradas seja convertida para um dos estados Bell citados acima.

#### Tarefa 2.1:
- Dados os estados {$E_a$, $E_b$} com dois resultados $a$ e $b$, que identificamos como as respostas, ou seja, "$a$" =  $\lvert0\rangle$" e "$b$"= $\lvert + \rangle$".
- Definimos que:
    - $P(a|0) =$ Probabilidade de observar no primeiro resultado que o estado era $\lvert 0 \rangle$
    - $P(b|0) =$ Probabilidade de observar no segundo resultado que o estado era $\lvert 0 \rangle$
    - $P(a|+) =$ Probabilidade de observar no primeiro resultado que o estado era $\lvert + \rangle$
    - $P(b|+) =$ Probabilidade de observar no segundo resultado que o estado era $\lvert + \rangle$
- A tarefa é maximizar a probabilidade de estar correto com uma medição única.
- Assumindo a uniformidade anterior, ou seja, $P(+) = P(0) = \frac 1 2$, nós temos $P_{acerto} = P(0) \times P(a|0) + P(+) \times P(b|+) = \frac 1 2 \times \Bigl( P(a|0) + P(b|+) \Bigr)$.
- Assumindo uma medição na forma [von Neumann](https://en.wikipedia.org/wiki/Measurement_in_quantum_mechanics#von_Neumann_measurement_scheme) temos:
    - $E_a = Ry(2.0 * \alpha) * (1,0) = \Bigl(\cos(\alpha), \sin(\alpha)\Bigr)$
    - $E_b = Ry(2.0 * \alpha) * (0,1) = \Bigl(\sin(\alpha), -\cos(\alpha)\Bigr)$
- Com isso temos:
    - $P(a|0) = \Bigl| \langle E_a | 0 \rangle \Bigl|^2 = \cos^2(\alpha)$
    - $P(b|+) = \Bigl| \langle E_b | + \rangle \Bigl|^2 = \frac 1 2 + \cos(\alpha) \times \sin(\alpha)$
    - $P_{acerto} = \frac 1 2 \times \Bigl( \frac 1 2 + \cos^2(\alpha) + \cos(\alpha) \times \sin(\alpha) \Bigr)$
- Maximizando isso para $\alpha$, temos o máximo de $P_{sucesso} = \frac 1 2 \Bigl(1 + \frac 1 {\sqrt{2}} \Bigr) = 0.8535...$, que é obtido por $\alpha = \frac \pi 8$ 
- Precisamos rotacionar o estado inicial por $\frac \pi 8$ para aplicar ```Ry```com um ângulo de $\frac {2\pi} 8$

#### Tarefa 2.2:
- A estratégia mais simples que resulta em "inconclusivo" com uma precisão de 75% e nunca erra nos cenários conclusivos, é escolher aleatoriamente a base de medição entre computacional (std) e Hadamard (had), resultando na tabela verdade abaixo:

| Estado | Base | Output 0 | Output 1 | Output -1 |
|---|---|---|---|---|
| $\lvert 0 \rangle$ | std | 0 | 0 | 1 |
| $\lvert + \rangle$ | std | 0 | $\frac 1 2$ | $\frac 1 2$ |
| $\lvert 0 \rangle$ | had | $\frac 1 2$ | 0 | $\frac 1 2$ |
| $\lvert + \rangle$ | had | 0 | 0 | 1 |

#### Tarefa 2.3:
- A chave é a observação de que [POVM](https://pt.wikipedia.org/wiki/Medida_com_operador_positivo_valorizado) com elementos de primeiro rank $\{ E_0, E_1, E_2\}$ resolverá o problema, onde $E_k = \lvert \psi_k \rangle \langle \psi_k \rvert$ e $\lvert \psi_k \rangle = \frac 1 {\sqrt{2}} \Bigl( \lvert 0 \rangle-w^k \lvert 1 \rangle \Bigr)$ e onte $k =0, 1, 2$. O resto da tarefa é encontrar uma medição von Neumann que implementa a chamada POVM através de um circuito quântico.
- Para obter tal circuito quântico, observamos que precisamos de uma extensão unitária da matriz formada por $A = \Big( \psi_0, \psi_1, \psi_2\Bigr)$. No geral, podemos usar Decomposição de Valores Simples (Singular Value Decomposition, SVD), mas aqui podemos aplicar um atalho:
 - A matriz $A$ pode ser extendida (até $\pm 1$ na diagonal) para uma matriz Transformação de Fourier Discreta 3x3, com uma dimensão extra (um bloco de 1x1 no qual temos liberdade de fase), obtemos uma unidade 4x4.
 - Usando o "Rader trick" podemos agora decompor em bloco o 3x3 DFT e obter dois blocos 2x2 nos quais podemos implementar gates controlados de qubits únicos

### Joint Measure

#### Tarefa 3
- Precisamos compara apenas o segundo e o terceiro qubit para diferenciar os estados GHZ ou GHZ com X
- A paridade desses qubits para o primeiro estado (GHZ) é 0, então seu estado pertence ao eigenspace +1 do operador $Z \otimes Z$.
- No outro estado (GHZ com X), a paridade é 1, logo seu estado pertence ao eigenspace -1

#### Tarefa 5
- No primeiro estado temos uma superposição $\lvert++\rangle$ e $\lvert--\rangle$ que pertence ao estado +1 do eigenspace do operador $X \otimes X$;
- O segundo estado é uma superposição $\lvert +- \rangle$ e $\lvert -+ \rangle$ que pertence ao  eigenspace -1 do mesmo operador;

### Superdense Coding
#### Tarefa 3

- Após reaplicarmos o entrelaçamento (desfazer) entre os qubits de Alice e Bob, a medição de ambos os qubits poderá apresentar os seguintes resultados:
    - $\lvert \phi^+\rangle = \frac {\big(\lvert 00 \rangle + \lvert 11 \rangle \big)} {\sqrt 2} \longrightarrow \lvert 00 \rangle$
    - $\lvert \psi^+\rangle = \frac {\big(\lvert 01 \rangle + \lvert 10 \rangle \big)} {\sqrt 2} \longrightarrow \lvert 01 \rangle$
    - $\lvert \phi^-\rangle = \frac {\big(\lvert 00 \rangle + \lvert 11 \rangle \big)} {\sqrt 2} \longrightarrow \lvert 10 \rangle$
    - $\lvert \psi^-\rangle = \frac {\big(\lvert 01 \rangle + \lvert 10 \rangle \big)} {\sqrt 2} \longrightarrow \lvert 11 \rangle$

### Deutsch-Jozsa Algorithm

#### Tarefa 1.3
- Retornamos o resultado ao entrelaçar o qubit desejado (indicado por ```k```) com o resultado ```y```.

#### Tarefa 1.4
- Ao aplicacarmos o ```CNOT```(não controlado), naturalmente temos o comportamento desejado: 1 se tivermos uma quantidade ímpar de qubits em $\lvert 1 \rangle$ e 0 se houver um número par.

#### Tarefa 1.8
- Podemos definir da seguinte forma:
    $f(x) = \big(x_0 \ AND \ x_1 \big) \ \oplus \ \big(x_0 \ AND \ x_1 \big) \ \oplus \ \big(x_0 \ AND \ x_1 \big)$

#### Tarefa 2.2
- Passo a passo:
    1. Aloca N qubits para o input e um qubit para o output;
    1. Prepara os qubits no estado correto;
    1. Aplica a função oráculo
    1. Aplica Hadamard a cada qubit do registro de input;
    1. Mede todos os qubits do registro de input, convertendo para Int;
    1. Reset dos qubits e retorno da função

#### Tarefa 4.1
- Passo a passo:
    1. Aplica o oráculo aos qubits no estado 0;
    1. Remove o N da expressão: 
        
        $f(x) = \sum_i \Big(r_i + x_i + \big(1 - r_i \big) \big(1 - x_i \big) \Big)$

        $f(x) = 2 \sum_i r_i x_i + \sum_i r_i + \sum_i x_i + N$

        $f(x) = \sum_i r_i + N$
    1. Com isso temos $y = \sum_i r_i$
    1. Declara o vetor com o resultado e mede o registro de output
    1. Reset dos qubits e retorno de resultado

## Links
[API Reference](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.bitwise?view=qsharp-preview)

[Quantum Gates and Circuits: The Crash Course](https://blogs.msdn.microsoft.com/uk_faculty_connection/2018/02/26/quantum-gates-and-circuits-the-crash-course/)