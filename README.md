# TrussCExample.jl

[TrussC](https://trussc.org/) Julia example, using [TrussC.jl](https://github.com/funatsufumiya/TrussC.jl)

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
