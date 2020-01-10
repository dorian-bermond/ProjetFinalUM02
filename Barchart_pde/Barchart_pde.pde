import java.util.Collections ;

String path = "../Datasets/beers-reworked-no-nan.csv" ;
String Y_THING = "number" ;
String X_THING = "state" ;
String G_THING = "" ;
int MAX_BARS = 50 ;
int MAX_N_GROUP = int(MAX_BARS / 5) ;
int TEXT_DISTANCE = 10 ;
float BAR_SEPARATION_COEF = 0.25 ;
int WIDTH_SCREEN_USED = 85 ;
int HEIGHT_SCREEN_USED = 60 ;
int USED_FOR_GRAPH = 75 ;
int PERCENTAGE_OF_X_AXIS_USED = 100 ;
int PERCENTAGE_OF_Y_AXIS_USED = 85 ;
int AXIS_WIDTH = 1 ;
float BORDER_SIZE_COEF = 0.15 ;
float PROPORTION_TOP = 2.0/3 ;
float PROPORTION_LEFT = 1.0/2 ;
float WIDEN_BUTTONS_COEF = 1.5 ;
int CHOICES_TEXT_SIZE = 18 ;
float CHOICES_TEXT_INTERLINE_FACTOR = .5 ;
int CHOICES_BOX_SIZE = 20 ;
float CHOICES_BOX_SEP_FACTOR = 1.0 ;
int CHOICES_SEP_LINE_PERCENT = 75 ;

//Defined through the execution
int headlineSize ;
float titleHeadlineFactor = 2.0/3 ;
int xDisplayed = MAX_BARS ;
int nDivision = 0 ;
int xAxisSize = 0 ;
int yAxisSize = 0 ;
int barMaxSize = 0 ;
float barWidth = 0 ;
//int barSeparation = 0 ;
float maxInd = 0 ;
float minInd = 0 ;
float incrementOfMaxInd = 0 ;
float incrementOfMinInd = 0 ;
int xGraphOrigin = 0 ;
int yGraphOrigin = 0 ;
int xChoicesOrigin = 0 ;
int yChoicesOrigin = 0 ;
int xChoicesSize = 0 ;
int buttonsSize = 0 ;
int buttonsY = 0 ;
ArrayList<Float> graduations = new ArrayList<Float>() ;
ArrayList<XY> listXY = new ArrayList<XY>() ;
XY tempXY ;
int firstChoiceasX_X = 0 ;
int firstChoiceasX_Y = 0 ;
int firstChoiceasY_X = 0 ;
int firstChoiceasY_Y = 0 ;

//Function related
int arrowHeight = 4 * AXIS_WIDTH ;
int arrowWidth = 4 * AXIS_WIDTH ;
int gradSize = 2 * AXIS_WIDTH ;
int gradTextSpace = AXIS_WIDTH ;
int initialsTextSpace = 2 * AXIS_WIDTH ;

int currentIndex = 0 ;
Table table ;


class Choice
{
  String name ;
  String indicator ;
  boolean validX ;
  boolean validY ;

  Choice (String N, String I, boolean X, boolean Y)
  {
    name = N ;
    indicator = I ;
    validX = X ;
    validY = Y ;
  }
}

void initDimensions()
{
  xAxisSize = int(width * WIDTH_SCREEN_USED / 100.0 * USED_FOR_GRAPH / 100.0) ;
  xChoicesSize = int(width * WIDTH_SCREEN_USED / 100.0 * (1.0 - (USED_FOR_GRAPH / 100.0))) ;
  yAxisSize = int(height * HEIGHT_SCREEN_USED / 100) ;
  barMaxSize = int(yAxisSize * PERCENTAGE_OF_Y_AXIS_USED / 100) ;
  //barSeparation = int(barWidth * BAR_SEPARATION_COEF) ;
  xGraphOrigin = int((width - xAxisSize - xChoicesSize) * PROPORTION_LEFT) ;
  yGraphOrigin = height - int((height - yAxisSize) * (1.0 - PROPORTION_TOP)) ;
  xChoicesOrigin = xGraphOrigin + xAxisSize + int(.25 * xChoicesSize) ;
  yChoicesOrigin = int((height - yAxisSize) * (PROPORTION_TOP)) ;
  /*buttonsSize = int(min(yAxisSize - barMaxSize, int((xAxisSize * 3 / 4) / 10)) * WIDEN_BUTTONS_COEF) ;
  buttonsY = yGraphOrigin - yAxisSize ;**/
  headlineSize = int(height / 30) ;
  CHOICES_BOX_SIZE = int(headlineSize * titleHeadlineFactor) ;
}

