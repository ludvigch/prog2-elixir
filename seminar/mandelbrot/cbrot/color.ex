defmodule Color do
    def convert(:standard, depth, max) do
        fraction = depth / max
        a = 4*fraction
        x = trunc(a)
        offset = trunc(255 * (a-x))
        case x do
            0 -> {:rgb, offset, 0, 0}
            1 -> {:rgb, 255, offset, 0}
            2 -> {:rgb, 255-offset, 255, 0}
            3 -> {:rgb, 0, 255, offset}
            4 -> {:rgb, 0, 255-offset, 255}
            _ -> :colorerror
        end
    end

    def convert(:rb, depth, max) do
        fraction = depth / max
        a = 2*fraction
        x = trunc(a)
        offset = trunc(255 * (a-x))
        case x do
            0 -> {:rgb, offset, 0, 0}
            1 -> {:rgb, 255, offset, 0}
            2 -> {:rgb, 255, 255, offset}
            _ -> :colorerror
        end
    end


end
