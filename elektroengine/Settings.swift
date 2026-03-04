enum Settings {
    static var rotationSpeed: Float { 2.0 }
    static var translationSpeed: Float { 3.0 }
    static var mouseScrollSensitivity: Float { 0.1 }
    static var mousePanSensitivity: Float { 0.008 }
    static var touchPanSensitivity: Float { 0.05 }
    static var touchZoomSensitivity: Float { 5.0 }
}


import SwiftUI
import Observation

enum EquationChoice {
  case sin, cos, exp, vector
}

enum ApplicationWindow {
    case FEM, Graphing2D, Graphing3D
}
enum Colormap: Int32 {
    case googleTurbo = 0
    case viridis = 1
    case inferno = 2
    case plasma = 3
    case cividis = 4
    case magma = 5
    case jet = 6
    case turbo = 7
}

@Observable
class Options {
    var equationChoice = EquationChoice.sin
    var applicationChoice = ApplicationWindow.FEM
    var colormap = Colormap.googleTurbo
}
