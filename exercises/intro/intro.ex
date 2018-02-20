defmodule Intro do#me
    # farenheit to celsius conversion
    def ftoc(f), do: (f-32)/1.8
    # area of rectangle
    def arectangle(a, b), do: a*b
    # area of square
    def asquare(a), do: arectangle(a,a)
    # area of circle
    def acircle(r), do: r*r*3.14159
    # product by addition
    def product(0, _), do: 0
    def product(m, n), do: n+product(m-1, n)
    # computes exponentiation x^y
    def exp(_, 0), do: 1
    def exp(x, y), do: x * exp(x, y-1)
    # faster version of exponentiation
    def fastexp(_, 0), do: 1
    def fastexp(x, 1), do: x
    def fastexp(x, y) do
        if !rem(y,2) do
            fastexp(fastexp(x, y/2), 2)
        else
            fastexp(x, y-1)
        end
    end
    # return nth element from list l
    def nth(_, []), do: :outofbounds
    def nth(0, l), do: hd l
    def nth(n,l), do: nth(n-1, tl l)
    # return length of list l
    def len(l), do: len(0, l)
    def len(n, []), do: n
    def len(n, l), do: len(n+1, tl l)
    # sum value of all elements in list l
    def sum(l), do: sum((hd l), tl l)
    def sum(n, []), do: n
    def sum(n, l), do: sum(n+(hd l), tl l)
    # for every element insert 2 of that element into new list
    def duplicate(l), do: _duplicate(l)
    defp _duplicate([head | rest] = [_ | []]), do: head
    defp _duplicate([head | rest]), do: [[head]++[head] | rest]
    # for every element in l check if x is equal to that element,
    # if so return only l. if x not in l return l with x added
    def adder(x, l) do
        _adder(x, l, l)
    end
    defp _adder(x, l, []) do
        l ++ [x]
    end
    defp _adder(x, l, temp) do
        if x == hd temp do
            l
        else
            _adder(x, l , tl temp)
        end
    end
    # if x is not equal to current head of list add to temp.
    # else dont add.
    def remove(_, []) do
        []
    end
    def remove(x, l) do
        _remove(x, l, [])
    end
    defp _remove(_, [], temp) do
        temp
    end
    defp _remove(x, l, temp) do
        if x == hd l do
            _remove(x, (tl l), temp)
        else
            _remove(x, (tl l), temp++[hd l])
        end
    end
    # for every item in list l add it to temp if not alread in temp
    # else continue
    def unique(l) do
        _unique(l, [])
    end
    defp _unique([], temp) do
        temp
    end
    defp _unique(l, temp) do
        _unique((tl l), adder((hd l), temp))
    end
    # pack :3
    # for every item in list add to sublist of temp list where item is
    # equal to every item in sublist.
    def pack([]), do: []
    def pack([atom|rest]), do: _insert(atom, pack(rest))

    defp _insert(atom, []), do: [[atom]]
    defp _insert(atom, [([atom | _] = list)|rest]), do: [[atom|list] | rest]
    defp _insert(atom, [head | rest]), do: [head | _insert(atom, rest)]
    # reverse
    def reverse(l), do: _reverse(l,[])
    defp _reverse([], temp), do: temp
    defp _reverse([head|rest], temp), do: _reverse(rest, [head | temp])
end#me
