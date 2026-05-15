module TrussCExample

using TrussC
using Printf

tc = TrussC

function setup()
  println("setup!")

  setFps(60.0f0)
end

function draw()
  clear(0.12f0, 1.0f0)

  # Rotating box
  pushMatrix();
  noFill();
  translate(getWindowWidth() / 2.0f0, getWindowHeight() / 2.0f0);
  rotate(Float32(getElapsedTimef() * 0.1f0), Float32(getElapsedTimef() * 0.15f0), 0.0f0);
  drawBox(200.0f0);
  popMatrix();

  # show fps
  drawBitmapString(@sprintf("fps: %.1f", getFps()), 30f0, 30f0);
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function mousePressed(pos::Vec2Ref, button::Cint)
  println("pos: ", x(pos), ", ", y(pos), " (", button ,")")
end

function mouseScrolled(delta::Vec2Ref)
  println("delta: ", x(delta), ", ", y(delta))
end

function mouseMoved(pos::Vec2Ref)
  println("pos: ", x(pos), ", ", y(pos))
end

function mouseDragged(pos::Vec2Ref, button::Cint)
  println("pos: ", x(pos), ", ", y(pos), " (", button ,")")
end

function windowResized(width::Cint, height::Cint)
  println("window resized: ", width, ", ", height)
end

function filesDropped(files::FilesRef)
  println("files dropped length: ", length(files))
  for file in files
    println("file: ", file)
  end
end

function main()
  @setup(setup)
  @draw(draw)
  @keyPressed(keyPressed)
  @mousePressed(mousePressed)
  # @mouseScrolled(mouseScrolled)
  # @mouseMoved(mouseMoved)
  # @mouseDragged(mouseDragged)
  @windowResized(windowResized)
  @filesDropped(filesDropped)

  # println(greet())
  runTrusscApp()
end

end # module TrussCExample
