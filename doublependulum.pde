PGraphics pg;

float r1 = 150;
float r2 = 150;
float m1 = 50; //mass of pendulum pieces (m1 and m2)
float m2 = 50;
float a1 = PI/2 + random(-.01, .01); //initial angles of pendulum (a1 a2)
float a2 = PI/2 + random(-.01, .01);
float a1_v = 0;
float a2_v = 0;
float g = 3;   //strength of gravity
float px2 = -1;
float py2 = -1;

color one = #e91e63;    //color of pendulum and path
color one_d = #b0003a;  //ellipse stroke color
color bg = #fafafa;     //background

void setup() {
    frameRate(60);
    size(1000, 1000);
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(bg);
    pg.endDraw();
}

void draw() {
    float num1 = -g * (2 * m1 + m2) * sin(a1);
    float num2 = -m2 * g * sin(a1 - 2 * a2);
    float num3 = -2 * sin(a1 - a2) * m2;
    float num4 = a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos (a1-a2);
    float den = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
    float a1_a = (num1 + num2 + num3 * num4) / den; // a1'' (2nd time derivative)

    num1 = 2 * sin(a1 - a2);
    num2 = (a1_v * a1_v * r1 * (m1 + m2));
    num3 = g * (m1 + m2) * cos(a1);
    num4 = a2_v * a2_v * r2 * m2 * cos(a1 - a2);
    den = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
    float a2_a = (num1 * (num2 + num3 + num4)) / den; //a2'' (2nd time derivative)

    a1_v += a1_a;
    a2_v += a2_a;
    a1 += a1_v;
    a2 += a2_v;

    image(pg, 0, 0);
    stroke(one);
    strokeWeight(7);
    translate(500, 300);
    
    float x1 = r1 * sin(a1);
    float y1 = r2 * cos(a1);

    float x2 = x1 + r2*sin(a2);
    float y2 = y1 + r2*cos(a2);

    line(0, 0, x1, y1);
    fill(one);
    stroke(one_d);
    strokeWeight(7);
    ellipse(x1, y1, m1, m1);
    ellipse(x2, y2, m2, m2);
    stroke(one);
    line(x1, y1, x2, y2);

    //a1_v *= .999; to add damping (friction)
    //a2_v *= .999;

    pg.beginDraw();
    pg.strokeWeight(1); //Weight of the traced path
    pg.stroke(one);
    pg.translate(500,300);
    if (frameCount>1) {
      pg.line(px2, py2, x2, y2);
    }
    pg.endDraw();
    px2 = x2;
    py2 = y2;

    //saveFrame("save/doublependulum_####.png"); use this to save each frame to a png
}
