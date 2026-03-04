struct FEM_Model {

    var N: Int { vertices.count }
    var M: Int { nodes.count / 3 }

    var nodes: [Int] = []
    var vertices: [Vertex] = []

    var dirichletNodes: [Int] = []
    var dirichletValues: [Int] = []

    var robinElements: [Int] = []
    var robinNodes: [Int] = []

    var f: [Float]? = nil
    var q: [Float] = []
    var gamma: [Float] = []

    var chargeElements: [Int] = []
    var allElements: [Int] = []

}
