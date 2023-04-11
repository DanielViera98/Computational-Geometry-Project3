/**
 Class representing a Binary Space Partition tree for a 
 collection of line segments
 
 Primary operations are adding new Segments, drawing all
 Segments in the BSP, and executing the Painter's Algorithm
 to draw a view of the Segments at the given location
 
 Also has validation and toString functions for debugging
 */
public class BSPTree
{
  /*
   Inner class representing a single node of the BSP
   */
  private class BSPNode
  {
    private Segment s;
    private BSPNode left;
    private BSPNode right;
    /*
     Constructs a new leaf node with the given Segment
     */
    private BSPNode(Segment seg)
    {
      s = seg;
      left = right = null;
    }
    
    /*
     Recursive function to draw all Segments in the BSP
     */
    private void draw()
    {
      s.draw();
      if (left != null)
        left.draw();
      if (right != null)
        right.draw();
    }
    
    /*
     Recursive BSP insertion function: adds the given
     segment to the BSP
     
     If the segment is fully left or right of this node,
     it is inserted into the left or right subtree
     If it crosses the path of this node, it is split,
     and the pieces are inserted to the left and right
     
     Use the Segment.split(), Segment.isLeft(), and
     Segment.isRight() functions to split the Segment
     and determine whether it is to the left or right
     of the segment stored in this node.
     
     Note:  a.isLeft(b) returns whether b is to the 
     left of a
     */
    private void insert(Segment newSeg)
    {
      print("Seg P: ", s.p, "Seg Q: ", s.q, "\n");
      print("NewSeg P: ", newSeg.p, "NewSeg Q: ", newSeg.q, "\n");
      print("NEW SEG, s.isToLeft: ", s.isToLeft(newSeg), " - s.isToRight: ", s.isToRight(newSeg), "\n");
      //If segment splits, apply
      Segment test = new Segment();
      test = newSeg.split(s);
      if (s.isInline(newSeg.p) && s.isInline(newSeg.q)){
        if (left != null){
          print("Traverse LEFT\n");
          left.insert(newSeg);
        }
        else{
          print("Placing Left!\n");
          left = new BSPNode(newSeg);
        }
      }
      if (test != null){
        print("CROSSES SEGMENT\n");
        if (s.isToLeft(test)){
          if (left != null){
            print("Traverse LEFT\n");
            print(s.isToLeft(test));
            left.insert(test);
          }
          else{
            print(s.isToLeft(test));
            print("Placing Left!\n");
            left = new BSPNode(test);
          }
        }
        else if (s.isToRight(test)){
          if (right != null){
            print(s.isToRight(test));
            print("Traverse RIGHT\n");
            right.insert(test);
          }
          else{
            print(s.isToRight(test));
            print("Placing Right!\n");
            right = new BSPNode(test);
          }
        }
      }
      if (s.isToLeft(newSeg)){
        if (left != null){
          print("Traverse LEFT\n");
          print(s.isToLeft(newSeg));
          left.insert(newSeg);
        }
        else{
          print(s.isToLeft(newSeg));
          print("Placing Left!\n");
          left = new BSPNode(newSeg);
        }
      }
      else if (s.isToRight(newSeg)){
        if (right != null){
          print(s.isToRight(newSeg));
          print("Traverse RIGHT\n");
          right.insert(newSeg);
        }
        else{
          print(s.isToRight(newSeg));
          print("Placing Right!\n");
          right = new BSPNode(newSeg);
        }
      }
    }
    
    /*
     Recursive function that executes the Painter's Algorithm to
     draw the view of the BSP subtree at the given point
     
     Calls Segment.paintView(p) to draw the view
     */
    private void painters(PVector origin)
    {
      //If segment s is right of origin, traverse to the left node, paint the segment, then traverse to the right node.
      if (s.isToRight(origin) || s.isInline(origin)){
        if (left != null)
          left.painters(origin);
        s.paintView(origin);
        if (right != null)
          right.painters(origin);
      }
      else if (s.isToLeft(origin)){
        if (right != null)
          right.painters(origin);
        s.paintView(origin);
        if (left != null)
          left.painters(origin);
      }
    }
      
    /*
     Validation functions
     
     Attempts to validate that all segments in left subtree are to
     to the left and all segments in the right subtree are to the right
     of this node, and checks children recursively
     */
    private boolean validate()
    {
      boolean valid = true;
      if (left != null)
      {
        valid &= left.validateLeft(s);
        valid &= left.validate();
      }
      if (right != null)
      {
        valid &= right.validateRight(s);
        valid &= right.validate();
      }
      return valid;
    }
    private boolean validateLeft(Segment anc)
    {
      boolean valid = true;
      if (anc.isToRight(s.p) || anc.isToRight(s.q))
      {
        println("Error:  " + s + " is in left subtree of " + anc);
        valid = false;
      }
      if (left != null)
        valid &= left.validateLeft(anc);
      if (right != null)
        valid &= right.validateLeft(anc);
      return valid;
    }
    private boolean validateRight(Segment anc)
    {
      boolean valid = true;
      if (anc.isToLeft(s.p) || anc.isToLeft(s.q))
      {
        println("Error:  " + s + " is in right subtree of " + anc);
        valid = false;
      }
      if (left != null)
        valid &= left.validateRight(anc);
      if (right != null)
        valid &= right.validateRight(anc);
      return valid;
    }
    /*
     Transforms the BSP rooted at this node into a string
     */
    public String toString()
    {
      return "(" + s + "; L " + left + "; R " + right + ")";
    }
  }
  
  private BSPNode root;
  
  /**
   Constructs an empty BSP
   */
  public BSPTree()
  {
    root = null;
  }

  /**
   Adds the given Segment to the BSP
   */
  public void insert(Segment s)
  {
    if (root == null)
      root = new BSPNode(s);
    else
      root.insert(s);
  }

  /**
   Runs the Painter's Algorithm on the Segments in this
   BSP, painting a view of these Segments at the given location
   */
  public void painters(PVector origin)
  {
    if (root != null)
      root.painters(origin);
  }

  /**
   Draws all of the Segments in the BSP
   */
  public void draw()
  {
    if (root != null)
      root.draw();
  }

  /**
   Attempts to validate whether the BSP nodes and Segments
   are correct
   */
  public boolean validate()
  {
    if (root != null)
      return root.validate();
    else
      return true;
  }

  /**
   Returns a String representing the structure of the BSP
   */
  public String toString()
  {
    if (root != null)
      return root.toString();
    else
      return "empty";
  }
}
