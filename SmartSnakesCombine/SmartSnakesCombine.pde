//GLOBAL VARIABLES
import java.io.File;
World world;//world which stores the species / populations

World worldOfLegends;//world containing the legends, used for training the legends to be even better


int speed = 30;//the frame rate

//booleans used to control the game state
boolean showAll = true;//whether to show all the snakes in the generation or just the current best snake
boolean trainLegendSnakes = false; //true if training the legends i.e. if running worldOfLegends
boolean showingLegend = false;//true if testing just one legend
boolean fusionGo =false;//true if testing the snake fusion 


// Determines the chance for each individual element of the NeuralNet Matrices to mutate at child birth, by way of generating a random float between 0 and 1 and checking to see that it is less than the Mutation Rate. 
// Therefore, a globalMutationRate 0f 1 will cause every child to posess only mutated genes, and a value of 0 will prevent mutation altogether -- all children will inherit their genome entirely from their parents without modification.
float globalMutationRate = 0.01f;
float mutationRateStep = 0.01f;

int population = 4000;

//---------------------------------------------------------------------------------------------------------------------------------------------------------  
//run on startup
void setup() {
  frameRate(speed);
  size(800, 500);
  world = new World(5, population);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------  
void draw() {
  background(40);

  drawData();
  
  //training/evolving the legend snakes
  if (trainLegendSnakes) {
    if (!worldOfLegends.done()) {
      worldOfLegends.updateAlive();
    } else {
      //all are dead
      worldOfLegends.geneticAlgorithm();
    }

    //testing a single legend
  } else if (showingLegend) {
    if (world.legend.alive) {
      world.updateLegend();
    } else {
      if(world.legend.len < 100){
        
        world.playLegend(world.legendNo);
      }else{

      showingLegend = false;
      }
    }

    // testing the supersnake fusion
  } else if (fusionGo) {
    if (world.fusedSnake.alive) {
      world.updateSuperSnake();
    } else { //once done set the fusionGo to false
      fusionGo = false;
    }


    //training/evolving population normally
  } else {
    if (!world.done()) {//if there is still a snake alive then update them
      world.updateAlive();
    } else {//if all are dead :(
      world.geneticAlgorithm();
    }
  }
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------  

void keyPressed() {
  switch(key) {
  case ' '://toggle show all
    showAll = !showAll;
    break;
  case '+'://speed up frame rate
    speed += 10;
    frameRate(speed);
    break;
  case '-'://slow down frame rate
    if (speed > 10) {
      speed -= 10;
      frameRate(speed);
    }
    break;
  case 'f'://create a fused snake from the legends
    fusionGo  = true;
    world.snakeFusion();
    break;
  case '0'://test legend 0
    showingLegend = true;
    world.playLegend(0);
    break;
  case '1': // test legend no 1
    world.playLegend(1);
    showingLegend = true;
    break;
  case '2'://test legend no 2
    world.playLegend(2);
    showingLegend = true;
    break;
  case '3'://test legend no 3
    world.playLegend(3);
    showingLegend = true;
    break;
  case '4'://test legend no 4
    world.playLegend(4);
    showingLegend = true;
    break;
  case 'h'://halve the mutation rate
    if(globalMutationRate >= mutationRateStep){
      globalMutationRate -= mutationRateStep;
    }
    else {
      globalMutationRate = 0;
    }
    break;
  case 'd'://double the mutation rate
    if(globalMutationRate <= 1 - mutationRateStep){
      globalMutationRate += mutationRateStep;
    }
    else {
      globalMutationRate = 1;
    }
    break;
  case 'l'://train the legends
    trainLegendSnakes =!trainLegendSnakes;
    if (trainLegendSnakes == true) {//load best snakes from file and setup worldOfLegends
      world.loadBestSnakes();
      worldOfLegends = new World(1000, world.SnakesOfLegend);
    }

    
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------  
void drawData() {
  fill(255);
  stroke(255);
  line(400, 0, 400, 400);
  line(0, 400, 800, 400);
  textSize(30);

  //training/evolving the legend snakes
  if (trainLegendSnakes) {
    text("Generation: " + (worldOfLegends.gen), 10, 100); 
    text("Speed: " + speed, 10, 150);
    text("Global Best: " + (worldOfLegends.worldBestScore), 10, 200);
    text("mutation Rate: " + String.format("%.2f",globalMutationRate), 10, 250);      

    //testing a single legend
  } else if (showingLegend) {
    text("Score: " + (world.legend.len-4), 10, 100); 

    // testing the supersnake fusion
  } else if (fusionGo) {
    text("Score: " + (world.fusedSnake.len-4), 10, 100); 

    //training/evolving population normally
  } else {

    text("Generation: " + (world.gen), 10, 100); 
    text("Speed: " + speed, 10, 150);
    text("Global Best: " + (world.worldBestScore), 10, 200);
    text("mutation Rate: " + String.format("%.2f",globalMutationRate), 10, 250);
  }
}