ArrayList<Choice> choices = new ArrayList<Choice>() ;

void initChoices()
{
  choices.add(new Choice ("Amount", "number", false, true)) ;
  choices.add(new Choice ("ABV (Alcohol By Volume)", "abv", false, true)) ;
  choices.add(new Choice ("Countries", "country", true, false)) ;
  choices.add(new Choice ("Countries & US States", "state", true, false)) ;
  choices.add(new Choice ("Style Categories", "group", true, false)) ;
  choices.add(new Choice ("Styles", "style", true, false)) ;
  choices.add(new Choice ("Periods of availability", "availability", true, false)) ;
}

void drawChoices()
{
  int currentY = yChoicesOrigin ;
  int currentTextSize = int(headlineSize * titleHeadlineFactor) ;
  int x1, x2, y1, y2 ;
  //Titles
  textAlign(LEFT, TOP) ;
  textSize(currentTextSize) ;
  text("Categories as...", xChoicesOrigin, currentY) ;
  textAlign(CENTER, TOP) ;
  text("Y", xChoicesOrigin + xChoicesSize - int(CHOICES_BOX_SIZE / 2), currentY) ;
  text("X", xChoicesOrigin + xChoicesSize - int(3 * (CHOICES_BOX_SIZE / 2) + CHOICES_BOX_SIZE * CHOICES_BOX_SEP_FACTOR), currentY) ;
  currentY += int(currentTextSize * (1 + (CHOICES_TEXT_INTERLINE_FACTOR / 2))) ;

  stroke(0) ;
  strokeWeight(AXIS_WIDTH) ;
  x1 = xChoicesOrigin + int(xChoicesSize * (100 - CHOICES_SEP_LINE_PERCENT) / 100 / 2) ;
  y1 = currentY ;
  x2 = xChoicesOrigin + int((xChoicesSize * (100 - CHOICES_SEP_LINE_PERCENT) / 100 / 2 ) + (xChoicesSize * (CHOICES_SEP_LINE_PERCENT / 100))) ;
  y2 = currentY ;
  line(x1, y1, x2, y2) ;

  currentY += int(currentTextSize * (CHOICES_TEXT_INTERLINE_FACTOR / 2)) ;
  //CHOICES
  firstChoiceasX_X = xChoicesOrigin + xChoicesSize -  int(CHOICES_BOX_SIZE * (2.0 + CHOICES_BOX_SEP_FACTOR)) ;
  firstChoiceasX_Y = currentY ;
  firstChoiceasY_X = xChoicesOrigin + xChoicesSize - CHOICES_BOX_SIZE ;
  firstChoiceasY_Y = currentY ;

  textAlign(LEFT, TOP) ;
  rectMode(CORNER) ;
  for (Choice c : choices)
  {
    fill(0) ;
    text(c.name, xChoicesOrigin, currentY) ;
    //Boxes
    stroke(0) ;
    strokeWeight(AXIS_WIDTH) ;
    if (c.validY)
    {
      if (X_THING == c.indicator)
      {
        fill(155) ;
      } else {
        fill(255) ;
      }
      square(xChoicesOrigin + xChoicesSize - CHOICES_BOX_SIZE, currentY, CHOICES_BOX_SIZE) ;
      if (Y_THING == c.indicator)
      {
        x1 = xChoicesOrigin + xChoicesSize - CHOICES_BOX_SIZE ;
        y1 = currentY ;
        x2 = xChoicesOrigin + xChoicesSize - CHOICES_BOX_SIZE + CHOICES_BOX_SIZE ;
        y2 = currentY + CHOICES_BOX_SIZE ;
        line(x1, y1, x2, y2) ;
        x1 = xChoicesOrigin + xChoicesSize - CHOICES_BOX_SIZE + CHOICES_BOX_SIZE ;
        y1 = currentY ;
        x2 = xChoicesOrigin + xChoicesSize - CHOICES_BOX_SIZE ;
        y2 = currentY + CHOICES_BOX_SIZE ;
        line(x1, y1 , x2, y2) ;
      }
    }
    if (c.validX)
    {
      if (Y_THING == c.indicator)
      {
        fill(155) ;
      } else {
        fill(255) ;
      }
      square(xChoicesOrigin + xChoicesSize -  int(CHOICES_BOX_SIZE * (2.0 + CHOICES_BOX_SEP_FACTOR)) , currentY, CHOICES_BOX_SIZE) ;
      if (X_THING == c.indicator)
      {
        x1 = xChoicesOrigin + xChoicesSize -  int(CHOICES_BOX_SIZE * (2.0 + CHOICES_BOX_SEP_FACTOR)) + CHOICES_BOX_SIZE  ;
        y1 = currentY + CHOICES_BOX_SIZE ;
        x2 = xChoicesOrigin + xChoicesSize -  int(CHOICES_BOX_SIZE * (2.0 + CHOICES_BOX_SEP_FACTOR)) ;
        y2 = currentY ;
        line(x1, y1, x2, y2) ;
        x1 = xChoicesOrigin + xChoicesSize -  int(CHOICES_BOX_SIZE * (2.0 + CHOICES_BOX_SEP_FACTOR)) + CHOICES_BOX_SIZE ;
        y1 = currentY ;
        x2 = xChoicesOrigin + xChoicesSize -  int(CHOICES_BOX_SIZE * (2.0 + CHOICES_BOX_SEP_FACTOR)) ;
        y2 = currentY + CHOICES_BOX_SIZE ;
        line(x1, y1, x2, y2) ;
      }
    }
    currentY += int(currentTextSize * (1.0 + CHOICES_TEXT_INTERLINE_FACTOR)) ;
  }
}

