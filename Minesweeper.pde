import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 25;
private final static int NUM_COLS = 25;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(800, 800);
    textAlign(CENTER,CENTER);

    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++){
      for (int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r, c);
      }
    }
    for (int i = 0; i < 150; i++){
      setMines();
      //System.out.println(mines.size() + ", " + mines.get(0).getRows() + ", " + mines.get(0).getCols() );
    }
}
public void setMines()
{
    //your code
    int mR =(int)(Math.random()*NUM_ROWS);
    int mC = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[mR][mC]))
      mines.add(buttons[mR][mC]);
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    int flaggedMines = 0;
    for (int m = 0; m < mines.size(); m++){
      if (mines.get(m).flagged == true){
        flaggedMines++;
      }
    }
    if (flaggedMines == mines.size())
      return true;
    return false;
}
public void displayLosingMessage()
{
    //your code here
    
    buttons[12][8].setLabel("Y");
    buttons[12][9].setLabel("O");
    buttons[12][10].setLabel("U");
    
    buttons[12][12].setLabel("L");
    buttons[12][13].setLabel("O");
    buttons[12][14].setLabel("S");
    buttons[12][15].setLabel("T");
    buttons[12][16].setLabel(":(");
    
    //buttons[2][2].setLabel("no");
}
public void displayWinningMessage()
{
    //your code here
    
    buttons[12][8].setLabel("Y");
    buttons[12][9].setLabel("O");
    buttons[12][10].setLabel("U");
    
    buttons[12][12].setLabel("W");
    buttons[12][13].setLabel("O");
    buttons[12][14].setLabel("N");
    buttons[12][15].setLabel("!");
    buttons[12][16].setLabel(":)");
    
    //buttons [2][2].setLabel("Yes");
}
public boolean isValid(int r, int c)
{
    //your code here
    if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for (int r = row-1; r <=row+1; r++)
      for(int c = col-1; c <= col+1; c++)
        if (isValid(r, c)){
          //for (int i = 0; i < mines.size(); i++){
            if (mines.contains(buttons[r][c])){
            //if (mines.get(i).getRows() == r && mines.get(i).getCols() == c){
            //System.out.println() mines.contains(buttons[r][c] + "   "  + r + "," + c);
              numMines++;
            //}
          }
        }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 800/NUM_COLS;
        height = 800/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public int getRows() {
      return myRow;
    }
    public int getCols() {
      return myCol;
    }

    // called by manager
    public void mousePressed () 
    {
      clicked = true;
      if (mousePressed && (mouseButton == RIGHT)){
        if (flagged == false)
          flagged = true;
        else{
          flagged = false;
          clicked = false;
        }
      }
      else if (mines.contains(this)){
        displayLosingMessage();
        for (int r = 0; r < NUM_ROWS; r++)
           for (int c = 0; c < NUM_COLS; c++)
             if (mines.contains(buttons[r][c])){
               buttons[r][c].clicked = true;
             }
      }
      else if (countMines(myRow, myCol) > 0){
        setLabel(countMines(myRow, myCol));
      }
      else{
          for (int r = myRow-1; r <= myRow+1; r++){
            for (int c= myCol-1; c <= myCol+1; c++){
              if (isValid(r,c) && buttons[r][c].clicked == false){
              buttons[r][c].mousePressed();
              //System.out.println(countMines(myRow,myCol));
              //System.out.println(mines.size());
            }
          }
        }
      }
    }
      
    public void draw () 
    {    
        int r = 15;
        int g = myRow;
        int b = myCol;
        if (flagged)
            fill(r*10, b*10, g*10);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( r, g*10, b*10 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
