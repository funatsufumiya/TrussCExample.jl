module TrussCExample

include("EasyCamExample.jl")
include("BasicExample.jl")
include("OscExample.jl")

import .BasicExample
import .EasyCamExample
import .OscExample

function main()
  BasicExample.main()
end

export BasicExample, EasyCamExample, OscExample

end # module TrussCExample