void drawTitle()
{
  String TITLE ;
  String temp ;

  String HEADLINE = "Beers caracteristics" ;
  //Design
  textAlign(CENTER, TOP) ;
  fill(0) ;
  //Headline
  textSize(headlineSize) ;
  text(HEADLINE, width / 2, 0) ;
  //Title
  textSize(int(headlineSize * titleHeadlineFactor)) ;
  switch(Y_THING)
  {
    case "abv" :
    TITLE = "Average ABVs" ;
    break ;
    case "number" :
    TITLE = "Amounts" ;
    break ;
    default :
    TITLE = "???" ;
  }
  if (xDisplayed < MAX_BARS)
  TITLE += " of beers of the different " ;
  else
  TITLE += " of beers of the top " + xDisplayed + " " ;
  temp = "???" ;
  for (Choice c : choices)
  {
    if (X_THING == c.indicator)
      temp = c.name ;
  }
  TITLE += temp ;
  if (G_THING != "")
  {
    TITLE += ", divisioned by " ;
    switch(X_THING)
    {
      case "state" :
      TITLE += "Country & US State" ;
      break ;
      case "country" :
      TITLE += "Country" ;
      break ;
      case "style" :
      TITLE += "Style" ;
      break ;
      case "abv" :
      TITLE += "ABV category" ;
      break ;
      case "availability" :
      TITLE += "Availability" ;
      break ;
      case "retired" :
      TITLE += "\"Retiredness\"" ;
      break ;
      default :
      TITLE += "???" ;
    }
  }
  TITLE += ", according to the kaggle.com on 2019.01.09" ;
  text(TITLE, width / 2, 30) ;
}

