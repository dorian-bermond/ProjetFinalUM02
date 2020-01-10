//Balls information
  //Variables
  //Defined
//int MAX_LINK_DISTANCE = int(2 * typicalBallSize) ;
String INDICATOR = "score" ;
int MAX_NUMBER_OF_CHARACTERS = 250 ;
int TEXT_DISTANCE = 10 ;
float BAR_SEPARATION_COEF = 0.25 ;
int WIDTH_SCREEN_USED = 85 ;
int HEIGHT_SCREEN_USED = 60 ;
int PERCENTAGE_OF_X_AXIS_USED = 100 ;
int PERCENTAGE_OF_Y_AXIS_USED = 85 ;
int AXIS_WIDTH = 1 ;
float BORDER_SIZE_COEF = 0.15 ;
String TITLE = "Scores of the top " + MAX_NUMBER_OF_CHARACTERS + " Game of Thrones characters, acoording to the Wiki of Ice and Fire on *date*" ;
String HEADLINE = "Interactions on Game Of Thrones characters" ;
float PROPORTION_TOP = 2.0/3 ;
float PROPORTION_LEFT = 1.0/2 ;
float WIDEN_BUTTONS_COEF = 1.5 ;

//Defined through the execution
int xAxisSize = 0 ;
int yAxisSize = 0 ;
int barMaxSize = 0 ;
float barWidth = 0 ;
//int barSeparation = 0 ;
float maxInd = 0 ;
float minInd = 0 ;
float incrementOfMaxInd = 0 ;
float incrementOfMinInd = 0 ;
int xOrigin = 0 ;
int yOrigin = 0 ;
int buttonsSize = 0 ;
int buttonsY = 0 ;
ArrayList<Float> graduations = new ArrayList<Float>() ;

//Function related
int arrowHeight = 4 * AXIS_WIDTH ;
int arrowWidth = 4 * AXIS_WIDTH ;
int gradSize = 2 * AXIS_WIDTH ;
int gradTextSpace = AXIS_WIDTH ;
int initialsTextSpace = 2 * AXIS_WIDTH ;

int currentIndex = 0 ;
Table table ;

void drawTitle()
{
  //Design
  textAlign(CENTER, TOP) ;
  fill(0) ;
  //Headline
  textSize(24) ;
  text(HEADLINE, width / 2, 0) ;
  //Title
  textSize(18) ;
  text(TITLE, width / 2, 30) ;
}

void initDimensions()
{
  xAxisSize = int(width * WIDTH_SCREEN_USED / 100) ;
  yAxisSize = int(height * HEIGHT_SCREEN_USED / 100) ;
  barMaxSize = int(yAxisSize * PERCENTAGE_OF_Y_AXIS_USED / 100) ;
  barWidth = (xAxisSize * PERCENTAGE_OF_X_AXIS_USED / 100) / (MAX_NUMBER_OF_CHARACTERS * (1.0 + BAR_SEPARATION_COEF) + 2.0 * BAR_SEPARATION_COEF) ;
  //barSeparation = int(barWidth * BAR_SEPARATION_COEF) ;
  xOrigin = int((width - xAxisSize) * PROPORTION_LEFT) ;
  yOrigin = height - int((height - yAxisSize) * (1.0 - PROPORTION_TOP)) ;
  buttonsSize = int(min(yAxisSize - barMaxSize, int((xAxisSize * 3 / 4) / 10)) * WIDEN_BUTTONS_COEF) ;
  buttonsY = yOrigin - yAxisSize ;
}

class House
{
  int[] borderColor ;
  //int borderColorG ;
  //int borderColorB ;
  int[] fillColor ;
  //int fillColorG ;
  //int fillColorB ;
  boolean active ;
  boolean hovered ;

  House ()
  {
    borderColor = new int[3] ;
    fillColor = new int[3] ;
    active = true ;
    hovered = false ;
  }
}

House sta, arr, lan, tyr, gre, mar, bar, tar, tul, oth ;

