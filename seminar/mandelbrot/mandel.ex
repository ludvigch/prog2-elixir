defmodule Mandel do
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        range = 1..height
        ctrl = self()
        Enum.each(range, fn(h) -> spawn_link(fn() -> row(width, h, trans, depth, [], ctrl) end) end)
        fin = List.keysort(Map.to_list(rows(height, trans, depth, %{})), 0)
        exval(fin, [])
    end

    def exval([], acc), do: acc
    def exval([{k, v} | rest], acc) do
        exval(rest, [v | acc])
    end

    def rows(0, _, _ , map), do: map
    def rows(height, trans, depth, map) do
        receive do
            {:row, h, row} ->
                updated = Map.put(map, h, row)
                rows(height-1, trans, depth, updated)
        end
    end

    def row(0, height, _, _, row, pid) do
        send(pid, {:row, height, row})
    end
    def row(width, height, trans, depth, row, pid) do
        num = Brot.mandelbrot(trans.(width, height), depth)
        row(width-1, height, trans, depth, [Color.convert(:standard, num, depth)|row], pid)
    end

    _ = """
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
        num = Brot.mandelbrot(trans.(width, height), depth)
        row(width-1, height, trans, depth, [Color.convert(:standard, num, depth)|row])
    end
    """

end
