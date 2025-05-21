program PlantSellCalculator;

const
  MaxCrops = 50;
  MaxMutations = 15;

type
  TStringArray = array[1..MaxCrops] of string;
  TRealArray = array[1..MaxCrops] of Real;
  TMutationArray = array[1..MaxMutations] of string;
  TMultiplierArray = array[1..MaxMutations] of Real;

var
  Crops: TStringArray;
  CropValues: TRealArray;
  Mutations: TMutationArray;
  MutationMultipliers: TMultiplierArray;
  CropCount, MutationCount: Integer;

function ToLower(const S: string): string;
var
  I: Integer;
  LowerStr: string;
begin
  LowerStr := S;
  for I := 1 to Length(LowerStr) do
    if (LowerStr[I] >= 'A') and (LowerStr[I] <= 'Z') then
      LowerStr[I] := Chr(Ord(LowerStr[I]) + 32);
  ToLower := LowerStr;
end;

function GetCropValue(CropName: string): Real;
var
  I: Integer;
  Value: Real;
begin
  Value := -1;
  for I := 1 to CropCount do
    if ToLower(Crops[I]) = ToLower(CropName) then
    begin
      Value := CropValues[I];
      Break;
    end;
  GetCropValue := Value;
end;

function GetMutationMultiplier(const Name: string): Real;
var
  I: Integer;
  Mult: Real;
begin
  Mult := -1;
  for I := 1 to MutationCount do
    if ToLower(Mutations[I]) = ToLower(Name) then
    begin
      Mult := MutationMultipliers[I];
      Break;
    end;
  GetMutationMultiplier := Mult;
end;

function CalculateTotalMultiplier(const List: string): Real;
var
  StartPos, EndPos: Integer;
  MutName: string;
  AdditiveMultiplier: Real;
  RainbowMult, GoldenMult: Real;
  BaseMult: Real;
  Factor: Real;
  FinalMult: Real;
begin
  AdditiveMultiplier := 0.0;
  RainbowMult := 1.0;
  GoldenMult := 1.0;
  StartPos := 1;
  while StartPos <= Length(List) do
  begin
    while (StartPos <= Length(List)) and (List[StartPos] = ' ') do
      Inc(StartPos);
    EndPos := StartPos;
    while (EndPos <= Length(List)) and (List[EndPos] <> ',') do
      Inc(EndPos);
    MutName := Copy(List, StartPos, EndPos - StartPos);
    MutName := ToLower(MutName);
    if MutName <> '' then
    begin
      Factor := GetMutationMultiplier(MutName);
      if Factor < 0 then
      begin
        Writeln('Unknown mutation: ', MutName);
        Exit;
      end;
      if MutName = 'rainbow' then
        RainbowMult := Factor
      else if MutName = 'golden' then
        GoldenMult := Factor
      else
        AdditiveMultiplier := AdditiveMultiplier + (Factor - 1);
    end;
    StartPos := EndPos + 1;
  end;

  BaseMult := 1.0 + AdditiveMultiplier;
  FinalMult := BaseMult * RainbowMult * GoldenMult;
  CalculateTotalMultiplier := FinalMult;
end;

