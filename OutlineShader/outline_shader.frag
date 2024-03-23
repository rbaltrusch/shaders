#pragma language glsl3

uniform vec3 u_outline_colour;
uniform vec2 u_resolution;

float sample(int factor, Image image, vec2 uvs, int x, int y) {
    vec2 pos = uvs - ivec2(x, y) / u_resolution;
    vec4 neighbour = texture2D(image, pos);
    return factor * ceil(neighbour.a);
}

// tutorial source: https://blogs.love2d.org/content/let-it-glow-dynamically-adding-outlines-characters
vec4 effect(vec4 color, Image image, vec2 uvs, vec2 texture_coords) {
    vec4 texture = texture2D(image, uvs);
    // filter kernel, summing to 0 everywhere except at edges
    float alphaSum = (
        sample(8, image, uvs, 0, 0)
        + sample(-1, image, uvs, -1, 0)
        + sample(-1, image, uvs, 1, 0)
        + sample(-1, image, uvs, 0, -1)
        + sample(-1, image, uvs, 0, 1)
        + sample(-1, image, uvs, -1, -1)
        + sample(-1, image, uvs, -1, 1)
        + sample(-1, image, uvs, 1, -1)
        + sample(-1, image, uvs, 1, 1)
    );
    return vec4(texture.rgb + (alphaSum * u_outline_colour), texture.a) * color;
}
