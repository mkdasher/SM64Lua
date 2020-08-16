MoreMaths = {
	tab={["0"]="0000",["1"]="0001",["2"]="0010",["3"]="0011",
         ["4"]="0100",["5"]="0101",["6"]="0110",["7"]="0111",
         ["8"]="1000",["9"]="1001",["a"]="1010",["b"]="1011",
         ["c"]="1100",["d"]="1101",["e"]="1110",["f"]="1111",
         ["A"]="1010",["B"]="1011",["C"]="1100",["D"]="1101",["E"]="1110",["F"]="1111"}
}

function MoreMaths.DecodeDecToFloat(input)
	local str = string.format("%x", input)
    local str1=""
    local a,z
    for z=1,string.len(str) do
        a=string.sub(str,z,z)
        str1=str1..MoreMaths.tab[a]
    end
    local pm=string.sub(str1,1,1)
    local exp=string.sub(str1,2,9)
    local c=tonumber(exp,2)-127
    local p=math.pow(2,c)
    local man="1"..string.sub(str1,10,32)
    local x=0
    for z=1,string.len(man) do
        if string.sub(man,z,z)=="1" then
            x=x+p
        end
        p=p/2
    end
    if pm=="1" then
        x= -x
    end    
    return(x)
end

function MoreMaths.Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end