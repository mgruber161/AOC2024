var lines = File.ReadAllLines("/home/mgcandy/DEV/aoc/AOC2024/04/aoc04/input.txt");

var sum = lines.Concat( 
    Enumerable.Range(0, lines[0].Length).Select(i => new string(lines.Select(s => s[i]).ToArray()))).Concat(
    lines.SelectMany((row, rowIdx) => row.Select((x, colIdx) => new { Key = rowIdx - colIdx, Value = x }))
        .GroupBy(x => x.Key, (key, values) => new string(values.Select(i => i.Value).ToArray())).ToArray()).Concat(
    lines.SelectMany((row, rowIdx) => row.Select((x, colIdx) => new { Key = rowIdx + colIdx, Value = x }))
        .GroupBy(x => x.Key, (key, values) => new string(values.Select(i => i.Value).ToArray())).ToArray())
    .Sum(l => ((l.Length - l.Replace("XMAS", string.Empty).Length) / 4) + (l.Length - l.Replace("SAMX", string.Empty).Length) / 4);

Console.WriteLine($"sum p1: {sum}");

var sum_p2 = Enumerable.Range(1, lines[0].Length - 2).Sum(i => 
    Enumerable.Range(1, lines.Count() - 2).Sum(j => 
        lines[j][i] == 'A' && 
        ((lines[j+1][i-1] == 'S' && lines[j-1][i+1] == 'M' ) || (lines[j+1][i-1] == 'M' && lines[j-1][i+1] == 'S' ))
        && ((lines[j-1][i-1] == 'S' && lines[j+1][i+1] == 'M' ) || (lines[j-1][i-1] == 'M' && lines[j+1][i+1] == 'S' ))
        ? 1 : 0));

Console.WriteLine($"sum p2: {sum_p2}");