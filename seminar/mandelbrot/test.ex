defmodule Test do
    def demo() do
        x = 0.001643721971153
        y = -0.822467633298876
        small(x, y, x+0.000002)
    end

    def small(x0, y0, zoom) do
        width = 1920
        height = 1080
        depth = 100
        k = (zoom - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        filename = ["pics/mandelbrot" | [Integer.to_string(:erlang.system_time()) | ".ppm"]]
        PPM.write(filename, image)
    end
end
