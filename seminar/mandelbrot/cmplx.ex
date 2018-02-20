defmodule Cmplx do
    def new(r, i), do: {r, i}

    def add({ra, ia}, {rb, ib}) do
        {ra+rb, ia+ib}
    end

    def sqr({r, i}) do
        {r*r-i*i, 2*r*i}
    end

    def abs({r, i}) do
        :math.sqrt(r*r+i*i)
    end
end
