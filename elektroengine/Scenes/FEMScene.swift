import MetalKit

class FEMScene: SceneX {

    lazy var background: Background = {
        Background(device: Renderer.device)
    }()

    lazy var rectangle: Rectangle = {
        Rectangle(device: Renderer.device)
    }()

    lazy var gmsh_rectangle: GMSH_Rectangle = {
        GMSH_Rectangle(device: Renderer.device)
    }()

    lazy var charged_cylinder: ChargedCylinder = {
        ChargedCylinder(device: Renderer.device)
    }()


    var camera: any Camera

    var timer: Float = 0



    

    init() {
        camera = GraphCamera()
        charged_cylinder.transform.position.z -= 0.01
        //background.transform.position.z += 0.0001

    }
    func update(size: CGSize) {
        camera.update(size: size)
        print("Updated FEM")
    }

    func update(deltaTime: Float) {
        camera.update(deltaTime: deltaTime)

    }

    func draw(renderEncoder: MTLRenderCommandEncoder, params: Params, uniforms: Uniforms, options: Options) {

        background.draw(renderEncoder: renderEncoder, params: params, uniforms: uniforms)
        charged_cylinder.draw(renderEncoder: renderEncoder, params: params, uniforms: uniforms, options: options)

    }
}
