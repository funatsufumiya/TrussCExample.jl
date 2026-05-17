module HapExample

using TrussC
using Printf
import tcxHap

hap = tcxHap
tc = TrussC

function setup()
  setFps(60.0f0)

  global is_loaded = false
  global player = hap.HapPlayer()

  nothing # means void
end

function update()
  if is_loaded && hap.isLoaded(player)
    hap.update(player)
  end

  nothing # means void
end

function draw()
  clear(0.12f0, 1.0f0)

  pushMatrix();
  pushStyle();
  if !is_loaded
    drawBitmapString("Drop hap file (.mov) here!", 30f0, 70f0);
  else
    if hap.isLoaded(player)
      resetStyle()
      hap.draw(player, 0, 0, getWindowWidth(), getWindowHeight())

      setColor(0.3f0, 0.3f0, 0.3f0, 0.5f0)
      drawRect(0f0, 20f0, 200f0, 40f0)

      setColor(Color_black())
      t = hap.getCurrentTime(player)
      drawBitmapString(@sprintf("%0.2f", t), 30f0, 70f0)
    end
  end
  popStyle();
  popMatrix();

  # show fps
  drawBitmapString(@sprintf("fps: %.1f", getFps()), 30f0, 30f0);

  nothing # means void
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function mousePressed(pos::Vec2Ref, button::Cint)
  # println("pos: ", x(pos), ", ", y(pos), " (", button ,")")
end

function filesDropped(files::FilesRef)
  # println("files dropped length: ", length(files))
  for file in files
    println("file: ", file)
    if endswith(file, ".mov") || endswith(file, ".avi")
      hap.load(player, file)
      hap.play(player)
      hap.setLoop(player, true)
    else
      println("[Warning] files dropped, but only .mov and .avi is supported!")
    end
  end
end

function main()
  @setup(setup)
  @update(update)
  @draw(draw)
  @keyPressed(keyPressed)
  @mousePressed(mousePressed)
  # @mouseScrolled(mouseScrolled)
  # @mouseMoved(mouseMoved)
  # @mouseDragged(mouseDragged)
  # @windowResized(windowResized)
  @filesDropped(filesDropped)

  runTrusscApp()
end

end # module HapExample