void initHouses()
{
  int[] greyClr = {100, 100, 100} ;
  int[] whiteClr = {255, 255, 255} ;
  int[] blueClr = {21, 102, 255} ;
  int[] redClr = {153, 0, 0} ;
  int[] yellowClr = {255, 204, 0} ;
  int[] greenClr = {51, 102, 0} ;
  int[] blackClr = {0, 0, 0} ;

  //House Stark
  sta = new House() ;
  sta.borderColor[0] = greyClr[0] ;
  sta.borderColor[1] = greyClr[1] ;
  sta.borderColor[2] = greyClr[2] ;
  sta.fillColor[0] = whiteClr[0] ;
  sta.fillColor[1] = whiteClr[1] ;
  sta.fillColor[2] = whiteClr[2] ;
  //House Arryn
  arr = new House() ;
  arr.borderColor[0] = blueClr[0] ;
  arr.borderColor[1] = blueClr[1] ;
  arr.borderColor[2] = blueClr[2] ;
  arr.fillColor[0] = whiteClr[0] ;
  arr.fillColor[1] = whiteClr[1] ;
  arr.fillColor[2] = whiteClr[2] ;
  //House Lannister
  lan = new House() ;
  lan.borderColor[0] = redClr[0] ;
  lan.borderColor[1] = redClr[1] ;
  lan.borderColor[2] = redClr[2] ;
  lan.fillColor[0] = yellowClr[0] ;
  lan.fillColor[1] = yellowClr[1] ;
  lan.fillColor[2] = yellowClr[2] ;
  //House Tyrell
  tyr = new House() ;
  tyr.borderColor[0] = greenClr[0] ;
  tyr.borderColor[1] = greenClr[1] ;
  tyr.borderColor[2] = greenClr[2] ;
  tyr.fillColor[0] = yellowClr[0] ;
  tyr.fillColor[1] = yellowClr[1] ;
  tyr.fillColor[2] = yellowClr[2] ;
  //House Greyjoy
  gre = new House() ;
  gre.borderColor[0] = blackClr[0] ;
  gre.borderColor[1] = blackClr[1] ;
  gre.borderColor[2] = blackClr[2] ;
  gre.fillColor[0] = yellowClr[0] ;
  gre.fillColor[1] = yellowClr[1] ;
  gre.fillColor[2] = yellowClr[2] ;
  //House Martell
  mar = new House() ;
  mar.borderColor[0] = yellowClr[0] ;
  mar.borderColor[1] = yellowClr[1] ;
  mar.borderColor[2] = yellowClr[2] ;
  mar.fillColor[0] = redClr[0] ;
  mar.fillColor[1] = redClr[1] ;
  mar.fillColor[2] = redClr[2] ;
  //House Baratheon
  bar = new House() ;
  bar.borderColor[0] = yellowClr[0] ;
  bar.borderColor[1] = yellowClr[1] ;
  bar.borderColor[2] = yellowClr[2] ;
  bar.fillColor[0] = greyClr[0] ;
  bar.fillColor[1] = greyClr[1] ;
  bar.fillColor[2] = greyClr[2] ;
  //House Targaryen
  tar = new House() ;
  tar.borderColor[0] = blackClr[0] ;
  tar.borderColor[1] = blackClr[1] ;
  tar.borderColor[2] = blackClr[2] ;
  tar.fillColor[0] = redClr[0] ;
  tar.fillColor[1] = redClr[1] ;
  tar.fillColor[2] = redClr[2] ;
  //House Tully
  tul = new House() ;
  tul.borderColor[0] = redClr[0] ;
  tul.borderColor[1] = redClr[1] ;
  tul.borderColor[2] = redClr[2] ;
  tul.fillColor[0] = blueClr[0] ;
  tul.fillColor[1] = blueClr[1] ;
  tul.fillColor[2] = blueClr[2] ;
  //Others
  oth = new House() ;
  oth.borderColor[0] = blackClr[0] ;
  oth.borderColor[1] = blackClr[1] ;
  oth.borderColor[2] = blackClr[2] ;
  oth.fillColor[0] = greyClr[0] ;
  oth.fillColor[1] = greyClr[1] ;
  oth.fillColor[2] = greyClr[2] ;
}
House determineHouse (String name)
{
  name = name.toLowerCase() ;
  if (name.indexOf("stark") != -1)
  {
    return sta ;
  }
  else if (name.indexOf("arryn") != -1)
  {
    return arr ;
  }
  else if (name.indexOf("lannister") != -1)
  {
    return lan ;
  }
  else if (name.indexOf("tyrell") != -1)
  {
    return tyr ;
  }
  else if (name.indexOf("greyjoy") != -1)
  {
    return gre ;
  }
  else if (name.indexOf("martell") != -1)
  {
    return mar ;
  }
  else if (name.indexOf("baratheon") != -1)
  {
    return bar ;
  }
  else if (name.indexOf("targaryen") != -1)
  {
    return tar ;
  }
  else if (name.indexOf("tully") != -1)
  {
    return tul ;
  }
  else return oth ;
}

