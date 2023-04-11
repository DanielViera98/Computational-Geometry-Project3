/**
 Program that uses a Binary Space Partitioning tree to 
 showcase the Painter's Algorithm
 
 Controls:
  * Mouse over a color in the palette to the right to change color
  * Click twice to draw a line segment
  * Right click to draw 360 degree view based on Painter's Algorithm
   - Can hold and drag to move view
  * Type p to print your BSP to console
  * Type v to validate your BSP (outputs to console)
 */

BSPTree bsp;
Palette p;
PVector v;
color c;

void setup()
{
  size(640, 480);
  background(255);
  bsp = new BSPTree();
  p = new Palette();
  v = null;
  strokeWeight(2);
  c = color(0,0,0);
  stroke(c);
}

void draw() 
{
  background(255);
  p.draw();
  c = p.getColor(mouseX, mouseY, c);
  bsp.draw();
  if (mouseButton == RIGHT)
    bsp.painters(new PVector(mouseX, mouseY));
}

void mouseClicked()
{
  if (mouseButton == LEFT)
  {
    if (v == null)
      v = new PVector(mouseX, mouseY);
    else
    {
      Segment s = new Segment(v.x, v.y, mouseX, mouseY, c);
      bsp.insert(s);
      v = null;
    }
  }
}
void keyTyped()
{//, , , , , , #c000c0
  if (key == 'q'){
      Segment a = new Segment(120, 240, 456, 460, #000000);
      bsp.insert(a);
      Segment b = new Segment(125, 50, 500, 50, #ff0000);
      bsp.insert(b);
      Segment d = new Segment(300, 50, 300, 200, #c0c000);
      bsp.insert(d);
      Segment e = new Segment(53, 10, 500, 400, #00ff00);
      bsp.insert(e);
      Segment f = new Segment(34, 100, 56, 123, #00c0c0);
      bsp.insert(f);
      Segment g = new Segment(300, 50, 400, 50, #0000ff);
      bsp.insert(g);
      
      
      Segment h = new Segment(25, 25, 100, 25, #ff0000);
      bsp.insert(h);
      Segment i = new Segment(50, 25, 75, 25, #000000);
      bsp.insert(i);
      
      Segment j = new Segment(50, 75, 75, 75, #ff0000);
      bsp.insert(j);
      Segment k = new Segment(25, 75, 100, 75, #000000);
      bsp.insert(k);
      
  }
  if (key == 'p')
    println(bsp);
  else if (key == 'm')
    print("x:", mouseX, ",y:", mouseY, " ");
  else if (key == 'v')
    if (bsp.validate())
      println("BSP is valid!");
}
