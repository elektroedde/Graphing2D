#ifndef meshing_h
#define meshing_h


#include <gmsh.h>


struct MeshData {
    std::vector<std::size_t> nodes;
    std::vector<std::vector<double>> nodeCoords;
    std::vector<std::size_t> physicalGroup1_nodes;
    std::vector<double> physicalGroup1_coords;

    std::vector<std::size_t> physicalGroup2_nodes;
    std::vector<double> physicalGroup2_coords;
    std::vector<std::size_t> oneDimElements;
    std::vector<std::size_t> oneDimNodeTags;










};

MeshData getMeshPoints();


#endif /* meshing_h */