procedure InitializeData;
begin
  CropCount := 50;

  Crops[1]  := 'Carrot';           CropValues[1]  := 18;
  Crops[2]  := 'Strawberry';       CropValues[2]  := 14;
  Crops[3]  := 'Blueberry';        CropValues[3]  := 18;
  Crops[4]  := 'Orange Tulip';     CropValues[4]  := 767;
  Crops[5]  := 'Tomato';           CropValues[5]  := 27;
  Crops[6]  := 'Corn';             CropValues[6]  := 36;
  Crops[7]  := 'Daffodil';         CropValues[7]  := 903;
  Crops[8]  := 'Watermelon';       CropValues[8]  := 2708;
  Crops[9]  := 'Pumpkin';          CropValues[9]  := 3700;
  Crops[10] := 'Apple';            CropValues[10] := 248;
  Crops[11] := 'Bamboo';           CropValues[11] := 3610;
  Crops[12] := 'Coconut';          CropValues[12] := 361;
  Crops[13] := 'Cactus';           CropValues[13] := 3068;
  Crops[14] := 'Dragon Fruit';     CropValues[14] := 4287;
  Crops[15] := 'Mango';            CropValues[15] := 5866;
  Crops[16] := 'Grape';            CropValues[16] := 7085;
  Crops[17] := 'Mushroom';         CropValues[17] := 136278;
  Crops[18] := 'Pepper';           CropValues[18] := 7220;
  Crops[19] := 'Cacao';            CropValues[19] := 9928;
  Crops[20] := 'Beanstalk';        CropValues[20] := 18050;
  Crops[21] := 'Pineapple';        CropValues[21] := 1805;
  Crops[22] := 'Peach';            CropValues[22] := 271;
  Crops[23] := 'Raspberry';        CropValues[23] := 90;
  Crops[24] := 'Papaya';           CropValues[24] := 1000;
  Crops[25] := 'Banana';           CropValues[25] := 1579;
  Crops[26] := 'Passion Fruit';    CropValues[26] := 3204;
  Crops[27] := 'Soul Fruit';       CropValues[27] := 3000;
  Crops[28] := 'Cursed Fruit';     CropValues[28] := 1650;
  Crops[29] := 'Chocolate Carrot'; CropValues[29] := 16500;
  Crops[30] := 'Red Lollipop';     CropValues[30] := 70000;
  Crops[31] := 'Candy Sunflower';  CropValues[31] := 145000;
  Crops[32] := 'Easter Eggs';      CropValues[32] := 4513;
  Crops[33] := 'Candy Blossom';    CropValues[33] := 93567;

  // Angry Plant Event
  Crops[34] := 'Cranberry';        CropValues[34] := 1805;
  Crops[35] := 'Durian';           CropValues[35] := 4513;
  Crops[36] := 'Eggplant';         CropValues[36] := 6769;
  Crops[37] := 'Venus Fly Trap';   CropValues[37] := 17000;  // Approximate value
  Crops[38] := 'Lotus';            CropValues[38] := 20000;  // Approximate value

  // Lunar Glow Event
  Crops[39] := 'Nightshade';       CropValues[39] := 2000;
  Crops[40] := 'Glowshroom';       CropValues[40] := 175;    // Average between 150-200
  Crops[41] := 'Mint';             CropValues[41] := 5500;   // Approximate
  Crops[42] := 'Moonflower';       CropValues[42] := 8500;   // Average between 7000-10000
  Crops[43] := 'Starfruit';        CropValues[43] := 15538;
  Crops[44] := 'Moonglow';         CropValues[44] := 18000;  // Approximate
  Crops[45] := 'Moon Blossom';     CropValues[45] := 45125;

  // Blood Moon Shop
  Crops[46] := 'Blood Banana';     CropValues[46] := 5415;
  Crops[47] := 'Moon Melon';       CropValues[47] := 16245;

  // Other Seeds
  Crops[48] := 'Pear';             CropValues[48] := 500;
  Crops[49] := 'Lemon';            CropValues[49] := 500;
  Crops[50] := 'Cherry Blossom';  CropValues[50] := 0; // Value unknown or N/A

  MutationCount := 15;
  Mutations[1]  := 'Wet';        MutationMultipliers[1]  := 2;
  Mutations[2]  := 'Chilled';    MutationMultipliers[2]  := 2;
  Mutations[3]  := 'Moonlit';    MutationMultipliers[3]  := 2;
  Mutations[4]  := 'Chocolate';  MutationMultipliers[4]  := 2;
  Mutations[5]  := 'Bloodlit';   MutationMultipliers[5]  := 4;
  Mutations[6]  := 'Frozen';     MutationMultipliers[6]  := 10;
  Mutations[7]  := 'Golden';     MutationMultipliers[7]  := 20;
  Mutations[8]  := 'Zombified';  MutationMultipliers[8]  := 25;
  Mutations[9]  := 'Rainbow';    MutationMultipliers[9]  := 50;
  Mutations[10] := 'Shocked';    MutationMultipliers[10] := 100;
  Mutations[11] := 'Celestial';  MutationMultipliers[11] := 120;
  Mutations[12] := 'Disco';      MutationMultipliers[12] := 125;
end;

var
  PlantName, MutationInput, QuantityInput, AgainInput: string;
  BaseValue, TotalMultiplier, TotalValue: Real;
  Quantity, Code: Integer;

begin
  InitializeData;
  repeat
    Write('Enter plant name: ');
    ReadLn(PlantName);
    BaseValue := GetCropValue(PlantName);
    if BaseValue < 0 then
    begin
      Writeln('Unknown plant.');
      Continue;
    end;

    Write('Enter mutations (comma-separated, or blank): ');
    ReadLn(MutationInput);
    if MutationInput = '' then
      TotalMultiplier := 1.0
    else
      TotalMultiplier := CalculateTotalMultiplier(MutationInput);

    Write('Enter quantity: ');
    ReadLn(QuantityInput);
    Val(QuantityInput, Quantity, Code);
    if (Code <> 0) or (Quantity < 0) then
    begin
      Writeln('Invalid quantity.');
      Continue;
    end;

    TotalValue := BaseValue * TotalMultiplier * Quantity;
    Writeln('Total sell value: ', TotalValue:0:2, '₵');

    Write('Do another calculation? (y/n): ');
    ReadLn(AgainInput);
  until ToLower(AgainInput) <> 'y';
end.