class Button
{
  House house ;
  String name ;
  int posXleftUpCorner ;

  Button(House Maison, String Name, int index)
  {
    house = Maison ;
    name = Name ;
    posXleftUpCorner = int(xOrigin + xAxisSize - (10 - index) * buttonsSize) ;
    //println("Button #" + index + " : X = " + posXleftUpCorner + " ; Y = " + posYleftUpCorner) ;
  }
}

ArrayList<Button> buttons = new ArrayList<Button>() ;

void initButtons()
{
  buttons.add(new Button(sta, "Stark", 0)) ;
  buttons.add(new Button(arr, "Arryn", 1)) ;
  buttons.add(new Button(lan, "Lannister", 2)) ;
  buttons.add(new Button(tyr, "Tyrell", 3)) ;
  buttons.add(new Button(gre, "Greyjoy", 4)) ;
  buttons.add(new Button(mar, "Martell", 5)) ;
  buttons.add(new Button(bar, "Baratheon", 6)) ;
  buttons.add(new Button(tar, "Targaryen", 7)) ;
  buttons.add(new Button(tul, "Tully", 8)) ;
  buttons.add(new Button(oth, "Others", 9)) ;
}


int randint(int low, int high)
{
  return int(random(low, high)) ;
}

String getInitials(String name)
{
  String initials = "" ;
  /*String[] temp = name.split("(") ;
  name = temp[0] ;*/
  String[] parts = name.split(" ") ;
  for (int i = 0 ; i < parts.length ; i++)
  {
    initials += parts[i].substring(0,1) ;
  }
  return initials ;
}

class Bar
{
  String name ;
  String initials ;
  House house ;
  int index ;
  int size ;
  float indicator ;
  float posX ;
  boolean hovered ;

  Bar (String Name, int Size, House itsHouse, float Indicator)
  {
    name = Name ;
    initials = getInitials(Name) ;
    house = itsHouse ;
    index = currentIndex ;
    size = Size ;
    indicator = Indicator ;
    posX = xOrigin + AXIS_WIDTH + barWidth * (index * (1 + BAR_SEPARATION_COEF) + BAR_SEPARATION_COEF) ;
    hovered = false ;
  }
}

ArrayList<Bar> tabBar = new ArrayList<Bar>() ;

