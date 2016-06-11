import moonlander.library.*;
import ddf.minim.*;
import peasy.*;

Moonlander moon;
PeasyCam cam;

boolean debugMode = false;

// tangerine mistake
// by wno

PImage tex_pyramid;
PImage tex_moon;

void setup() {
    size(853, 480, P3D);
    lights();

    randomSeed(0);

    tex_pyramid = loadImage("pyris.png");
    tex_moon = loadImage("moon.png");

    moon = Moonlander.initWithSoundtrack(this, "click130bpm.wav", 130, 4);

    moon.start();
    
    cam = new PeasyCam(this, 0, 0, 0, 50);

    cam.setMinimumDistance(10);
    cam.setMaximumDistance(500);

    if (debugMode) {
        cam.setActive(true);
    } else {
        cam.setActive(false);
    }
}

void set_perspective(float fovFactor) {
    // copypasta
    float fov = (PI/3.0) * fovFactor;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), 
                cameraZ/20.0, cameraZ*100.0);
    // end copypasta
}

void draw_coords() {
    stroke(255, 0, 0);
    line(0, 0, 0, 20, 0, 0);
    line(0, 0, 0, 0, 20, 0);
    line(0, 0, 0, 0, 0, 20);
}

void draw_pyramid() {
    scale(2.5);

    beginShape(TRIANGLES);

    noStroke();
    texture(tex_pyramid);

    // front
    vertex(0, -10, 0, 128, 0);
    vertex(-10, 10, 10, 0, 512);
    vertex(10, 10, 10, 512, 512);

    // right
    vertex(0, -10, 0, 128, 0);
    vertex(10, 10, 10, 0, 512);
    vertex(10, 10, -10, 512, 512);

    // left
    vertex(0, -10, 0, 128, 0);
    vertex(-10, 10, 10, 0, 512);
    vertex(-10, 10, -10, 512, 512);

    // back
    vertex(0, -10, 0, 128, 0);
    vertex(-10, 10, -10, 0, 512);
    vertex(10, 10, -10, 512, 512);

    endShape();

    // floor
    beginShape(QUADS);

    vertex(-10, 10, 10, 0, 0);
    vertex(-10, 10, -10, 0, 512);
    vertex(10, 10, -10, 512, 512);
    vertex(-10, 10, 10, 512, 0);

    endShape();
}

void draw_horizon() {
    // floor
    fill(#DB9B21);
    beginShape(QUADS);

    int horizonVeryFar = -10000;
    int reallyWide = 100;
    vertex(-width/2 * reallyWide, 0, horizonVeryFar);
    vertex(-width/2 * reallyWide, 60, 10);
    vertex(width/2 * reallyWide, 60, 10);
    vertex(width/2 * reallyWide, 0, horizonVeryFar);

    endShape();
}

void draw_sky() {
    fill(#0ECEFF);

    beginShape(QUADS);

    int horizonVeryFar = -10000;
    int reallyWide = 100;

    vertex(-width/2 * reallyWide, -200, 10);
    vertex(-width/2 * reallyWide, 0, horizonVeryFar);
    vertex(width/2 * reallyWide, 0, horizonVeryFar);
    vertex(width/2 * reallyWide, -200, 10);

    endShape();
}

void draw_spheres(float sphereDist, float sphereScale) {
    fill(#00ff00);

    if (debugMode) { draw_coords(); }

    noStroke();

    // top
    pushMatrix();
        translate(0, -sphereDist * 1.3, 0);
        sphere(sphereScale);
    popMatrix();

    // bottom
    pushMatrix();
        translate(0, sphereDist * 1.3, 0);
        sphere(sphereScale);
    popMatrix();

    // left
    pushMatrix();
        translate(-sphereDist * 1.3, 0, 0);
        sphere(sphereScale);
    popMatrix();

    // right
    pushMatrix();
        translate(sphereDist * 1.3, 0, 0);
        sphere(sphereScale);
    popMatrix();

    // front
    pushMatrix();
        translate(0, 0, sphereDist * 1.3);
        sphere(sphereScale);
    popMatrix();

    // front
    pushMatrix();
        translate(0, 0, -sphereDist * 1.3);
        sphere(sphereScale);
    popMatrix();
}

void draw_planet() {
    fill(#ffdfc0);
    ellipse(0, 0, 30, 30);

    //beginShape(TRIANGLES);

    //texture(tex_moon);

    //vertex(0, -10, 256, 0);
    //vertex(-13, 10, 0, 512);
    //vertex(13, 10, 512, 512);

    //endShape();
}

void scene_spheres() {
    float spherePosition = (float)moon.getValue("spherePosition");

    noLights();
    // sphere lights
    directionalLight(255, 255, 255, -1, 1, 0);
    directionalLight(128, 128, 128, 1, 1, -1);

    pushMatrix();
        int sphereDistance = 10;
        translate(0, 0, -sphereDistance - spherePosition);

        float time = millis() / 1000.0;

        rotateY(2 * PI * time * 0.3);
        rotateX(2 * PI * time * 0.1);

        float sphereScale = 6.0 + (2.0 * sin(time) * (float)moon.getValue("sphereScale"));

        float sphereDist = 6.0;
        draw_spheres(sphereDist, sphereScale);
    popMatrix();
}

void scene_sun_moon() {
    noLights();

    // sun & moon
    pushMatrix();
        translate(200, -100, -200);
        draw_planet();
    popMatrix();

}

void scene_pyramids() {
    float viewRot = (float)moon.getValue("viewRot");
    float tunnelPosition = (float)moon.getValue("tunnelPosition");
    float lighting = (float)moon.getValue("ambientLight");

    int tunnelWidthFactor = 100;
    int tunnelWidth = 100;

    noLights();

    // pyramid lights

    ambientLight(lighting, lighting, lighting);

    directionalLight(128, 128, 128, 1, 1, -1);
    directionalLight(64, 64, 64, -1, 1, 0);

    rotateZ(PI * sin(viewRot * PI));

    pushMatrix();
        translate(0, 20, 0); // camera a little bit lower

        rotateX(-PI / 16);

        draw_horizon();
        draw_sky();

        translate(0, 0, tunnelPosition);

        if (debugMode) { draw_coords(); }

        fill(#C46E1B);

        int n_pyramids = 100;
        int pyramid_space = 160;
        for (int i = 0; i < n_pyramids; i++) {
            pushMatrix();
                translate(0, 0, -i * pyramid_space);

                if (debugMode) { draw_coords(); }

                pushMatrix();
                    translate(-tunnelWidth, 0, 0);
                    draw_pyramid();
                popMatrix();

                pushMatrix();
                    translate(tunnelWidth, 0, 0);
                    draw_pyramid();
                popMatrix();
            popMatrix();
        }

    popMatrix();
}

void da_scene() {
    background(#242424);

    float cubeRot = (float)moon.getValue("cubeRot");

    float fovFactor = (float)moon.getValue("camFov");
    set_perspective(fovFactor);

    rectMode(CENTER);

    if (debugMode) { draw_coords(); }

    scene_spheres();

    scene_sun_moon();

    scene_pyramids();
}

void draw() {
    moon.update();
    clear();
    da_scene();
}
