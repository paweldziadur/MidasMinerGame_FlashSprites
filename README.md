# MidasMinerGame_FlashSprites

Pawel Dziadur - AS3 – Midas – Miner – like game - Project Notes

NOTE THIS IS MY INITIAL FLASH SPRITES VERSION OF THE CODE NOT THE STARLING (GPU ACCELERATED) VERSION

I will need to redo the Starling version, as one of my lapotps with the source code got stolen 

and only executable was online at the time this happened and is recovered, available at:

http://doc.gold.ac.uk/~pdzia001/pd_portfolio/demo/starling/

+ + +

First I created a version where to update the board I was creating a Vector of Strings snapshot of the board and finding all winning groups through RegExp.
The first branch had some bugs occurring during the gameplay, particularly some null object in items vector, so while I was debugging it I came to conclusion that it would be more efficient to use a bit matrix representation of the board with separate Vector of uint for each jewel colour.
The 8x8 grid looked perfect for bitwise operations. That's why I created a new branch of the game.
Taking out jewels from the board is flexible in this branch as when we block refilling the board (e.g. through unmapping the RefillBoardCommand) the recognition of remaining winning groups still works fine.
The bit matrix approach is fast and in this revision I am only using RegExp during initialisation to generate a Vector lookup table which contains all possible winning group details.
Each index of this look up table contains a WinGroupObject Class with the necessary data precalculated or null if there is no win at any of the 0-255 values. The values are then applied from the bit matrix snapshot of the board, as said organised in Vector with uint values separate for each jewel colour.
The code was built around the Model-View-Controler design pattern and Robotl#,egs 1.5 framework.
It is also using Greensock for some tweening and AS3 signals library - for the Enter Frame management, which adds some efficiency to animations.
I also implemented some test-sounds (I know this is a task for a game music composer rather then developer, but I just sampled some sounds at home with my Zoom H2 and added them to the project to show in game sound implementation, rather then how the game should sound like).
The game features includes showing move suggestions to user if no-interaction is taking place for a configurable time (in this case set to 25 second). It looks very discrete as the jewel 'shining' and is implemented by the ShowCluesToUserCommand within the Controller.
You drag or click the jewels (I liked this method of interaction from Candy Crush).
Observations:
In this kind of time-limit based game we need to deicide how to resolve end of the game. The count-down timer uses seconds and when it reaches 0 there might be still some jewels during their free fall. We wouldn't like to stop them in the middle of movement and when they hit the ground there might still create a winning group which comes after the time-limit.
In my code I just give up adding them to total score. But there are other logical options to resolve it (e.g. wait after they hit the ground and then end the game or implement a live score counter which goes beyond time-limit).
The other thing important for the game are Random Number Generators. If we implement a continuous probability there will be many winning group possibilities coming up for the player. There are many options to create other Random Number generators which might make the game more or less difficult. I am using IRandomNumberGenerator interface which looks like obvious
￼￼￼
structural approach to test many.
I have inlcuded two generators. The UniqueChunkDistributionJewelTypeGenerator can sometimes produce a winning group at the start of the game when the jewels are first falling. It happens once about few dozens of start game executions. Of course we can extend it and implement other equation or a buffer for example which filters out the random number generation further and guarantees no winning group at start (I have done it in the first branch of game, but in this one I am just highlighting the possibility to modify this behaviour by adding various generators to package).
The other things which might be useful for the game if I was to push this code further could be:
- Working on the flexibility and efficiency of the code, profiling, looking at execution times of parts of the code
- Unit testing of code parts, trying to find the condtions where the code could break
- Creating more flexible code, e.g. with configurable grid sizes and elements quantity and more 'interface' approach, so to have an engine for creating games of similar mechanics
- Using Robotlegs 2 which is newer version, possibly more efficient. I am using the as3 signals library here anyway. However I had chosen 1.5 as I have more experience with it and I think 1.5 might be still used as there is Starling plugin for it and not for Robotlegs 2
- Using a Starling framework (and Robotlegs plugin) for GPU accelerated bitmap sprites. I thought about it at the beginning but then I decided to go without Starling. The reason is depending on the user machine, the numerous Starling objects might turn out even slower then Flash Sprites so it would need to involve a fall-back version. I can see this problem very well on my other older laptop. And in case of desktop application with about 64 sprites standard Flash DisplayObjects seem fast enough.
- We can implement a particle generator for the dynamite fuse animation (particles might look good also for the score-effect sprites). In this version I just added a simple sprite moving along the bezier-curve calcuted path, calculated and stored in an array. For this movement I have actually reused a code which I have created some years ago along with the simple bezier-curve editor which can dump values to array. I just include it as an example in bezierCurveEditor folder (it was coded in AS2)
- ReslultsHelper.getResults method scanning for winning group patterns might be further optimised, also ShowCluesToUserCommand class could be reworked to perform less calculations during one scan (e.g. consider only few lines that change during iteration through possible moves)
- I could potentailly have used Bitmap class for the Jewels in favour of Sprites as they are faster to render
- Resolving MVC of the Jewels in other way.
I used a simple free fall simulating equation for the 'gravity', which is resolved in the Model. It involves passing the x and y of animated object from Model to View, which sometimes in a game may cause loss in animation quality.
The 'gravity' is based on an index of on item which is a property of the Model here and as I am assigning the x and y directly rather the through events chain the animation looks fine.
￼￼￼￼￼￼￼￼
On the other hand I realise that in a game we can sometimes resign from MVC approach in each case in favour of speed.
- Trying out a concept of more flexible gravity / collisions engine. I have excluded Box2D approach at the beginning as the objects move only in one axis so we could use something simpler. During the process of working on the 'gravity' and the bit matrix I also thought about a fast bit matrix approach which could store all obstacles present on the board and would allow a simple one axis gravity / collisions calculation that holds all the game objects in an obstacles bit matrix and then allows fast checking of hitting any obstacle in each frame from bit-wise equation, e.g. like below:
function getObstacle(column:uint):uint {
return ((_gridVector[0][column] |= _gridVector[1][column] |= _gridVector[2][column] |= _gridVector[3] [column] |= _gridVector[4][column]) << 8) }
function getCollision(altitude:int, obstacle:uint):uint {
// we get 1-65536 location bit values mapped for 0-512 altitude values
// in case of Midas Miner-like game 0-255 may involve masked area and 256-512 game area return (obstacle & (2 << ((altitude>> 5) - 1)));
}
// on enter frame checking the collision would look like below
if (Boolean(getCollision(column), altitude))
{
hitTheGround() }
else
{
// continue falling }
But then I thought that it would be useful for a tetris-like game but here because the stream of jewels is continuous in each column, 'gravity' solved through comparing y to item indexes seemed a simpler solution.
￼
