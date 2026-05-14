module TrussCExample

using TrussC
using Printf

function setup()
  println("setup!")

  TrussC.setFps(60.0f0)
end

function draw()
  TrussC.clear(0.12f0, 1.0f0)

  # Rotating box
  TrussC.pushMatrix();
  TrussC.noFill();
  TrussC.translate(TrussC.getWindowWidth() / 2.0f0, TrussC.getWindowHeight() / 2.0f0);
  TrussC.rotate(Float32(TrussC.getElapsedTimef() * 0.1f0), Float32(TrussC.getElapsedTimef() * 0.15f0), 0.0f0);
  TrussC.drawBox(200.0f0);
  TrussC.popMatrix();

  # show fps
  TrussC.drawBitmapString(@sprintf("fps: %.1f", TrussC.getFps()), 30f0, 30f0);
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function mousePressed(pos::TrussC.Vec2Ref, button::Cint)
  println("pos: ", TrussC.x(pos), ", ", TrussC.y(pos), " (", button ,")")
end

function mouseScrolled(delta::TrussC.Vec2Ref)
  println("delta: ", TrussC.x(delta), ", ", TrussC.y(delta))
end

function mouseMoved(pos::TrussC.Vec2Ref)
  println("pos: ", TrussC.x(pos), ", ", TrussC.y(pos))
end

function mouseDragged(pos::TrussC.Vec2Ref, button::Cint)
  println("pos: ", TrussC.x(pos), ", ", TrussC.y(pos), " (", button ,")")
end

function windowResized(width::Cint, height::Cint)
  println("window resized: ", width, ", ", height)
end

function filesDropped(files::TrussC.FilesRef)
  println("files dropped length: ", length(files))
  for file in files
    println("file: ", file)
  end
end

function main()
  TrussC.@setup(setup)
  TrussC.@draw(draw)
  TrussC.@keyPressed(keyPressed)
  TrussC.@mousePressed(mousePressed)
  # TrussC.@mouseScrolled(mouseScrolled)
  # TrussC.@mouseMoved(mouseMoved)
  # TrussC.@mouseDragged(mouseDragged)
  TrussC.@windowResized(windowResized)
  TrussC.@filesDropped(filesDropped)

  # println(TrussC.greet())
  TrussC.runTrusscApp()
end

end # module TrussCExample
