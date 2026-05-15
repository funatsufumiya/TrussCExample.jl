# TrussCExample.jl

[TrussC](https://trussc.org/) Julia example, using [TrussC.jl](https://github.com/funatsufumiya/TrussC.jl)

## Sample code

```julia
module TrussCExample

using TrussC

# tc = TrussC

function setup()
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
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function main()
  @setup(setup)
  @draw(draw)
  @keyPressed(keyPressed)

  runTrusscApp()
end

end # module TrussCExample

```

## Usage

### Run julia code

```bash
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. -e 'using TrussCExample; TrussCExample.main();'
```

![screenshot](docs/screenshot.png)

> [!Warning]
> ***Windows CxxWrap.jl issue***<br><br>
> If not working CxxWrap.jl on Windows, you need to try [Building libcxxwrap-julia](https://github.com/JuliaInterop/libcxxwrap-julia#building-libcxxwrap-julia) (Because prebuilt packaged dll for CxxWrap.jl is not compatible with MSVC). Please see https://github.com/funatsufumiya/CxxWrapTest.jl or https://github.com/JuliaInterop/CxxWrap.jl in detail.
