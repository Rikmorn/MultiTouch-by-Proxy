#MultiTouch by Proxy

__Description__

Another old project. Proof of concept, nothing more.
The point of this project was to see how to enable multitouch when the user is not actually touching the screen surface, but instead using a proxy, like for example Apple's trackpad on their laptops.
Developed using [Processing](http://processing.org/).
The video library in Processing is quite unstable (at least it was when I wrote the software) so don't be surprised this crashes with playing a video.
The main principles of this demo are to minimize trial and error when using multitouch on a proxy device. This could be accomplished by maximizing the use of corners and edges (which map 1:1 with the screen itself) to enable various types of interaction. This principle can be seen on the various bars that tend to aggregate elements on the corners. The UI also has interactions that can only be conducted by using two hands which offers users mental cues on relative distance measurements of UI elements. 
More details can be offered on request.

__Instalation__

A few values are hard coded, this was a proof of concept. 
You will need to add two files to make the project work properly, those are:

* A video file called video.mov on the data/Video folder.
* An image file to be the background called Background.jpg in the data/Images folder 

Processing's TUIO library is needed to run this demo.

__Executing__

To run this just execute MultiTouch.pde in Processing

This code has been discontinued, but if you are interested in it feel free to use it.
