Lab3
====


##Schematic
![schematic](https://github.com/Austinbolinger/Lab3/blob/master/schematic.jpg?raw=true "Schematic")

#Analysis
So far I looked at each file and made a bus for each one. Each bus has an input and an output. The busses are linked to one another because the nibble feeds the nexys2 which feeds the nexys2 top shell output.

#Coding Easier
In the file given out, the code is broken into two parts. It would be easier to read and edit if the code was broken into three parts. It should be broken into state registers, next state logic, and output logic. The moore and mealy code are the same except for the fact that the mealy also relies on the input and therefore has extra output logic.

#Code (Top Level)
https://github.com/Austinbolinger/Lab3/blob/master/Nexys2_top_shell.vhd
The code not used for the specific bit file is commented out, but can be easily implemented by uncommenting the code under the correct headers.

###Code Moore
This code was modified to achieve the requirements requested for each functionality. Again, uncomment the required parts
https://github.com/Austinbolinger/Lab3/blob/master/MooreElevatorController_Shell.vhd

###Code Mealy
This code was modified to achieve the requirements requested for each functionality. Again, uncomment the required parts
https://github.com/Austinbolinger/Lab3/blob/master/MealyElevatorController_Shell.vhd

#Bit files
![Single Elevator](https://github.com/Austinbolinger/Lab3/blob/master/MealyElevator.ipf?raw=true "MealyElevator")
![Prime Numbered Floors](https://github.com/Austinbolinger/Lab3/blob/master/primeNumbers.ipf?raw=true "primeNumbers")
![Switch Flipped Floors](https://github.com/Austinbolinger/Lab3/blob/master/changeInput.ipf?raw=true "changeInput")

###Demo
I have three bit files to show you still.

######Documentation
C3C Kyle Jonas pointed out that I should look at each file as a bus and just read their inputs and outputs

C3C Pluger helped me with the changing inputs- noted in the file where
