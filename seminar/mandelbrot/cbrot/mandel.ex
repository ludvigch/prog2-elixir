defmodule Mandel do
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        rows(width, height, trans, depth, [])
    end

    def rows(_, 0, _, _ , list), do: list
    def rows(width, height, trans, depth, list) do
        row = row(width, height, trans, depth, [])
        rows(width, height-1, trans, depth, [row | list])
    end

    def row(0, _, _, _, row), do: row
    def row(width, height, trans, depth, row) do
        {r, i} = trans.(width, height)
        #IO.puts(r)
        #IO.puts(i)
        #IO.puts(depth)
        num = Mandelbrot.mandelbrot(r, i, depth)
        row(width-1, height, trans, depth, [Color.convert(:rb, num, depth)|row])
    end

end
