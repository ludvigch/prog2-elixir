defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog this is a sample text that we will use when we build up a table we will only handle lower case letters and no punctuation symbols the frequency will of course not represent english but it is probably not that far off'
    end

    def text, do: 'this is something that we should encode'

    def test do
        sample = read("kallocain.txt", :all)
        tree = tree(sample)
        IO.puts "built tree\nencoding tablestarted"
        encode = encode_table(tree)
        IO.puts "encoding table done\ndecoding table started"
        decode = decode_table(tree)
        IO.puts "decoding table done\nstarted reading text"
        text = read("kallocain.txt", :all)
        #text = sample()
        IO.puts "text read\nencoding the text"
        seq = encode(text, encode)
        IO.puts "text encoded\ndecoding started"
        decode_help(seq, decode)
        #IO.puts "decoding done"
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
    defp buildtree([root]), do: elem(root, 0)
    defp buildtree([s1|[s2|t]]) do
        buildtree(List.keysort([makenode(s1,s2)|t], 1))
    end

    defp makenode({c1, f1}, {c2,f2}), do: {{c1,c2}, f1+f2}

    # in: list
    # map: Map
    # code: list
    # returns: Map
    # make a table for encoding the text aka map characters to bit-codes
    def encode_table(tree), do: encode_table(%{}, tree, [])
    # if the node is a tuple -> recursively encode its left and right children
    def encode_table(map, {left, right}, code) do
        encode_table(map, left, code++[0]) |> encode_table(right, code++[1])
    end
    # basecase: we have found a value -> return map with added char w/ its code
    def encode_table(map, char, code) do
        Map.put(map, char, code)
    end

    # ?
    def decode_table(tree), do: decode_table(%{}, tree, [])
    def decode_table(map, {left, right}, code) do
        decode_table(map, left, code++[0]) |> decode_table(right, code++[1])
    end
    def decode_table(map, char, code) do
        Map.put(map, code, char)
    end


    # text: string/"char list"
    # table: map
    # returns: list
    def encode(text, table) do
        encode(text, table, [])
    end
    def encode([], _, acc), do: acc
    def encode([first|rest], table, acc) do
        encode(rest, table, Map.get(table, first)++acc)
    end

    # seq: list
    # table: list
    # returns: list
    def decode_help(seq, table) do
        Enum.reverse(decode(seq, table))
    end
    def decode([], _), do: []
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char|decode(rest, table)]
    end

    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case Map.get(table, code) do
            nil  -> decode_char(seq, n+1, table)
            char -> {char, rest}
        end
    end

    def read(file, n) do
        {:ok, file} = File.open(file, [:read])
        binary = IO.read(file, n)
        File.close(file)

        case :unicode.characters_to_list(binary, :utf8) do
            {:incomplete, list, _} -> list;
            list -> list
        end
    end

end