void initBarWidth(int number)
{
  xDisplayed = number;
  barWidth = (xAxisSize * PERCENTAGE_OF_X_AXIS_USED / 100) / (xDisplayed * (1.0 + BAR_SEPARATION_COEF) + 2.0 * BAR_SEPARATION_COEF) ;
}
/*
class Division
{
  String name ;
  int[] borderColor ;
  //int borderColorG ;
  //int borderColorB ;
  int[] fillColor ;
  //int fillColorG ;
  //int fillColorB ;
  boolean active ;
  boolean hovered ;

  Division ()
  {
    name = "SampleName" ;
    borderColor = new int[3] ;
    fillColor = new int[3] ;
    active = true ;
    hovered = false ;
  }
}

Division[] divisions = new Division[MAX_N_GROUP] ;

void initDivisions(ArrayList<String> divisionNames, int NDivisions)
{
  int[] clrs = {166,206,227, 31,120,180, 178,223,138, 51,160,44, 251,154,153, 227,26,28, 253,191,111, 255,127,0, 202,178,214, 106,61,154, 255,255,153, 177,89,40} ;
  int[] blackClr = {0, 0, 0} ;

  nDivision = 0 ;

  for (String divisionName : divisionNames) :
  {
    divisions[nDivision].name = divisionName ;
    divisions[nDivision].borderColor[0] = blackClr[0] ;
    divisions[nDivision].borderColor[1] = blackClr[1] ;
    divisions[nDivision].borderColor[2] = blackClr[2] ;
    divisions[nDivision].fillColor[0] = clrs[3 * nDivision] ;
    divisions[nDivision].fillColor[1] = clrs[3 * nDivision + 1] ;
    divisions[nDivision].fillColor[2] = clrs[3 * nDivision + 2] ;

    nDivision++ ;
  }

  /*
  int[] greyClr = {100, 100, 100} ;
  int[] whiteClr = {255, 255, 255} ;
  int[] blueClr = {21, 102, 255} ;
  int[] redClr = {153, 0, 0} ;
  int[] yellowClr = {255, 204, 0} ;
  int[] greenClr = {51, 102, 0} ;
  *//*
}

class Button
{
  Division division ;
  int posXleftUpCorner ;

  Button(Division G, int index)
  {
    division = G ;
    posXleftUpCorner = int(xGraphOrigin + xAxisSize - (10 - index) * buttonsSize) ;
    //println("Button #" + index + " : X = " + posXleftUpCorner + " ; Y = " + posYleftUpCorner) ;
  }
}

ArrayList<Button> buttons = new ArrayList<Button>() ;

void initButtons()
{
  for (i = 0 ; i < nDivision, i++)
  {
    buttons.add(new Button(divisions[i], i)) ;
  }
  /*
  buttons.add(new Button(sta, "Stark", 0)) ;
  buttons.add(new Button(arr, "Arryn", 1)) ;
  buttons.add(new Button(lan, "Lannister", 2)) ;
  buttons.add(new Button(tyr, "Tyrell", 3)) ;
  buttons.add(new Button(gre, "Greyjoy", 4)) ;
  buttons.add(new Button(mar, "Martell", 5)) ;
  buttons.add(new Button(bar, "Baratheon", 6)) ;
  buttons.add(new Button(tar, "Targaryen", 7)) ;
  buttons.add(new Button(tul, "Tully", 8)) ;
  buttons.add(new Button(oth, "Others", 9)) ;*//*
}
*/

int randint(int low, int high)
{
  return int(random(low, high)) ;
}

/*String getInitials(String name)
{
  String initials = "" ;
  //String[] temp = name.split("(") ;
  //name = temp[0] ;
  String[] parts = name.split(" ") ;
  for (int i = 0 ; i < parts.length ; i++)
  {
    initials += parts[i].substring(0,1) ;
  }
  return initials ;
}
*/

/*class Beer
{
  float abv ;
  String ctry ;
  String state ;
  String category ;
  String style ;
  String availability ;
  boolean retired ;

  Beer (float Abv, String Ctry, String State, String Category, String Style, String Availability, boolean Retired)
  {
    abv = Abv ;
    ctry = Ctry ;
    state = State ;
    category = Category ;
    style = Style ;
    availability = Availability ;
    retired = Retired ;
  }
}
*/

class Bar
{
  String name ;
  String initials ;
  //Division division ;
  int index ;
  int size ;
  float indicator ;
  float posX ;
  boolean hovered ;

  Bar (String Name, int Size, float Indicator)//, Division itsDivision)
  {
    name = Name ;
    initials = Name ;//getInitials(Name) ;
    //division = itsDivision ;
    index = currentIndex ;
    size = Size ;
    indicator = Indicator ;
    posX = xGraphOrigin + AXIS_WIDTH + barWidth * (index * (1 + BAR_SEPARATION_COEF) + BAR_SEPARATION_COEF) ;
    hovered = false ;
  }
}
/*
Division determineDivision (Bar bar)
{
  switch()
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
*/
ArrayList<Bar> tabBar = new ArrayList<Bar>() ;

