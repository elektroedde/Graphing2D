#ifndef meshing_h
#define meshing_h


#include <gmsh.h>
using namespace std;

struct MeshData {
    vector<size_t> nodes;
    vector<vector<double>> nodeCoords;
    vector<size_t> physicalGroup1_nodes;
    vector<double> physicalGroup1_coords;

    vector<size_t> physicalGroup2_nodes;
    vector<double> physicalGroup2_coords;
    vector<size_t> oneDimElements;
    vector<size_t> oneDimNodeTags;
};

struct CylinderMeshData {
    vector<size_t> allNodeTags;
    vector<size_t> allElementTags;
    vector<vector<double>> allNodeCoords;
    vector<size_t> airboxElementNodes;    // triangle node tags for the airbox region
    vector<size_t> airboxElementTags;
    vector<size_t> cylinderElementNodes;  // triangle node tags for the cylinder region
    vector<size_t> cylinderElementTags;
    vector<size_t> boundaryNodes;         // nodes on the outer rectangle boundary
};

struct WaveguideMeshData {
    // All nodes
    std::vector<std::size_t> allNodeTags;
    std::vector<std::array<double, 3>> allNodeCoords;

    // All triangle elements (connectivity)
    std::vector<std::size_t> allElementTags;
    std::vector<std::size_t> allElementNodes;

    // Dielectric region elements
    std::vector<std::size_t> dielectricElementTags;
    std::vector<std::size_t> dielectricElementNodes;

    // Airbox region elements
    std::vector<std::size_t> airboxElementTags;
    std::vector<std::size_t> airboxElementNodes;

    // Boundary nodes
    std::vector<std::size_t> leftBoundaryNodes;
    std::vector<std::size_t> rightBoundaryNodes;

    // Boundary line elements (2-node lines) for Robin BC assembly
    std::vector<std::size_t> leftBoundaryElementTags;
    std::vector<std::size_t> leftBoundaryElementNodes;
    std::vector<std::size_t> rightBoundaryElementTags;
    std::vector<std::size_t> rightBoundaryElementNodes;
};

MeshData getMeshPoints();

CylinderMeshData createChargeCylinder();
WaveguideMeshData createWaveguide();


#endif /* meshing_h */
