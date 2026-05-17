module TrussCExample

include("EasyCamExample.jl")
include("BasicExample.jl")
include("HapExample.jl")

import .BasicExample
import .EasyCamExample
import .HapExample

function main()
  BasicExample.main()
end

export BasicExample, EasyCamExample, HapExample

end # module TrussCExample