void drawBar(Bar bar)
{
  float darkenTextPercent = 66 ;
  if (true )//|| bar.division.active)
  {
    //Bar
    //fill(bar.division.fillColor[0], bar.division.fillColor[1], bar.division.fillColor[2]) ;
    strokeWeight(AXIS_WIDTH) ;
    stroke(0) ;
    noStroke() ;

    if (bar.hovered)
    {
      int whiteRectOpacity = 220 ;

      //Redraw Red Bar
      fill(255, 0, 0) ;
      rect(bar.posX, yGraphOrigin - bar.size, barWidth, bar.size) ;
      stroke(255, 0, 0, 255) ;
      strokeWeight(int(AXIS_WIDTH / 2)) ;
      line(xGraphOrigin - gradSize, yGraphOrigin - bar.size, xGraphOrigin + xAxisSize + gradSize, yGraphOrigin - bar.size) ;
      fill(255, 0, 0) ;
      textSize(12) ;
      //Left graduation
      textAlign(RIGHT, BOTTOM) ;
      text(bar.indicator, xGraphOrigin - gradSize -gradTextSpace, yGraphOrigin - bar.size - initialsTextSpace) ;
      //Left graduation
      textAlign(LEFT, BOTTOM) ;
      text(bar.indicator, xGraphOrigin + xAxisSize + gradSize + gradTextSpace, yGraphOrigin - bar.size - initialsTextSpace) ;
      /*if (float(index) / MAX_X_DISPLAYED < 0.5)
      {*/
        textAlign(RIGHT, BOTTOM) ;
        text(bar.name, xGraphOrigin + xAxisSize - barWidth * BAR_SEPARATION_COEF, yGraphOrigin - bar.size - initialsTextSpace) ;
      //} else {
        noStroke() ;
        fill(255, whiteRectOpacity) ;
        rect(xGraphOrigin + barWidth * BAR_SEPARATION_COEF, yGraphOrigin - bar.size - (initialsTextSpace / 2) - 16, int(bar.name.length() * 7), 20) ;
        textAlign(LEFT, BOTTOM) ;
        fill(255, 0, 0) ;
        text(bar.name, xGraphOrigin + barWidth * BAR_SEPARATION_COEF, yGraphOrigin - bar.size - initialsTextSpace) ;
      //}
      //println("Triggered on index " + index) ;
    } else {
      if (false)//bar.division.hovered)
        fill(105) ;
      else
        fill(205) ;
      rect(bar.posX, yGraphOrigin - bar.size, barWidth, bar.size) ;

    }
    //Text
    textAlign(CENTER, CENTER) ;
    //fill(bar.division.borderColor[0] * darkenTextPercent / 100, bar.division.borderColor[1] * darkenTextPercent / 100, bar.division.borderColor[2] * darkenTextPercent / 100) ;
    if (barWidth > 50)
    {
      fill(0) ;
      textSize(12) ;
      textAlign(CENTER, TOP) ;
      text(bar.initials, bar.posX + int(barWidth / 2), yGraphOrigin + initialsTextSpace) ;
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
    line(xGraphOrigin, yGraphOrigin - gradHeight, xGraphOrigin - gradSize, yGraphOrigin - gradHeight) ;
    if (int(grad) == grad)
      text(int(grad), xGraphOrigin - gradSize - gradTextSpace, yGraphOrigin - gradHeight) ;
    else
      text(str(grad), xGraphOrigin - gradSize - gradTextSpace, yGraphOrigin - gradHeight) ;
  }
  //Unit of Y xAxis
  text(Y_THING, xGraphOrigin - arrowWidth / 2 - gradTextSpace, yGraphOrigin - yAxisSize) ;
  //Design
  fill(255) ;
  //Y Axis
  line(xGraphOrigin, yGraphOrigin - yAxisSize, xGraphOrigin, yGraphOrigin) ;
  triangle(xGraphOrigin, yGraphOrigin - yAxisSize, xGraphOrigin - arrowWidth / 2, yGraphOrigin - yAxisSize + arrowHeight, xGraphOrigin + arrowWidth / 2, yGraphOrigin - yAxisSize + arrowHeight) ;
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
    line(xGraphOrigin + xAxisSize, yGraphOrigin - gradHeight, xGraphOrigin + xAxisSize + gradSize, yGraphOrigin - gradHeight) ;
    if (int(grad) == grad)
      text(int(grad), xGraphOrigin + xAxisSize + gradSize + gradTextSpace, yGraphOrigin - gradHeight) ;
    else
      text(str(grad), xGraphOrigin + xAxisSize + gradSize + gradTextSpace, yGraphOrigin - gradHeight) ;
  }
  //Unit of secondary Y xAxis
  text(Y_THING, xGraphOrigin + xAxisSize + arrowWidth / 2 + gradTextSpace, yGraphOrigin - yAxisSize) ;
  //Design
  fill(255) ;
  //secondary Y Axis
  line(xGraphOrigin + xAxisSize, yGraphOrigin - yAxisSize, xGraphOrigin + xAxisSize, yGraphOrigin) ;
  triangle(xGraphOrigin + xAxisSize, yGraphOrigin - yAxisSize, xGraphOrigin - arrowWidth / 2  + xAxisSize, yGraphOrigin - yAxisSize + arrowHeight, xGraphOrigin + arrowWidth / 2  + xAxisSize, yGraphOrigin - yAxisSize + arrowHeight) ;
  //X Axis
  line(xGraphOrigin, yGraphOrigin, xGraphOrigin + xAxisSize, yGraphOrigin) ;
  //triangle(xGraphOrigin + xAxisSize, yGraphOrigin, xGraphOrigin + xAxisSize - arrowHeight, yGraphOrigin - arrowWidth / 2 , xGraphOrigin + xAxisSize - arrowHeight, yGraphOrigin + arrowWidth / 2) ;

}

