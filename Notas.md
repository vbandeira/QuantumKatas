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
    
    1. $\lvert \phi^+ \rangle = \frac {\bigl( \lvert 00 \rangle + \lvert 11 \rangle \bigr)} {\sqrt{2}}$
    1. $\lvert \phi^- \rangle = \frac {\bigl( \lvert 00 \rangle - \lvert 11 \rangle \bigr)} {\sqrt{2}}$
    1. $\lvert \Psi^+ \rangle = \frac {\bigl( \lvert 01 \rangle + \lvert 10 \rangle \bigr)} {\sqrt{2}}$
    1. $\lvert \Psi^+ \rangle = \frac {\bigl( \lvert 01 \rangle - \lvert 10 \rangle \bigr)} {\sqrt{2}}$

- Tarefa 1.14:
    - Aplicamos ```H(qs[1])``` para que cada uma das entradas seja convertida para um dos estados Bell citados acima.

## Links
[API Reference](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.bitwise?view=qsharp-preview)

[Quantum Gates and Circuits: The Crash Course](https://blogs.msdn.microsoft.com/uk_faculty_connection/2018/02/26/quantum-gates-and-circuits-the-crash-course/)