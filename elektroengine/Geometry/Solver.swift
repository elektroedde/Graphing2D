import Accelerate

class Solver {
    static func solve(femObject: FEM_Model) -> [Float] {
        let N = femObject.N
        let M = femObject.M

        var K = [[Float]](repeating: [Float](repeating: 0, count: N), count: N)
        var b = [Float](repeating: 0, count: N)

        // Assemble global stiffness matrix
        for element in 0..<M {
            let n0 = femObject.nodes[element * 3 + 0]
            let n1 = femObject.nodes[element * 3 + 1]
            let n2 = femObject.nodes[element * 3 + 2]
            let nodes = [n0, n1, n2]

            let x = [femObject.vertices[n0].x, femObject.vertices[n1].x, femObject.vertices[n2].x]
            let y = [femObject.vertices[n0].y, femObject.vertices[n1].y, femObject.vertices[n2].y]

            let area = 0.5 * (x[0]*(y[1] - y[2]) + x[1]*(y[2] - y[0]) + x[2]*(y[0] - y[1]))

            // rename these?
            let beta  = [y[1] - y[2], y[2] - y[0], y[0] - y[1]]
            let alpha = [x[2] - x[1], x[0] - x[2], x[1] - x[0]]


            var f: Float = 0
            if(femObject.chargeElements.contains(femObject.allElements[element])) {
                f = 1000000
            }

            var K_e: [[Float]] = [[Float]](repeating: [Float](repeating: 0, count: 3), count: 3)
            var b_e: [Float] = [Float](repeating: 0, count: 3)

            for m in 0..<3 {
                b_e[m] = f*area/3
                b[nodes[m]] += b_e[m]
                for n in 0..<3 {
                    var dirac: Float = 0
                    if(m == n) {
                        dirac = 1
                    }
                    K_e[m][n] = (alpha[m]*alpha[n] + beta[m]*beta[n]) / (4*area) + 0*dirac

                    K[nodes[m]][nodes[n]] += K_e[m][n]
                }
            }
        }

        // Apply Dirichlet boundary conditions
        for (i, k) in femObject.dirichletNodes.enumerated() {
            let val = Float(femObject.dirichletValues[i])
            for j in 0..<N {
                if k == j {
                    K[j][j] = 1
                    b[j] = val
                } else {

                    b[j] -= K[j][k] * val
                    K[k][j] = 0
                    K[j][k] = 0
                }
            }
        }

        // Apply Robin boundary conditions
        for k in 0..<femObject.robinElements.count {
            let node1 = femObject.robinNodes[k*2]
            let node2 = femObject.robinNodes[k*2 + 1]
            let nodes = [node1, node2]

            let dx = femObject.vertices[node2].x - femObject.vertices[node1].x
            let dy = femObject.vertices[node2].y - femObject.vertices[node1].y
            let length = sqrt(dx*dx + dy*dy)

            let q = femObject.q[k]
            let gamma = femObject.gamma[k]

            for i in 0..<2 {
                b[nodes[i]] += q * length / 2
                for j in 0..<2 {
                    let dirac: Float = (i == j) ? 1 : 0
                    K[nodes[i]][nodes[j]] += gamma * (1 + dirac) * length / 6
                }
            }
        }

        return solveLAPACK(K, b)!
    }

    static func linearSolver(_ A_in: [[Float]], _ b_in: [Float]) -> [Float] {
        let n = A_in.count
        var L = Array(repeating: Array(repeating: Float(0), count: n), count: n)
        var U = A_in
        var b = b_in

        for i in 0..<n-1 {
            var maxRow = i
            for j in i+1..<n {
                if abs(U[j][i]) > abs(U[maxRow][i]) {
                    maxRow = j
                }
            }
            if i != maxRow {
                U.swapAt(i, maxRow)
                L.swapAt(i, maxRow)
                b.swapAt(i, maxRow)
            }
            for k in i+1..<n {
                let factor = U[k][i] / U[i][i]
                L[k][i] = factor
                for o in i..<n {
                    U[k][o] -= factor * U[i][o]
                }
            }
        }

        for i in 0..<n { L[i][i] = 1 }

        var c = [Float](repeating: 0, count: n)
        for i in 0..<n {
            for j in 0..<i { b[i] -= L[i][j] * c[j] }
            c[i] = b[i] / L[i][i]
        }

        var x = [Float](repeating: 0, count: n)
        for i in (0..<n).reversed() {
            for j in i..<n { c[i] -= U[i][j] * x[j] }
            x[i] = c[i] / U[i][i]
        }
        return x
    }

    static func solveLAPACK(_ A: [[Float]], _ b: [Float]) -> [Float]? {
        let n = b.count
        var A_flat = [Float](repeating: 0, count: n*n)
        for i in 0..<n {
            for j in 0..<n {
                A_flat[j * n + i] = A[i][j]
            }
        }

        var b_copy = b
        var n32 = Int32(n)
        var nrhs: Int32 = 1
        var lda = Int32(n)
        var ldb = Int32(n)
        var ipiv = [Int32](repeating: 0, count: n)
        var info: Int32 = 0

        sgesv_(&n32, &nrhs, &A_flat, &lda, &ipiv, &b_copy, &ldb, &info)

        if info == 0 {
            return b_copy
        } else {
            print("LAPACK sgesv failed with info = \(info)")
            return nil
        }
    }
}
