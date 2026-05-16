module EasyCamExample

using TrussC
using Printf
using Pipe

tc = TrussC

# cam = nothing
# light = nothing
# boxMesh = nothing
# sphereMesh = nothing
# coneMesh = nothing
# cylinderMesh = nothing
# matRed = nothing
# matOrange = nothing
# matBlue = nothing
# matCyan = nothing
# matYellow = nothing
# matMagenta = nothing

showHelp = true

function setup()
  setWindowTitle("easyCamExample")

  setFps(60.0f0)

  # Camera initial settings
  global cam = EasyCam()
  @pipe cam |> setDistance(_, 600f0) 
  @pipe cam |> setTarget(_, 0f0, 0f0, 0f0)
  @pipe cam |> enableMouseInput(_)  # Auto-subscribe to mouse events

  # Generate meshes
  global boxMesh = createBox(100f0)
  global sphereMesh = createSphere(50f0, 24)
  global coneMesh = createCone(50f0, 100f0, 24)
  global cylinderMesh = createCylinder(50f0, 100f0, 24)

  # Light settings (bright ambient for clear visibility)
  global light = Light()
  @pipe light |> setDirectional(_, Vec3(-0.7f0, -1.0f0, -0.4f0))  # Asymmetric angle
  @pipe light |> setAmbient(_, 0.8f0, 0.8f0, 0.85f0)
  @pipe light |> setDiffuse(_, 0.6f0, 0.6f0, 0.55f0)
  @pipe light |> setSpecular(_, 0.6f0, 0.6f0, 0.6f0)

  # Material settings
  global matRed = Material_plastic(Color(0.9f0, 0.2f0, 0.2f0), 0.5f0)
  global matOrange = Material_plastic(Color(1.0f0, 0.6f0, 0.2f0), 0.5f0)
  global matBlue = Material_plastic(Color(0.2f0, 0.4f0, 0.9f0), 0.5f0)
  global matCyan = Material_plastic(Color(0.2f0, 0.8f0, 0.8f0), 0.5f0)
  global matYellow = Material_plastic(Color(1.0f0, 0.9f0, 0.2f0), 0.5f0)
  global matMagenta = Material_plastic(Color(0.9f0, 0.2f0, 0.8f0), 0.5f0)

  nothing # this means return void
end

function draw()
  clear(0.08f0, 1.0f0)

  # --- 3D drawing (camera enabled) ---
  begin_cam(cam)

  # Enable lighting
  addLight(light)
  setCameraPosition(getPosition(cam))
  setColor(Color_white())

  # Right: Red cone
  pushMatrix()
  translate(150f0, 0f0, 0f0)
  setMaterial(matRed)
  tc.draw(coneMesh)
  popMatrix()

  # Left: Orange sphere
  pushMatrix()
  translate(-150f0, 0f0, 0f0)
  setMaterial(matOrange)
  tc.draw(sphereMesh)
  popMatrix()

  # Bottom: Blue box
  pushMatrix()
  translate(0f0, 150f0, 0f0)
  setMaterial(matBlue)
  tc.draw(boxMesh)
  popMatrix()

  # Top: Cyan cylinder
  pushMatrix()
  translate(0f0, -150f0, 0f0)
  setMaterial(matCyan)
  tc.draw(cylinderMesh)
  popMatrix()

  # Front: Yellow box
  pushMatrix()
  translate(0f0, 0f0, 150f0)
  setMaterial(matYellow)
  tc.draw(boxMesh)
  popMatrix()

  # Back: Magenta box
  pushMatrix()
  translate(0f0, 0f0, -150f0)
  setMaterial(matMagenta)
  tc.draw(boxMesh)
  popMatrix()

  # End lighting
  clearMaterial()
  clearLights()

  # Draw grid
  # setColor(0.4f0, 0.4f0, 0.4f0)
  # drawGrid(400, 10)

  end_cam(cam)

   ## --- 2D drawing (UI) ---
  setColor(Color_white())

  if showHelp
      local ss = ""
      ss = ss * "FPS: " * @sprintf("%.1f", getFrameRate()) * "\n"
      ss = ss * "MOUSE INPUT: " * (isMouseInputEnabled(cam) ? "ON" : "OFF") * "\n"
      ss = ss * "Distance: " * @sprintf("%.0f", getDistance(cam)) * "\n"
      ss = ss * "\n"
      ss = ss * "Controls:\n"
      ss = ss * "  LEFT DRAG: rotate camera\n"
      ss = ss * "  MIDDLE DRAG: pan camera\n"
      ss = ss * "  SCROLL: zoom in/out\n"
      ss = ss * "Keys:\n"
      ss = ss * "  c: toggle mouse input\n"
      ss = ss * "  r: reset camera\n"
      ss = ss * "  f: toggle fullscreen\n"
      ss = ss * "  h: toggle this help\n"
      drawBitmapString(ss, 20f0, 20f0, true);
  end

  nothing # this means return void
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")

  if c == 'f' || c == 'F'
      toggleFullscreen()
  elseif c == 'c' || c == 'C'
      if isMouseInputEnabled(cam)
          disableMouseInput(cam)
      else
          enableMouseInput(cam)
      end
  elseif c == 'r' || c == 'R'
      tc.reset(cam)
      setDistance(cam, 600f0)
  elseif c == 'h' || c == 'H'
      global showHelp = !showHelp
  end

  nothing # this means return void
end

function mousePressed(pos::Vec2Ref, button::Cint)
  # println("pos: ", x(pos), ", ", y(pos), " (", button ,")")

  nothing # this means return void
end

function mouseScrolled(delta::Vec2Ref)
  # println("delta: ", x(delta), ", ", y(delta))

  nothing # this means return void
end

function mouseMoved(pos::Vec2Ref)
  # println("pos: ", x(pos), ", ", y(pos))

  nothing # this means return void
end

function mouseDragged(pos::Vec2Ref, button::Cint)
  # println("pos: ", x(pos), ", ", y(pos), " (", button ,")")

  nothing # this means return void
end

function windowResized(width::Cint, height::Cint)
  println("window resized: ", width, ", ", height)

  nothing # this means return void
end

function filesDropped(files::FilesRef)
  println("files dropped length: ", length(files))
  for file in files
    println("file: ", file)
  end

  nothing # this means return void
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

  runTrusscApp()
end

end # module EasyCamExample
