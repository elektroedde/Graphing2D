import SwiftUI

let interfaceHeight: CGFloat = 50
let width: CGFloat = 2420 / 2
let height: CGFloat = 1668 / 2 - 2 * interfaceHeight

struct ContentView: View {
    @State var options = Options()

    var body: some View {
        VStack {
            ApplicationPicker(options: $options)

            MetalView(options: options)
                .frame(width: width, height: height)

            HStack {
                switch options.applicationChoice {
                case .FEM2D:
                    FEM2DControlPanel(options: $options)
                case .FEM3D:
                    EmptyView()
                case .Graphing2D:
                    Graphing2DControlPanel(options: $options)
                case .Graphing3D:
                    Graphing3DControlPanel(options: $options)
                }
            }
            .frame(width: width, height: interfaceHeight)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

struct ApplicationPicker: View {
    @Binding var options: Options

    var body: some View {
        Picker(selection: $options.applicationChoice, label: Text("Application Choice")) {
            Text("FEM2D").tag(ApplicationWindow.FEM2D)
            Text("FEM3D").tag(ApplicationWindow.FEM3D)
            Text("Graphing2D").tag(ApplicationWindow.Graphing2D)
            Text("Graphing3D").tag(ApplicationWindow.Graphing3D)
        }
        .frame(width: width, height: interfaceHeight)
        .pickerStyle(SegmentedPickerStyle())
    }
}
