#version 330

uniform bool isPVCOn;
uniform vec2 minmaxs[3];

in vec4 pervcol;
in vec4 hpoint;

out vec4 outColor;

vec3 hsv2rgb(vec3 c)
{
   vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
   vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
   return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void)
{
   bool nin_bounds = (hpoint.x > minmaxs[0].x || hpoint.x < minmaxs[0].y ||
       hpoint.y > minmaxs[1].x || hpoint.y < minmaxs[1].y || hpoint.z < minmaxs[2].y);

   float height = (minmaxs[2].x- hpoint.z)/(minmaxs[2].x-minmaxs[2].y);

   if(nin_bounds)
       discard;
   else
       outColor = isPVCOn ? pervcol : vec4(hsv2rgb(vec3(height, 1.f, 1.f)),1);
}
