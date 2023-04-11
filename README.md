# Computational-Geometry-Project3

Implements the painter algorithm on user input. User can input lines which are added to a bsptree. User does this by clicking on the screen, if the user hovers over a color on the right side of the screen it will change the color of the line they are drawing. Every two clicks creates a new line. When the user right clicks, it implements the painters algorithm to create an arc around the mouse to show what lines are visible at that point. It does this by drawing view arcs with the furthest lines first, moving in toward the nearest lines.

All code provided except for BSPTree - private void insert, BSPTree - private void painters, and painters - void Keytyped - key == q
insert: adds line to bsptree. If new line is left of current node's line, move to left node if available, if right of current node, move right. If left/right == null, place segment in new node at left/right. If both beginning and end of line is inline with the current segment, default to adding at left of current node. If node crosses the line created by the current node's segment, split at the intersection and call insert on the new segment created, so both segments are added on left/right.
painters: creates the arc, if mouse is left of current node, go right (because proccessing has an inverse grid). IF mouse is right, go left. When you reach the end of the bsptree, start drawing arcs. Due to recursion, farther nodes have their arcs covered by nearer arcs.
keytyped - key == q: adds hardcoded input so that special cases can be accounted for.
