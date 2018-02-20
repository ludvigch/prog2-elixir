defmodule Mandelbrot do
    @on_load :load_nifs

    def load_nifs do
        :erlang.load_nif("./mandelbrot", 0)
    end

    def mandelbrot(_a, _b, _c) do
        raise "NIF mandelbrot/3 not implemented"
    end

end
