# go-go-godot
### Christine and Joyce !!!!!!!!!!
<img width="320" height="300" alt="image" src="https://github.com/user-attachments/assets/d1f16830-f9b8-498c-bfc3-6660e4c4b3b6" />

## ***NOTES BEGIN***
### <ins>AVAILABLE RENDERERS</ins>
  
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

### <ins>INTRO</ins>
  * Godot supports C#, C++, and its own GDScript
    * GDScript is like a blend between TypeScript and Python (syntax will generally be the same as Python's)
  * Creating a game begins with a __scene__
    * Scenes contain a tree of nodes
      * Controls appearance and behavior of objects and the scene
      * Nodes can have script/code attached that updates the object for every frame in the game loop
    * Scene can then be saved to disk and used within other scenes

### <ins> HOW DO I GET STARTED ???????? </ins>

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
     - Click 'Other node' and add a __animatable body__ (once upon a time kinematic body) as the root this time
       - Ideal for objects you move around with a controller
       - Now add a collision shape and a mesh instance to the scene
  9) Open 'Project Settings' in the 'Project' tab and go to input map
     - This is where you will set up your keybinds by creating labels such as move left and move right
       - Map them to different controls/keys
  10) You can now start writing code by attaching a script to the root object (in this case it is the animatable body)
  11) Inside the script, you can create variables with `var VARNAME`. Export them (by adding export before var) to make them public in the editor
  12) You can also create functions with `func FUNCNAME(params):`
  13) Now go baack to the main scene in your filesystem on the lower right or the tabs on the top. If you have not saved anything, they will NOT appear within the filesystem
  14) Right click within the main scene and click 'Instantiate child scene' and select your player
  15) Add a camera for the perspective
  16) Now when you click the play button in the upper right, you should see your objects behave as they were coded!!!
