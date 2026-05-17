module TrussCExample

include("EasyCamExample.jl")
include("BasicExample.jl")
include("HapExample.jl")
include("OscExample.jl")

import .BasicExample
import .EasyCamExample
import .HapExample
import .OscExample

function main()
  BasicExample.main()
end

export BasicExample, EasyCamExample, HapExample, OscExample

end # module TrussCExample