void setup()
{
  //fullScreen() ;
  size(1300, 650) ;
  //initDivisions() ;
  initDimensions() ;
  //initButtons();
  textAlign(CENTER, CENTER) ;
  table = loadTable(path, "header") ;
  computeForNewParam() ;
  initChoices() ;
}

public class XY implements Comparable<XY>
{
  String x ;
  int counter ;
  float meanABV ;

  public XY(String X)
  {
    this.x = X ;
    this.counter = 0 ;
    this.meanABV = 0 ;
  }

  public int compareTo(XY xy)
  {
    switch(Y_THING)
    {
      case "number" :
        return ((XY)xy).counter - this.counter ;
        //break ;
      case "abv" :
        return Float.compare(((XY)xy).meanABV, this.meanABV) ;
        //return int(((XY)xy).meanABV - this.meanABV) ;
        //break ;
      default :
        System.out.println("Oopsy") ;
        return -1 ;
        //break ;
    }
  }
}

void getBars(int lastIndex)
{
  int size ;

  tabBar.clear() ;
  currentIndex = 0 ;

  for (int i = 0 ; i <= lastIndex ; i++)
  {
    tempXY = listXY.get(i) ;
    switch(Y_THING)
    {
      case "number" :
        size = int(barMaxSize * tempXY.counter / maxInd) ;
        //division = determineDivision(tempXY.x) ;
        tabBar.add(new Bar(tempXY.x, size, float(tempXY.counter))) ;//, division) ;
        break ;
      case "abv" :
        size = int(barMaxSize * tempXY.meanABV / maxInd) ;
        //division = determineDivision(tempXY.x) ;
        tabBar.add(new Bar(tempXY.x, size, tempXY.meanABV)) ;//, division) ;
        break ;
      default :
        System.out.println("Ooopsi") ;
        break ;
    }
    currentIndex++ ;
  }
}