void drawBar(Bar bar)
{
  float darkenTextPercent = 66 ;
  if (bar.house.active)
  {
    //Bar
    //fill(bar.house.fillColor[0], bar.house.fillColor[1], bar.house.fillColor[2]) ;
    strokeWeight(AXIS_WIDTH) ;
    stroke(0) ;
    noStroke() ;

    if (bar.hovered)
    {
      int whiteRectOpacity = 220 ;
      
      //Redraw Red Bar
      fill(255, 0, 0) ;
      rect(bar.posX, yOrigin - bar.size, barWidth, bar.size) ;
      stroke(255, 0, 0, 255) ;
      strokeWeight(int(AXIS_WIDTH / 2)) ;
      line(xOrigin - gradSize, yOrigin - bar.size, xOrigin + xAxisSize + gradSize, yOrigin - bar.size) ;
      fill(255, 0, 0) ;
      textSize(12) ;
      //Left graduation
      textAlign(RIGHT, BOTTOM) ;
      text(bar.indicator, xOrigin - gradSize -gradTextSpace, yOrigin - bar.size - initialsTextSpace) ;
      //Left graduation
      textAlign(LEFT, BOTTOM) ;
      text(bar.indicator, xOrigin + xAxisSize + gradSize + gradTextSpace, yOrigin - bar.size - initialsTextSpace) ;
      /*if (float(index) / MAX_NUMBER_OF_CHARACTERS < 0.5)
      {*/
        textAlign(RIGHT, BOTTOM) ;
        text(bar.name, xOrigin + xAxisSize - barWidth * BAR_SEPARATION_COEF, yOrigin - bar.size - initialsTextSpace) ;
      //} else {
        noStroke() ;
        fill(255, whiteRectOpacity) ;
        rect(xOrigin + barWidth * BAR_SEPARATION_COEF, yOrigin - bar.size - (initialsTextSpace / 2) - 16, int(bar.name.length() * 7), 20) ;
        textAlign(LEFT, BOTTOM) ;
        fill(255, 0, 0) ;
        text(bar.name, xOrigin + barWidth * BAR_SEPARATION_COEF, yOrigin - bar.size - initialsTextSpace) ;
      //}
      //println("Triggered on index " + index) ;
    } else {
      if (bar.house.hovered)
        fill(105) ;
      else
        fill(205) ;
      rect(bar.posX, yOrigin - bar.size, barWidth, bar.size) ;

    }
    //Text
    textAlign(CENTER, CENTER) ;
    //fill(bar.house.borderColor[0] * darkenTextPercent / 100, bar.house.borderColor[1] * darkenTextPercent / 100, bar.house.borderColor[2] * darkenTextPercent / 100) ;
    if (barWidth > 50)
    {
      fill(0) ;
      textSize(12) ;
      textAlign(CENTER, TOP) ;
      text(bar.initials, bar.posX + int(barWidth / 2), yOrigin + initialsTextSpace) ;
    }
    //println("initials = " + bar.initials) ;
  }
}

float get10power(float indicator)
{
  float result ;
  if (indicator == 0)
  {
      result = 0 ;
  } else if (indicator > 0) {
    result = 1 ;
    if (indicator < result)
    {
      while (indicator < result)
        result /= 10 ;
    } else {
      while (indicator > result)
        result *= 10 ;
        result /= 10 ;
    }
  } else {
    result = -1 ;
    if (indicator > result)
    {
      while (indicator > result)
        result /= 10 ;
    } else {
      while (indicator < result)
        result *= 10 ;
      result /= 10 ;
    }
  }
  return result ;
}

void defineGraduations()
{
  graduations.clear() ;
  float maxInd10Power = get10power(maxInd) ;
  float minInd10Power = get10power(minInd) ;
  float upperLimit = maxInd ;
  /*println("maxInd = " + maxInd + " maxInd10Power = " + maxInd10Power) ;
  println("minInd = " + minInd + " minInd10Power = " + minInd10Power) ;*/
  for (int time = 0 ; time < 2 && maxInd10Power >= minInd10Power ; time++)
  {
    graduations.clear() ;
    for (float i = 0 ; maxInd10Power * i < upperLimit ; i += 2.5)
    {
      //println("i = " + i + " maxInd10Power * (1.0 + i / 10) = " + maxInd10Power * (1.0 + i / 10.0)) ;
      //if (((time == 0) || (int((maxInd10Power * i) / 25) * 25 != (maxInd10Power * i))) && (maxInd10Power * (i + 1) >= minInd))
      if (maxInd10Power * (i + 1) >= minInd)
      {
        graduations.add(maxInd10Power * i) ;
        //printl("i = " + i + " adding " + maxInd10Power * i) ;
      }
    }
    //upperLimit = maxInd10Power ;
    maxInd10Power /= 10 ;
  }
  graduations.add(maxInd) ;
  graduations.add(0.0) ;
  /*println("Grad = ") ;
  for (Float grad : graduations)
    print(grad + ", ") ;
  println(".") ;*/
}

