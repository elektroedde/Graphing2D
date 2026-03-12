import SwiftUI

struct Graphing2DControlPanel: View {
    @Binding var options: Options

    var body: some View {
        Picker(selection: $options.equationChoice, label: Text("Render Options")) {
            Text("sin").tag(EquationChoice.sin)
            Text("cos").tag(EquationChoice.cos)
            Text("exp").tag(EquationChoice.exp)
            Text("vector").tag(EquationChoice.vector)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
