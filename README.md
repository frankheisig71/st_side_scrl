# st_side_scrl
50Hz side scrolling on Atari ST
First of all: Many thanks to the DEAD HACKERS SOCIETY - I just take your code for this

Playing around with the 4 bit technique I met some problems:
- On different STs different implementations of 4 bit technique is working or even not. This currently leads into 2 different  versions of code. You may use the compiler-switches for machine1 or machine2
- To get a stable overscan on (4bit-)shiftet screens, left outer border of screen buffer needs to be empty. Same for the right outer border on not shifted screen. You may have a look on Timings68.ods, sheet "draft". (I apologize for this chaotic spreadsheet, it was intended for my use only.)
- Left border on shifted screens start on different positions, so masking is needed.

Current status:
- 50 Hz side scrolling with all 4 planes 
- 1 pixel per step
- (only) 4 screen buffers needed + 1 for wrap around
- about 50% processor time free
- some instabilities on overscan on the 1st two lines - reason unclear
- some tiny flickering on right border on scrolling to left

Starting intention was to create a little side scrolling game... maybe it can be done.
