defmodule Brot do

    def mandelbrot(c, m) do
        z0 = Cmplx.new(0, 0)
        i = 0
        test(i, z0, c, m)
    end

    def test(i, _z, _c, m) when i >= m, do: 0
    def test(i, z, c, m) do
        if Cmplx.abs(z) >= 2.0 do
            i
        else
            znext = Cmplx.add(Cmplx.sqr(z), c)
            test(i+1, znext, c, m)
        end
    end

end