void drawAxis()
{
  //
  //Design
  strokeWeight(AXIS_WIDTH) ;
  stroke(0) ;
  fill(0) ;
  textSize(12) ;
  textAlign(RIGHT, CENTER) ;
  //Define y axis scale
  for (Float grad : graduations)
  {
    int gradHeight = int(barMaxSize * grad / maxInd) ;
    line(xOrigin, yOrigin - gradHeight, xOrigin - gradSize, yOrigin - gradHeight) ;
    if (int(grad) == grad)
      text(int(grad), xOrigin - gradSize - gradTextSpace, yOrigin - gradHeight) ;
    else
      text(str(grad), xOrigin - gradSize - gradTextSpace, yOrigin - gradHeight) ;
  }
  //Unit of Y xAxis
  text(INDICATOR, xOrigin - arrowWidth / 2 - gradTextSpace, yOrigin - yAxisSize) ;
  //Design
  fill(255) ;
  //Y Axis
  line(xOrigin, yOrigin - yAxisSize, xOrigin, yOrigin) ;
  triangle(xOrigin, yOrigin - yAxisSize, xOrigin - arrowWidth / 2, yOrigin - yAxisSize + arrowHeight, xOrigin + arrowWidth / 2, yOrigin - yAxisSize + arrowHeight) ;
  //Graduation Design
  strokeWeight(AXIS_WIDTH) ;
  stroke(0) ;
  fill(0) ;
  textSize(12) ;
  textAlign(LEFT, CENTER) ;
  //Define secondary y axis scale
  for (Float grad : graduations)
  {
    int gradHeight = int(barMaxSize * grad / maxInd) ;
    line(xOrigin + xAxisSize, yOrigin - gradHeight, xOrigin + xAxisSize + gradSize, yOrigin - gradHeight) ;
    if (int(grad) == grad)
      text(int(grad), xOrigin + xAxisSize + gradSize + gradTextSpace, yOrigin - gradHeight) ;
    else
      text(str(grad), xOrigin + xAxisSize + gradSize + gradTextSpace, yOrigin - gradHeight) ;
  }
  //Unit of secondary Y xAxis
  text(INDICATOR, xOrigin + xAxisSize + arrowWidth / 2 + gradTextSpace, yOrigin - yAxisSize) ;
  //Design
  fill(255) ;
  //secondary Y Axis
  line(xOrigin + xAxisSize, yOrigin - yAxisSize, xOrigin + xAxisSize, yOrigin) ;
  triangle(xOrigin + xAxisSize, yOrigin - yAxisSize, xOrigin - arrowWidth / 2  + xAxisSize, yOrigin - yAxisSize + arrowHeight, xOrigin + arrowWidth / 2  + xAxisSize, yOrigin - yAxisSize + arrowHeight) ;
  //X Axis
  line(xOrigin, yOrigin, xOrigin + xAxisSize, yOrigin) ;
  //triangle(xOrigin + xAxisSize, yOrigin, xOrigin + xAxisSize - arrowHeight, yOrigin - arrowWidth / 2 , xOrigin + xAxisSize - arrowHeight, yOrigin + arrowWidth / 2) ;

}

void setup()
{
  //fullScreen() ;
  size(1300, 650) ;
  initHouses() ;
  initDimensions() ;
  initButtons();
  textAlign(CENTER, CENTER) ;

  int size ;
  TableRow row ;
  House house ;

  table = loadTable("../GOT.csv", "header") ;
  table.sortReverse(INDICATOR) ;

  maxInd = table.getRow(0).getFloat(INDICATOR) ;
  incrementOfMaxInd = get10power(maxInd) / 4 ;
  if ((maxInd % incrementOfMaxInd) != 0)
    maxInd = (int(maxInd / incrementOfMaxInd) + 1) * incrementOfMaxInd ;

  minInd = table.getRow(MAX_NUMBER_OF_CHARACTERS).getFloat(INDICATOR) ;
  incrementOfMinInd = get10power(minInd) / 4 ;
  if ((minInd % incrementOfMinInd) != 0)
    minInd = (int(minInd / incrementOfMinInd) + 1) * incrementOfMinInd ;

  defineGraduations() ;

  for (int i = 0 ; i < MAX_NUMBER_OF_CHARACTERS ; i++)
  {
    row = table.getRow(i) ;
    size = int(barMaxSize * row.getFloat(INDICATOR) / maxInd) ;
    house = determineHouse(row.getString("common_name")) ;
    tabBar.add(new Bar(row.getString("short_name"), size, house, row.getFloat(INDICATOR))) ;
    currentIndex++ ;
  }
}

