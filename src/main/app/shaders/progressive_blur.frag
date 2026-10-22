#version 460 core

#include <flutter/runtime_effect.glsl>

// set by the engine: size of the backdrop texture
uniform vec2 u_size;
// height of the blurred area, in physical pixels, starting from the top (or the bottom, see u_from_bottom)
uniform float u_height;
// blur radius at the screen edge, in physical pixels
uniform float u_radius;
// 1 to blur from the bottom of the screen instead of the top
uniform float u_from_bottom;

uniform sampler2D u_texture;

out vec4 frag_color;

const int SAMPLES = 64;
const float GOLDEN_ANGLE = 2.39996323;

vec4 sample_at(vec2 pos) {
  // no y flip on OpenGL ES here: unlike what the ImageFilter.shader docs say, the backdrop texture already has the
  // same orientation as FlutterFragCoord, and flipping it shows the bottom of the screen upside down
  return texture(u_texture, clamp(pos / u_size, 0.0, 1.0));
}

void main() {
  vec2 pos = FlutterFragCoord().xy;

  // 1 at the screen edge, 0 at the other end of the area, eased so the blur fades out very softly
  float dist = u_from_bottom > 0.5 ? u_size.y - pos.y : pos.y;
  float t = clamp(1.0 - dist / u_height, 0.0, 1.0);
  t = t * t * (3.0 - 2.0 * t);
  float radius = u_radius * t;

  if (radius < 0.5) {
    frag_color = sample_at(pos);
    return;
  }

  // gaussian-weighted vogel disk: a single pass blur whose radius can change per pixel
  vec4 color = vec4(0.0);
  float total = 0.0;
  for (int i = 0; i < SAMPLES; i++) {
    float r = sqrt((float(i) + 0.5) / float(SAMPLES));
    float a = float(i) * GOLDEN_ANGLE;
    float w = exp(-2.0 * r * r);
    color += sample_at(pos + vec2(cos(a), sin(a)) * r * radius) * w;
    total += w;
  }
  frag_color = color / total;
}
