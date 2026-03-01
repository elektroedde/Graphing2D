#include "meshing.hpp"


MeshData getMeshPoints() {
    gmsh::initialize();
    gmsh::model::add("t1");

    double lc = 1;
    gmsh::model::geo::addPoint(0, 0, 0, lc, 1);
    gmsh::model::geo::addPoint(10, 0, 0, lc, 2);
    gmsh::model::geo::addPoint(10, 10, 0, lc, 3);

    int p4 = gmsh::model::geo::addPoint(0, 10, 0, lc);

    gmsh::model::geo::addLine(1, 2, 1);
    gmsh::model::geo::addLine(3, 2, 2);
    gmsh::model::geo::addLine(3, p4, 3);
    gmsh::model::geo::addLine(4, 1, p4);

    gmsh::model::geo::addCurveLoop({4, 1, -2, 3}, 1);
    gmsh::model::geo::addPlaneSurface({1}, 1);
    gmsh::model::geo::synchronize();



    // Add physical group for top and bottom lines
    gmsh::model::addPhysicalGroup(1, {1}, 10);
    gmsh::model::addPhysicalGroup(1, {3}, 11);


    gmsh::option::setNumber("Mesh.SaveAll", 1);
    gmsh::model::mesh::generate(2);
    gmsh::write("t1.msh");


    //Using these
    std::vector<std::size_t> nodes;
    std::vector<double> n_coord;
    std::vector<std::vector<double>> nodeCoords;
    std::vector<std::size_t> physicalGroup1_nodes;
    std::vector<double> physicalGroup1_coords;
    std::vector<std::size_t> physicalGroup2_nodes;
    std::vector<double> physicalGroup2_coords;
    std::vector<std::size_t> oneDimElements;
    std::vector<std::size_t> oneDimNodeTags;










    std::vector<std::size_t> eTags;
    std::vector<std::size_t> n_tag;
    std::vector<double> p_coord;


    // Using these
    gmsh::model::mesh::getElementsByType(2, eTags, nodes);
    gmsh::model::mesh::getNodes(n_tag, n_coord, p_coord);
    gmsh::model::mesh::getNodesForPhysicalGroup(1, 10, physicalGroup1_nodes, physicalGroup1_coords);
    gmsh::model::mesh::getNodesForPhysicalGroup(1, 11, physicalGroup2_nodes, physicalGroup2_coords);
    gmsh::model::mesh::getElementsByType(1, oneDimElements, oneDimNodeTags, 2);
    
    for (size_t i = 0; i < n_coord.size(); i += 3) {
        nodeCoords.push_back({n_coord[i], n_coord[i+1], n_coord[i+2]});
    }
    gmsh::finalize();

    MeshData data;
    data.nodes = nodes;
    data.nodeCoords = nodeCoords;
    data.physicalGroup1_nodes = physicalGroup1_nodes;
    data.physicalGroup1_coords = physicalGroup1_coords;
    data.physicalGroup2_nodes = physicalGroup2_nodes;
    data.physicalGroup2_coords = physicalGroup2_coords;
    data.oneDimElements = oneDimElements;
    data.oneDimNodeTags = oneDimNodeTags;




    return data;
}


