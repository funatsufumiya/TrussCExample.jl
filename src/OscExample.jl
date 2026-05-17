module OscExample

using TrussC
using Printf

tc = TrussC
osc = TrussC # WORKAROUND

function setup()
  setFps(60.0f0)

  global oscSender = osc.OscSender()
  osc.connect(oscSender, "127.0.0.1", 12345)

  global oscReceiver = osc.OscReceiver()
  osc.setup(oscReceiver, 12346)

  nothing # means void
end

function update()
  while osc.hasNewMessage(oscReceiver)
    msg = osc.OscMessage()
    osc.getNextMessage(oscReceiver, msg)
    println("OSC Message received at port 12346: ", msg)
  end

  nothing # means void
end

function draw()
  clear(0.12f0, 1.0f0)

  # show fps
  drawBitmapString("Press space key to send OSC to localhost:12345", 30f0, 30f0);
  drawBitmapString("OscReceiver is listening at port 12346 ...", 30f0, 70f0);
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")

  if c == ' '
    msg = osc.OscMessage("/hello")
    osc.send(oscSender, msg)

    println("OscMessage /hello sent to localhost:12345")
  end

  nothing # means void
end

function mousePressed(pos::Vec2Ref, button::Cint)
  # println("pos: ", x(pos), ", ", y(pos), " (", button ,")")

  nothing # means void
end

function main()
  @setup(setup)
  @draw(draw)
  @update(update)
  @keyPressed(keyPressed)
  @mousePressed(mousePressed)
  # @mouseScrolled(mouseScrolled)
  # @mouseMoved(mouseMoved)
  # @mouseDragged(mouseDragged)
  # @windowResized(windowResized)
  # @filesDropped(filesDropped)

  runTrusscApp()
end

end # module OscExample