void computeForNewParam()
{
  int size ;
  TableRow row ;
  //Division division ;
  String x ;
  boolean found ;
  int foundIndex = 0 ;
  int i, j ;
  int lastIndex ;

  //table.sortReverse(Y_THING) ;

  listXY.clear() ;

  for (i = 0 ; i < 5000 ; i++)//Zoidberg
  {
    row = table.getRow(i) ;
    x = row.getString(X_THING) ;
    //println("Searching for " + x) ;
    found = false ;
    for (j = 0 ; (j < listXY.size()) && (found == false) ; j++)
    {
      if (listXY.get(j).x.equals(x))
      {
        //println("found") ;
        found = true ;
        foundIndex = j ;
      }
    }
    if (found == false)
    {
      listXY.add(new XY(x)) ;
      foundIndex = listXY.size()-1 ;
    }
    tempXY = listXY.get(foundIndex) ;
    //println("++") ;
    tempXY.counter++ ;
    tempXY.meanABV += row.getFloat("abv") ;
    listXY.set(foundIndex, tempXY) ;
  }

  for (j = 0 ; j < listXY.size(); j++)
  {
    tempXY = listXY.get(j) ;
    //println(tempXY.meanABV + " / " + tempXY.counter + " = " + tempXY.meanABV / tempXY.counter );
    tempXY.meanABV = tempXY.meanABV / tempXY.counter ;
    listXY.set(j, tempXY) ;
  }

  /*
  println("We are at point 1") ;
  for (i = 0 ; i < 50 ; i++)
  {
    System.out.println(i + " => " + listXY.get(i).x + " : " + listXY.get(i).meanABV) ;
  }
  */

  Collections.sort(listXY) ;

  lastIndex = min(listXY.size(), MAX_BARS) - 1 ;
  System.out.println("lastIndex = "+ lastIndex) ;

  switch(Y_THING)
  {
    case "number" :
      maxInd = listXY.get(0).counter ;
      incrementOfMaxInd = get10power(maxInd) / 4 ;
      if ((maxInd % incrementOfMaxInd) != 0)
        maxInd = (int(maxInd / incrementOfMaxInd) + 1) * incrementOfMaxInd ;

      minInd = listXY.get(lastIndex).counter ;
      incrementOfMinInd = get10power(minInd) / 4 ;
      if ((minInd % incrementOfMinInd) != 0)
        minInd = (int(minInd / incrementOfMinInd) + 1) * incrementOfMinInd ;
      break ;
    case "abv" :
      maxInd = listXY.get(0).meanABV ;
      incrementOfMaxInd = get10power(maxInd) / 4 ;
      if ((maxInd % incrementOfMaxInd) != 0)
        maxInd = (int(maxInd / incrementOfMaxInd) + 1) * incrementOfMaxInd ;

      minInd = listXY.get(lastIndex).meanABV ;
      incrementOfMinInd = get10power(minInd) / 4 ;
      if ((minInd % incrementOfMinInd) != 0)
        minInd = (int(minInd / incrementOfMinInd) + 1) * incrementOfMinInd ;
      break ;
    default :
      System.out.println("Ooopsi") ;
      break ;
  }

  System.out.println("min = "+ minInd + ", max =" + maxInd) ;

  for (i = 0 ; i <= lastIndex ; i++)
  {
    System.out.println(i + " => " + listXY.get(i).x + " : " + listXY.get(i).meanABV) ;
  }

  defineGraduations() ;

  initBarWidth(lastIndex + 1) ;

  getBars(lastIndex) ;
}

