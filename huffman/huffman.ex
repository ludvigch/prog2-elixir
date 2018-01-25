defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog this is a sample text that we will use when we build up a table we will only handle lower case letters and no punctuation symbols the frequency will of course not represent english but it is probably not that far off'
    end

    def text, do: 'this is something that we should encode'

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    # sample: strin/"char list"
    # map: map
    def freq(sample), do: freq(sample, %{})
    def freq([], map), do: Map.to_list(map)
    def freq([h|t], map) do
        import Elixir.Map
        case val=get(map, h) do
            nil -> freq(t, put(map, h, 1))
            _   -> freq(t, put(map, h, val+1))
        end
    end

    # sample: string/"char list"
    def tree(sample) do
        sorted = freq(sample) |> List.keysort(1)
        buildtree(sorted)
    end

    # l: list
    # returns: list
    defp buildtree([_ | []]=l), do: l
    defp buildtree([s1|[s2|t]]) do
        buildtree(List.keysort([makenode(s1,s2)|t], 1))
    end

    defp makenode({c1, f1}, {c2,f2}), do: {{c1,c2}, f1+f2}

    # in: list
    # map: Map
    # code: list
    # returns: Map
    # make a table for encoding the text aka map characters to bit-codes
    def encode_table([{tup, _}]), do: encode_table(%{}, tup, [])
    # if the node is a tuple -> recursively encode its left and right children
    def encode_table(map, {left, right}, code) do
        encode_table(map, left, code++[0]) |> encode_table(right, code++[1])
    end
    # basecase: we have found a value -> return map with added char w/ its code
    def encode_table(map, char, code) do
        Map.put(map, char, code)
    end

    # ?
    # def decode_table(tree) do
    #   tree
    # end

    # text: string/"char list"
    # table: map
    # returns: list
    def encode(text, table) do
        encode(text, table, [])
    end
    def encode([], _, acc), do: acc
    def encode([first|rest], table, acc) do
        encode(rest, table, Map.get(table, first) ++ acc)
    end

    # seq: list
    # table: list
    # returns: list
    def decode([], _), do: []
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char|decode(rest, table)]
    end

    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n) # why this
        case List.keyfind(table, code, 1) do
            char -> {char, rest}
            nil  -> decode_char(seq, n+1, table)
        end
    end
end
