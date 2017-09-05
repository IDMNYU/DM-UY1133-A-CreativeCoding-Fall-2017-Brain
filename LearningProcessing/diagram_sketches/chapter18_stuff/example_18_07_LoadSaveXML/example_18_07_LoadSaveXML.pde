/**
 * Loading XML Data
 * by Daniel Shiffman.  
 * 
 * This example demonstrates how to use loadXML()
 * to retrieve data from an XML file and make objects 
 * from that data.
 *
 * Here is what the XML looks like:
 *
 <?xml version="1.0"?>
 <bubbles>
 <bubble>
 <position x="160" y="103"/>
 <diameter>43.19838</diameter>
 <label>Happy</label>
 </bubble>
 <bubble>
 <position x="372" y="137"/>
 <diameter>52.42526</diameter>
 <label>Sad</label>
 </bubble>
 </bubbles>
 */
import processing.pdf.*;

// An Array of Bubble objects
Bubble[] bubbles;
// A Table object
XML xml;

void setup() {
  size(480, 270);
  loadData();
}

void draw() {
  if (record) {
    beginRecord(PDF, "18fig13_xmlbubbles.pdf");
  }  
  background(255);
  // Display all bubbles
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i].display();
    bubbles[i].rollover(mouseX, mouseY);
  }

  textAlign(LEFT);
  fill(0);
  text("Click to add bubbles.", 10, height-10);
  if (record) {
    endRecord();
    record = false;
  }
}

boolean record;
void mousePressed() {
  record = true;
}

void loadData() {
  // Load XML file
  xml = loadXML("data.xml");
  // Get all the child nodes named "bubble"
  XML[] children = xml.getChildren("bubble");

  // The size of the array of Bubble objects is determined by the total XML elements named "bubble"
  bubbles = new Bubble[children.length]; 

  for (int i = 0; i < bubbles.length; i++) {

    // The position element has two attributes: x and y
    XML positionElement = children[i].getChild("position");
    // Note how with attributes we can get an integer or float via getInt() and getFloat()
    float x = positionElement.getInt("x");
    float y = positionElement.getInt("y");

    // The diameter is the content of the child named "diamater"
    XML diameterElement = children[i].getChild("diameter");
    // Note how with the content of an XML node, we retrieve via getIntContent() and getFloatContent()
    float diameter = diameterElement.getFloatContent();

    // The label is the content of the child named "label"
    XML labelElement = children[i].getChild("label");
    String label = labelElement.getContent();

    // Make a Bubble object out of the data read
    bubbles[i] = new Bubble(x, y, diameter, label);
  }
}

// Still need to work on adding and deleting

//void mousePressed() {

//  // Create a new XML bubble element
//  XML bubble = xml.addChild("bubble");

//  // Set the poisition element
//  XML position = bubble.addChild("position");
//  // Here we can set attributes as integers directly
//  position.setInt("x", mouseX);
//  position.setInt("y", mouseY);

//  // Set the diameter element
//  XML diameter = bubble.addChild("diameter");
//  // Here for a node's content, we have to convert to a String
//  diameter.setFloatContent(random(40, 80));

//  // Set a label
//  XML label = bubble.addChild("label");
//  label.setContent("New label");


//  // Here we are removing the oldest bubble if there are more than 10
//  XML[] children = xml.getChildren("bubble");
//  // If the XML file has more than 10 bubble elements
//  if (children.length > 10) {
//    // Delete the first one
//    xml.removeChild(children[0]);
//  }

//  // Save a new XML file
//  saveXML(xml, "data/data.xml");

//  // reload the new data 
//  loadData();
//}