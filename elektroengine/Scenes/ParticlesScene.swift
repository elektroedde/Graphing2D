import MetalKit

class ParticlesScene: BaseScene {

    

    var camera: any Camera

    var timer: Float = 0
    

    init() {
        camera = GraphCamera()
 
    }
    func update(size: CGSize) {
        camera.update(size: size)
    }

    func update(deltaTime: Float) {
        camera.update(deltaTime: deltaTime)

    }

    func draw(renderEncoder: MTLRenderCommandEncoder, params: Params, uniforms: Uniforms, options: Options) {
    }
}
