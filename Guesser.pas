begin
  // Base crop sell values (₵ per fruit)
  var baseValues := new Dictionary<string, real>;
  baseValues['Carrot'] := 20;
  baseValues['Strawberry'] := 25;
  baseValues['Blueberry'] := 30;
  baseValues['Orange Tulip'] := 17000;
  baseValues['Tomato'] := 60;
  baseValues['Corn'] := 27;
  baseValues['Daffodil'] := 6000;
  baseValues['Watermelon'] := 900;
  baseValues['Pumpkin'] := 500;
  baseValues['Apple'] := 300;
  baseValues['Bamboo'] := 1000;
  baseValues['Coconut'] := 35;
  baseValues['Cactus'] := 500;
  baseValues['Dragon Fruit'] := 510;
  baseValues['Mango'] := 1100;
  baseValues['Grape'] := 2800;
  baseValues['Mushroom'] := 7530;
  baseValues['Pepper'] := 3500;
  baseValues['Cacao'] := 1275;
  baseValues['Beanstalk'] := 2000;
  baseValues['Pineapple'] := 115;
  baseValues['Peach'] := 200;
  baseValues['Raspberry'] := 115;
  baseValues['Chocolate Carrot'] := 40000;
  baseValues['Nightshade'] := 3500;
  baseValues['Red Lollipop'] := 15000;
  baseValues['Mint'] := 5500;
  baseValues['Pear'] := 200;
  baseValues['Glowshroom'] := 3.7;
  baseValues['Cranberry'] := 3.5;
  baseValues['Durian'] := 8.4;
  baseValues['Easter Egg'] := 814.5;
  baseValues['Moonflower'] := 4500;
  baseValues['Starfruit'] := 3500;
  baseValues['Papaya'] := 0;
  baseValues['Eggplant'] := 1750;
  baseValues['Moonglow'] := 2000;
  baseValues['Passionfruit'] := 1550;
  baseValues['Lemon'] := 500;
  baseValues['Banana'] := 114;
  baseValues['Blood Banana'] := 6940;
  baseValues['Moon Melon'] := 2800;
  baseValues['Moon Blossom'] := 30000;
  baseValues['Cherry Blossom'] := 30000;
  baseValues['Candy Blossom'] := 44082.8;
  baseValues['Lotus'] := 4.35;
  baseValues['Venus Fly Trap'] := 2570;
  baseValues['Cursed Fruit'] := 520;
  baseValues['Soul Fruit'] := 1440;

  // Primary mutation multipliers
  var primaryMultipliers := new Dictionary<string, integer>;
  primaryMultipliers['None'] := 1;
  primaryMultipliers['Golden'] := 20;
  primaryMultipliers['Rainbow'] := 50;

  // Stacked mutation additions
  var stackAdd := new Dictionary<string, integer>;
  stackAdd['Wet'] := 2;
  stackAdd['Chilled'] := 2;
  stackAdd['Chocolate'] := 2;
  stackAdd['Moonlit'] := 2;
  stackAdd['Bloodlit'] := 4;
  stackAdd['Frozen'] := 10;
  stackAdd['Zombified'] := 25;
  stackAdd['Shocked'] := 100;
  stackAdd['Celestial'] := 120;
  stackAdd['Disco'] := 125;

  // --- Read plant ---
  Write('Plant name: ');
  var plant := ReadString().Trim();
  if not baseValues.ContainsKey(plant) then
  begin
    Writeln('Unknown plant.');
    Exit;
  end;

  // --- Read primary mutation ---
  Write('Primary (None, Golden, Rainbow): ');
  var p := ReadString().Trim().ToLower();
  var primary := '';
  if p = 'none' then primary := 'None'
  else if p = 'golden' then primary := 'Golden'
  else if p = 'rainbow' then primary := 'Rainbow'
  else
  begin
    Writeln('Invalid primary mutation.');
    Exit;
  end;

  // --- Read stacked mutations ---
  Write('Additional mutations (comma-separated, leave blank if none): ');
  var raw := ReadString().Trim();
  var stacks := new List<string>;
  if raw <> '' then
  begin
    var parts := raw.Split(',');
    foreach var part in parts do
    begin
      var m := part.Trim();
      if m = '' then continue;
      var norm := m.Substring(0, 1).ToUpper();
      if m.Length > 1 then norm += m.Substring(1).ToLower();
      stacks.Add(norm);
    end;
  end;

  // If Frozen is chosen, disallow Wet and Chilled
  if stacks.Contains('Frozen') and (stacks.Contains('Wet') or stacks.Contains('Chilled')) then
  begin
    Writeln('Cannot combine Frozen with Wet or Chilled.');
    Exit;
  end;

  // --- Compute multipliers ---
  var stackSum := 1;
  foreach var m in stacks do
  begin
    if not stackAdd.ContainsKey(m) then
    begin
      Writeln('Unknown mutation: ' + m);
      Exit;
    end;
    stackSum += stackAdd[m];
  end;

  var totalMult := primaryMultipliers[primary] * stackSum;
  var sellValue := baseValues[plant] * totalMult;

  // --- Output ---
  Write('Calculate for specific quantity? (yes/no): ');
  var ans := ReadString().Trim().ToLower();
  if ans = 'yes' then
  begin
    Write('Enter quantity (leave blank for 1): ');
    var qtyInput := ReadString().Trim();
    var qty: real;
    if qtyInput = '' then
      qty := 1
    else
      qty := StrToFloat(qtyInput);

    if qty < 0 then
    begin
      Writeln('Invalid amount.');
      Exit;
    end;

    var totalSell := sellValue * qty;
    Writeln('Sell value for ', qty:0:2, ' ', plant,
            ' (primary=', primary,
            ', mutations=[', String.Join(', ', stacks.ToArray()), ']) = ',
            totalSell:0:2, '₵');
  end
  else
    Writeln('Sell value per ', plant,
            ' (primary=', primary,
            ', mutations=[', String.Join(', ', stacks.ToArray()), ']) = ',
            sellValue:0:2, '₵');
end.