void drawButtons()
{
  int borderSize = int(buttonsSize * BORDER_SIZE_COEF) ;
  strokeWeight(borderSize) ;
  textAlign(CENTER, CENTER) ;
  textSize(12) ;
  for (Button but : buttons)
  {
    if (but.house.active)
    {
      stroke(but.house.borderColor[0], but.house.borderColor[1], but.house.borderColor[2]) ;
      fill(but.house.fillColor[0], but.house.fillColor[1], but.house.fillColor[2]) ;
      rect(but.posXleftUpCorner - int(borderSize / 2) , buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
      fill(but.house.borderColor[0], but.house.borderColor[1], but.house.borderColor[2]) ;
      text(but.name, but.posXleftUpCorner - int(borderSize / 2) , buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
    }
    else
    {
      stroke(but.house.borderColor[0], but.house.borderColor[1], but.house.borderColor[2], 100) ;
      fill(but.house.fillColor[0], but.house.fillColor[1], but.house.fillColor[2], 100) ;
      rect(but.posXleftUpCorner - int(borderSize / 2), buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
      fill(but.house.borderColor[0], but.house.borderColor[1], but.house.borderColor[2], 100) ;
      text(but.name, but.posXleftUpCorner - int(borderSize / 2) , buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
    }
  }
}

void hover()
{
  //Init all to false
  for (Button but : buttons)
    but.house.hovered = false ;
  for (Bar bar : tabBar)
    bar.hovered = false ;
    
  if (mouseX >= xOrigin && mouseX <= xOrigin + xAxisSize)
  {
    // In the graph
    if (mouseY <= yOrigin && mouseY >= yOrigin - barMaxSize)
    {
      //Bars
      int graphicsX = int(mouseX - (xOrigin + AXIS_WIDTH + BAR_SEPARATION_COEF * barWidth)) ;
      int graphicsY = - (mouseY - yOrigin) ;
      int index = int(graphicsX / (barWidth * (1 + BAR_SEPARATION_COEF))) ;
      int rest = int(graphicsX - index * (barWidth * (1 + BAR_SEPARATION_COEF))) ;
      if (index < MAX_NUMBER_OF_CHARACTERS && rest >= barWidth * BAR_SEPARATION_COEF)
      {
        Bar hoveredBar = tabBar.get(index) ;
        if (graphicsY > 0 && graphicsY <= hoveredBar.size && hoveredBar.house.active)
          {
            hoveredBar.hovered = true ;
          }
      }
    } else if (mouseY >= buttonsY && mouseY <= buttonsY + buttonsSize) {
      //Potentially houses
      for (Button but : buttons)
      {
        int temp = mouseX - but.posXleftUpCorner ;
        if (temp >= 0 && temp < buttonsSize)
          but.house.hovered = true ;
        else
          but.house.hovered = false ;
      }
    }
  }
}

void draw()
{
  background(255) ;
  drawButtons() ;
  for (Bar bar : tabBar)
    drawBar(bar) ;
  drawAxis() ;
  drawTitle() ;
  hover() ;
}

void mouseClicked()
{
  int firstButtonX = buttons.get(0).posXleftUpCorner ;
  if (mouseX >= firstButtonX && mouseX <= firstButtonX + 10 * buttonsSize && mouseY >= buttonsY && mouseY <= buttonsY + buttonsSize)
  {
    buttons.get(int((mouseX - firstButtonX) / buttonsSize)).house.active = !buttons.get(int((mouseX - firstButtonX) / buttonsSize)).house.active ;
    println("Button " + buttons.get(int((mouseX - firstButtonX) / buttonsSize)).name + " clicked (now " + buttons.get(int((mouseX - firstButtonX) / buttonsSize)).house.active +")") ;
  }
}
