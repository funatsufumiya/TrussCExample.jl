module TrussCExample

include("EasyCamExample.jl")
include("BasicExample.jl")

import .BasicExample
import .EasyCamExample

function main()
  BasicExample.main()
end

export BasicExample, EasyCamExample

end # module TrussCExample