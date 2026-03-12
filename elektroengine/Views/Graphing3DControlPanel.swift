import SwiftUI

struct Graphing3DControlPanel: View {
    @Binding var options: Options

    var body: some View {
        VStack {
            Text("Select Surface")
            Menu(options.surface.label) {
                ForEach(SurfaceChoice.allCases, id: \.self) { surface in
                    Button(surface.label) {
                        options.surface = surface
                    }
                }
            }
        }

        Spacer()

        Menu {
            ForEach(Colormap.allCases, id: \.self) { colormap in
                Button(colormap.label) {
                    options.colormap = colormap
                }
            }
        } label: {
            Text(options.colormap.label)
        }

        Toggle("Render wireframe", isOn: $options.drawWireframe)

        Spacer()
    }
}
