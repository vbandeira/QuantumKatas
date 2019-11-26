// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

namespace Quantum.Kata.JointMeasurements {
    
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Characterization;
    open Microsoft.Quantum.Measurement;
    
    //////////////////////////////////////////////////////////////////
    // Welcome!
    //////////////////////////////////////////////////////////////////
    
    // "Joint Measurements" quantum kata is a series of exercises designed
    // to get you familiar with programming in Q#.
    // It covers the joint parity measurements and using them for distinguishing quantum states
    // or for performing multi-qubit gates.
    
    // Each task is wrapped in one operation preceded by the description of the task.
    // Each task (except tasks in which you have to write a test) has a unit test associated with it,
    // which initially fails. Your goal is to fill in the blank (marked with // ... comment)
    // with some Q# code to make the failing test pass.
    
    // The tasks are given in approximate order of increasing difficulty; harder ones are marked with asterisks.
    
    
    // Task 1. Single-qubit measurement
    // Input: Two qubits (stored in an array) which are guaranteed to be
    //        either in superposition of states |00⟩ and |11⟩
    //        or in superposition of states |01⟩ and |10⟩.
    // Output: 0 if qubits were in the first superposition,
    //         1 if they were in the second superposition.
    // The state of the qubits at the end of the operation does not matter.
    operation SingleQubitMeasurement (qs : Qubit[]) : Int {
        // Hint: Use two single-qubit measurements.
        return M(qs[0]) == M(qs[1]) ? 0 | 1;
    }
    
    
    // Task 2. Parity measurement
    // Input: Two qubits (stored in an array) which are guaranteed to be
    //        either in superposition of states |00⟩ and |11⟩
    //        or in superposition of states |01⟩ and |10⟩.
    // Output: 0 if qubits were in the first superposition,
    //         1 if they were in the second superposition.
    // The state of the qubits at the end of the operation should be the same as the starting state.
    operation ParityMeasurement (qs : Qubit[]) : Int {
        return Measure([PauliZ, PauliZ], qs) == Zero ? 0 | 1;
    }
    
    
    // Task 3. |0000⟩ + |1111⟩ or |0011⟩ + |1100⟩ ?
    // Input: Four qubits (stored in an array) which are guaranteed to be
    //        either in superposition of states |0000⟩ and |1111⟩
    //        or in superposition of states |0011⟩ and |1100⟩.
    // Output: 0 if qubits were in the first superposition,
    //         1 if they were in the second superposition.
    // The state of the qubits at the end of the operation should be the same as the starting state.
    operation GHZOrGHZWithX (qs : Qubit[]) : Int {
        return Measure([PauliZ, PauliZ], qs[1..2]) == Zero ? 0 | 1;
    }
    
    
    // Task 4. |0..0⟩ + |1..1⟩ or W state ?
    // Input: An even number of qubits (stored in an array) which are guaranteed to be
    //        either in a superposition of states |0..0⟩ and |1..1⟩
    //        or in the W state ( https://en.wikipedia.org/wiki/W_state ).
    // Output: 0 if qubits were in the first superposition,
    //         1 if they were in the second superposition.
    // The state of the qubits at the end of the operation should be the same as the starting state.
    operation GHZOrWState (qs : Qubit[]) : Int {
        return MeasureAllZ(qs) == Zero ? 0 | 1;
    }
    
    
    // Task 5*. Parity measurement in different basis
    // Input: Two qubits (stored in an array) which are guaranteed to be
    //        either in superposition α|00⟩ + β|01⟩ + β|10⟩ + α|11⟩
    //        or in superposition α|00⟩ - β|01⟩ + β|10⟩ - α|11⟩.
    // Output: 0 if qubits were in the first superposition,
    //         1 if they were in the second superposition.
    // The state of the qubits at the end of the operation should be the same as the starting state.
    operation DifferentBasis (qs : Qubit[]) : Int {
        return Measure([PauliX, PauliX], qs) == Zero ? 0 | 1;
    }
    
    
    // Task 6*. Controlled X gate with |0⟩ target
    // Input: Two unentangled qubits (stored in an array of length 2).
    //        The first qubit will be in state |ψ⟩ = α |0⟩ + β |1⟩, the second - in state |0⟩
    //        (this can be written as two-qubit state (α|0⟩ + β|1⟩) ⊗ |0⟩).
    // Goal:  Change the two-qubit state to α |00⟩ + β |11⟩ using only single-qubit gates and joint measurements.
    //        Do not use two-qubit gates.
    // You do not need to allocate extra qubits.
    operation ControlledX (qs : Qubit[]) : Unit {
        H(qs[1]);
        if (Measure([PauliZ, PauliZ], qs) == One) {
            X(qs[1]);
        }
    }
    
    
    // Task 7**. Controlled X gate with arbitrary target
    // Input: Two qubits (stored in an array of length 2) in an arbitrary
    //        two-qubit state α|00⟩ + β|01⟩ + γ|10⟩ + δ|11⟩.
    // Goal:  Change the two-qubit state to α|00⟩ + β|01⟩ + δ|10⟩ + γ|11⟩ using only single-qubit gates and joint measurements.
    //        Do not use two-qubit gates.
    operation ControlledX_General (qs : Qubit[]) : Unit {
        // Hint: You can use an extra qubit to perform this operation.
        body(...) {
            // Referencia: https://arxiv.org/pdf/1201.5734.pdf
            using (a = Qubit()) {
                let c = qs[0];
                let t = qs[1];
                H(a);
                let p1 = MeasureAllZ([c, a]);
                H(a);
                H(t);
                let p2 = MeasureAllZ([a, t]);
                H(a);
                H(t);
                let m = MResetZ(a);

                // Aplica correções
                if (p2 == One) {
                    Z(c);
                }

                if (p1 != m) {
                    X(t);
                }
            }
        }

        adjoint self;
    }
    
}
