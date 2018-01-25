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

    def freq(sample), do: freq(sample, %{})

    def freq([], map), do: Map.to_list(map)
    def freq([h|t], map) do
        import Elixir.Map
        case val=get(map, h) do
            nil -> freq(t, put(map, h, 1))
            _   -> freq(t, put(map, h, val+1))
        end
    end

    def tree(sample) do
        sorted = freq(sample) |> List.keysort(1)
        buildtree(sorted)
    end

    defp buildtree([_ | []]=l), do: l
    defp buildtree([s1|[s2|t]]) do
        buildtree(List.keysort([makenode(s1,s2)|t], 1))
    end

    defp makenode({c1, f1}, {c2,f2}), do: {{c1,c2}, f1+f2}

    # make a table for encoding the text
    def encode_table([{tup, _}]), do: encode_table(%{}, tup, [])
    # If the node is a tuple -> recursively encode its left and right children
    def encode_table(map, {left, right}, code) do
        encode_table(map, left, code++[0]) |> encode_table(right, code++[1])
    end
    # Basecase: we have found a value -> return map with added char w/ its code
    def encode_table(map, char, code) do
        Map.put(map, char, code)
    end
    # old pattern matching shit dont use this please remove asap REEEEE
    _ = """
    def encode_table(map, {{_,_} = left, {_,_}= right}, code) do
        encode_table(map, left, code++[0]) |> encode_table(right, code++[1])
    end
    def encode_table(map, {{_,_} = left, char}, code) do
        encode_table(Map.put(map, char, code), left, code++[0])
    end
    def encode_table(map, {char, {_,_}=right}, code) do
        encode_table(Map.put(map, char, code), right, code++[1])
    end
    def encode_table(map, {val1, val2}, code) do
        Map.put(map, val1, code++[0]) |> Map.put(val2, code++[1])
    end
    """

    def decode_table(tree) do
        tree
    end

    def encode(text, table) do
        text
    end

    def decode(seq, tree) do
        seq
    end
end
