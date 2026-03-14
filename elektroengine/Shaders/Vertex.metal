#include <metal_stdlib>
#include "Common.h"
#include "ShaderDefinitions.h"
using namespace metal;

vertex VertexOut vertex_background(VertexIn in [[stage_in]],
                                   constant Uniforms &uniforms [[buffer(UniformsBuffer)]]) {
    float4 world = uniforms.modelMatrix * in.position;

    VertexOut out;
    out.worldPos = world.xyz;
    out.position = uniforms.projectionMatrix * uniforms.viewMatrix * world;

    return out;
}

vertex VertexOut vertex_graph(VertexIn in [[stage_in]],
                              constant Uniforms &uniforms [[buffer(UniformsBuffer)]]) {
    float4 position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * in.position;

    VertexOut out;
    out.position = position;

    return out;
}

vertex VertexOut vertex_vector(VertexIn in [[stage_in]],
                              constant Uniforms &uniforms [[buffer(UniformsBuffer)]]) {
    float4 position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * in.position;

    VertexOut out;
    out.position = position;

    return out;
}

vertex VertexOut vertex_fem(VertexIn in [[stage_in]],
                             constant Uniforms &uniforms [[buffer(UniformsBuffer)]]) {
    float4 position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * in.position;

    VertexOut out;
    out.position = position;
    out.femValue = in.femValue;

    return out;
}

vertex VertexOut vertex_surface(VertexIn in [[stage_in]],
                              constant Uniforms &uniforms [[buffer(UniformsBuffer)]],
                                constant Params &params [[buffer(ParamsBuffer)]],
                                constant float &timer [[buffer(20)]]) {
    float Lx = params.surfaceMaxX - params.surfaceMinX;
    float Lz = params.surfaceMaxZ - params.surfaceMinZ;
    in.position.y = sin((in.position.x - params.surfaceMinX) * 3.14159 * params.xmode / Lx)
                  * sin((in.position.z - params.surfaceMinZ) * 3.14159 * params.zmode / Lz)
                  * sin(3*timer);
    float4 worldPosition = uniforms.modelMatrix * in.position;
    float4 position = uniforms.projectionMatrix * uniforms.viewMatrix * worldPosition;
    
    VertexOut out;
    out.position = position;
    out.worldPos = worldPosition.xyz;

    return out;
}

vertex VertexOut vertex_gravity(VertexIn in [[stage_in]],
                              constant Uniforms &uniforms [[buffer(UniformsBuffer)]],
                                constant Params &params [[buffer(ParamsBuffer)]],
                                constant float &timer [[buffer(20)]]) {
    
    
    float3 planetPosition = float3(30*sin(timer/2), 0, 30*cos(timer/2));
    float r = length(in.position.xyz - planetPosition);
    in.position.y = -1000/(r*r);
    float4 worldPosition = uniforms.modelMatrix * in.position;
    float4 position = uniforms.projectionMatrix * uniforms.viewMatrix * worldPosition;
    
    VertexOut out;
    out.position = position;
    out.worldPos = worldPosition.xyz;

    return out;
}
vertex VertexOut vertex_particles() {
    VertexOut out;
    return out;
}
