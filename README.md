# My_FPS Framework
## Explanation

This is a First Person Shooter Module/Framework for Roblox.  
It's meant to ease the setup process.

This framework uses a "OBB", which stands for Offset Based Blending.  
It simply means that multiple offsets will contribute on the final processed position  

## Functions
### SetUp (amount_of_offsets)
It creates a folder inside the player, which will hold the ___amount_of_offsets___ as CFrameValues.

> returns all the offsets in an array

### SetMainObject (obj)
Sets the main object (example a gun) on which every modification will be applied. Favourable a model

### SetMainOffset (off)
Sets the main offset to be applied on the Main Object.

### SetInterpolationDelta (delta)
Sets the ___delta___ to be applied under the Linear Interpolation argument "alpha".

### LockFirstPerson ()
Locks the player into First Person

### UnlockFirstPerson ()
Unlocks the player from First Person

### Run ()
Applies all Offsets into a single calculated CFrame and constantly modifyies the position into a RenderStepped event.

> returns an object controller which allows you to disable the current RenderStepped connection

### CreateAnimation (offset, animation)
the ***offset*** paramater is the current offset, which the animation will be applied on  
the ***animation*** parameter is an array of an object "PROCAnimation" which looks like this

***Time: number***  
Determines the time taken to run the current keyframe interpolation

***Keyframe: CFrame***  
The Keyframe in CFrame, which the animation will be playing.

***EStyle: EasingStyle? (default: Quint)***  
The EasingStyle Property to run the current keyframe interpolation

***EDir: EasingDirection? (default: Out)***  
The EasingDirection Property to run the current keyframe interpolation

> returns an object controller which contains the keyframes and a "Disable" function
