module DevOpsMWE

export greet
export sin_interpolant_0to1

using Interpolations

# Write your package code here.
"""
    greet()

Return a friendly greeting.
"""
greet() = "Hello, World!"

function sin_interpolant_0to1()
    x = (-π):(π / 100):π
    y = sin.(x)
    return scale(interpolate(y, BSpline(Linear())), x)
end

end