/*void drawButtons()
{
  int borderSize = int(buttonsSize * BORDER_SIZE_COEF) ;
  strokeWeight(borderSize) ;
  textAlign(CENTER, CENTER) ;
  textSize(12) ;
  for (Button but : buttons)
  {
    if (but.division.active)
    {
      stroke(but.division.borderColor[0], but.division.borderColor[1], but.division.borderColor[2]) ;
      fill(but.division.fillColor[0], but.division.fillColor[1], but.division.fillColor[2]) ;
      rect(but.posXleftUpCorner - int(borderSize / 2) , buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
      fill(but.division.borderColor[0], but.division.borderColor[1], but.division.borderColor[2]) ;
      text(but.division.name, but.posXleftUpCorner - int(borderSize / 2) , buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
    }
    else
    {
      stroke(but.division.borderColor[0], but.division.borderColor[1], but.division.borderColor[2], 100) ;
      fill(but.division.fillColor[0], but.division.fillColor[1], but.division.fillColor[2], 100) ;
      rect(but.posXleftUpCorner - int(borderSize / 2), buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
      fill(but.division.borderColor[0], but.division.borderColor[1], but.division.borderColor[2], 100) ;
      text(but.division.name, but.posXleftUpCorner - int(borderSize / 2) , buttonsY + int(borderSize / 2), buttonsSize - borderSize, buttonsSize - borderSize) ;
    }
  }
}
*/
void hover()
{
  //Init all to false
  /*for (Button but : buttons)
    but.division.hovered = false ;
  */
  for (Bar bar : tabBar)
    bar.hovered = false ;

  if (mouseX >= xGraphOrigin && mouseX <= xGraphOrigin + xAxisSize)
  {
    // In the graph
    if (mouseY <= yGraphOrigin && mouseY >= yGraphOrigin - barMaxSize)
    {
      //Bars
      int graphicsX = int(mouseX - (xGraphOrigin + AXIS_WIDTH + BAR_SEPARATION_COEF * barWidth)) ;
      int graphicsY = - (mouseY - yGraphOrigin) ;
      int index = int(graphicsX / (barWidth * (1 + BAR_SEPARATION_COEF))) ;
      int rest = int(graphicsX - index * (barWidth * (1 + BAR_SEPARATION_COEF))) ;
      if (index < xDisplayed && rest >= barWidth * BAR_SEPARATION_COEF)
      {
        Bar hoveredBar = tabBar.get(index) ;
        if (graphicsY > 0 && graphicsY <= hoveredBar.size )//&& hoveredBar.division.active)
          {
            hoveredBar.hovered = true ;
          } else {
            hoveredBar.hovered = false ;
          }
      }
    } /*else if (mouseY >= buttonsY && mouseY <= buttonsY + buttonsSize) {
      //Potentially divisions
      for (Button but : buttons)
      {
        int temp = mouseX - but.posXleftUpCorner ;
        if (temp >= 0 && temp < buttonsSize)
          but.division.hovered = true ;
        else
          but.division.hovered = false ;
      }
    }*/
  }
}

void draw()
{
  background(255) ;
  //drawButtons() ;
  for (Bar bar : tabBar)
    drawBar(bar) ;
  drawAxis() ;
  drawTitle() ;
  drawChoices() ;
  hover() ;
}

void mouseClicked()
{
  int minY = 0 ;
  int maxY = 0 ;
  int XmaxX = 0 ;
  int YminX = 0 ;

  if ((mouseX >= firstChoiceasX_X) && (mouseY <= (firstChoiceasY_X + CHOICES_BOX_SIZE)))
  {
    println("Step 1");
    if (mouseY >= firstChoiceasX_Y)
    {
      println("Step 2");
      for (int i = 0 ; i < choices.size() ; i++)
      {
        minY = int(firstChoiceasX_Y + i * (int(headlineSize * titleHeadlineFactor) * (1.0 + CHOICES_TEXT_INTERLINE_FACTOR))) ;
        maxY = minY + CHOICES_BOX_SIZE ;
        if (mouseY >= minY)
        {
          println("Step 3");
          if (mouseY <= maxY)
          {
            println("Step 4");
            if (mouseX <= (firstChoiceasX_X + CHOICES_BOX_SIZE))
            {
              println("Step 5");
              if (choices.get(i).validX)
              {
                println("Step 6");
                X_THING = choices.get(i).indicator ;
                computeForNewParam() ;
              }
            } else if (mouseX >= firstChoiceasY_X){
              println("Step 5b");
              if (choices.get(i).validY)
              {
                println("Step 6b");
                Y_THING = choices.get(i).indicator ;
                computeForNewParam() ;
              }
            }
          }
        } else {
          break ;
        }
      }
    }
  }



  /*
  int firstButtonX = buttons.get(0).posXleftUpCorner ;
  if (mouseX >= firstButtonX && mouseX <= firstButtonX + 10 * buttonsSize && mouseY >= buttonsY && mouseY <= buttonsY + buttonsSize)
  {
    buttons.get(int((mouseX - firstButtonX) / buttonsSize)).division.active = !buttons.get(int((mouseX - firstButtonX) / buttonsSize)).division.active ;
    println("Button " + buttons.get(int((mouseX - firstButtonX) / buttonsSize)).name + " clicked (now " + buttons.get(int((mouseX - firstButtonX) / buttonsSize)).division.active +")") ;
  }
  */
}
