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
                case .RayMarching:
                    EmptyView()
                case .Particles:
                    EmptyView()
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
            ForEach(ApplicationWindow.allCases, id: \.self) { app in
                Text(app.label).tag(app)
            }
        }
        .frame(width: width, height: interfaceHeight)
        .pickerStyle(SegmentedPickerStyle())
    }
}
