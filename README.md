# go-go-godot
### Christine and Joyce !!!!!!!!!!
<img width="320" height="300" alt="image" src="https://github.com/user-attachments/assets/d1f16830-f9b8-498c-bfc3-6660e4c4b3b6" />

## ***NOTES BEGIN***

### ***Table of Contents***
1. [AVAILABLE RENDERERS](#available-renderers)
2. [INTRO](#intro)
3. [HOW DO I GET STARTED](#how-do-i-get-started-)
4. [HOW TO EMBED INTO FLASK](#how-to-embed-into-flask)
5. [IMPORTING BLENDER MODELS](#importing-blender-models)
<br>

### AVAILABLE RENDERERS
---
  * __Forward+__
    * Most advanced!!!!!!!
    * Desktop platforms only
    * Supports 3D
    * Advanced rendering but the SLOWEST
    * Hard to get started but runs bigger, complex apps efficiently (High base cost, low scaling)
  * __Mobile__
    * Mobile + Desktop support
    * Supports 3D
    * Renders simple scenes faster (slower than compatibility)
    * Limited by mobile hardware
    * Medium base cost and medium scaling (so its average)
  * __Compatibility__
    * Least advanced but is recommended for web apps!
    * Supports 3D and is compatible (haha) with the widest range of hardware
      * Only renderer to be capable of running on hardware without RenderingDevice support
    * Good for 2D and games that don't require highly complex 3D rendering
    * Low base cost, high scaling :(

For this sample (as well as the final project), we will be utilizing __Compatibility__.

<br>

### INTRO
---
  * Godot supports C#, C++, and its own GDScript
    * GDScript is like a blend between TypeScript and Python (syntax will generally be the same as Python's)
  * Creating a game begins with a __scene__
    * Scenes contain a tree of nodes
      * Controls appearance and behavior of objects and the scene
      * Nodes can have script/code attached that updates the object for every frame in the game loop
    * Scene can then be saved to disk and used within other scenes

<br>

### HOW DO I GET STARTED ????????
---
Remember, right clicks are your best friend.

  1) Start with a 3D scene (for 3d apps of course heh)
  2) Add a __static body node__
     - Ideal for things like walls and floors (wow this is really starting to look like blender)
     - Invisible on its own
  3) Add a __collision shape node__ to the static body as a child
  4) Choose a shape type on the right (now the static body isn't invisible anymore! wow11!)
  5) Now you can mess around with the block!
     - W: Move mode
     - E: Rotate mode
     - R: Scale mode
     - Q: Universal !!
  6) Add a __mesh instance__ to the static body to make our wireframe object a solid
     - A mesh is a collection of triangles that make 3D shapes look more realistic
     - So if the collision shape is your hitbox then the mesh instance is the actual body!
     - You can mess around with it with the same transform controls as before
  7) To the scene, add a __directional light__ (makes the scene look cooler cause lights are cool and casts shadows)
  8) To add a player to the game, create another scene by clicking scene and 'New Scene'
     - Click 'Other node' and add a __character body__ as the root this time
       - Ideal for objects you move around with a controller
       - Now add a collision shape and a mesh instance to the scene
  9) Open 'Project Settings' in the 'Project' tab and go to input map
     - This is where you will set up your keybinds by creating labels such as move left and move right
       - Map them to different controls/keys
  10) You can now start writing code by attaching a script to the root object (in this case it is the character body)
  11) Inside the script, you can create variables with `var VARNAME`. Export them (by adding export before var) to make them public in the editor
  12) You can also create functions with `func FUNCNAME(params):`
  13) Now go baack to the main scene in your filesystem on the lower right or the tabs on the top. If you have not saved anything, they will NOT appear within the filesystem
  14) Right click within the main scene and click 'Instantiate child scene' and select your player
  15) Add a camera for the perspective
  16) Now when you click the play button in the upper right, you should see your objects behave as they were coded!!!

<br>

### HOW TO EMBED INTO FLASK
---

  1) In the `static` folder, create a subfolder. Let's name it `godot`! This is the location where the Godot web export will go.
  2) In whichever template you wish to display the game (`play.html` in this case), add an iframe that points to the exported Godot file. We'll call it `index.html`.
     ```
     <iframe
         src="/static/godot/index.html"
         style="width: 100vw; height: 100vh;">
     </iframe>
     ```
     An `iframe` is an HTML element that allows other interactive content to be embedded in a webpage. In this case, our Flask page is displaying the exported Godot web page inside the `/play` page.
  3) If not done previously, install export templates:
     - `Editor -> Manage Export Templates`
     - If Godot says they are not installed, install the proper version.
  5) Export the Godot project for Web:
     - `Project -> Export`
     - Click `Add...` and select `Web`
     - Click `Export Project`
  6) Set the export path to the `/static/godot/` folder and name the file `index.html` to match our iframe.
  6) Run Flask! If everything worked, the Godot game should appear embedded in the Flask page.
  7) **Note**: Current version is a test, export again when more finalized!

### IMPORTING BLENDER MODELS
---

  1) Create your model in blender first!
  2) Click file, as you would when saving it, and go to export
  3) Export your file as a .glb file to your godot project folder
  6) Open your godot project!!!
  7) Click on your blender file which should be in your filesystem now and click the __import__ tab
  8) Import as 'Scene' and go to Advanced Import Settings 
  9) You can mess around there with configs （theres a lot of stuff..) and then click reimport!!!!!!!
  10) Based on what the model is, import it either in your main scene by using __instantiate child scene__ or in your character scene!
  11) Now you have a silly little blender thing character (whatever you imported)

