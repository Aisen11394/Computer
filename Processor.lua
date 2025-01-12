-- Processor.lua
local Processor = {}

Processor.registers = {
    ["R0"] = 0,
    ["R1"] = 0,
    ["R2"] = 0,
    ["R3"] = 0,
    ["PC"] = 0
}

Processor.memory = {}
for i = 0, 1023 do
    Processor.memory[i] = 0
end

function Processor.ALU(operation, a, b)
    if operation == "ADD" then
        return (a + b) & 0xFFFFFFFF
    elseif operation == "SUB" then
        return (a - b) & 0xFFFFFFFF
    elseif operation == "AND" then
        return a & b
    elseif operation == "OR" then
        return a | b
    elseif operation == "XOR" then
        return a ~ b
    elseif operation == "NOT" then
        return ~a & 0xFFFFFFFF
    else
        return 0
    end
end

function Processor.executeInstruction(instruction)
    local opcode = instruction:sub(1, 3)
    local operands = instruction:sub(5)

    if opcode == "ADD" then
        local dest, src1, src2 = operands:match("(%w+), (%w+), (%w+)")
        Processor.registers[dest] = Processor.ALU("ADD", Processor.registers[src1], Processor.registers[src2])
    elseif opcode == "SUB" then
        local dest, src1, src2 = operands:match("(%w+), (%w+), (%w+)")
        Processor.registers[dest] = Processor.ALU("SUB", Processor.registers[src1], Processor.registers[src2])
    elseif opcode == "AND" then
        local dest, src1, src2 = operands:match("(%w+), (%w+), (%w+)")
        Processor.registers[dest] = Processor.ALU("AND", Processor.registers[src1], Processor.registers[src2])
    elseif opcode == "OR" then
        local dest, src1, src2 = operands:match("(%w+), (%w+), (%w+)")
        Processor.registers[dest] = Processor.ALU("OR", Processor.registers[src1], Processor.registers[src2])
    elseif opcode == "XOR" then
        local dest, src1, src2 = operands:match("(%w+), (%w+), (%w+)")
        Processor.registers[dest] = Processor.ALU("XOR", Processor.registers[src1], Processor.registers[src2])
    elseif opcode == "NOT" then
        local dest, src = operands:match("(%w+), (%w+)")
        Processor.registers[dest] = Processor.ALU("NOT", Processor.registers[src], 0)
    elseif opcode == "LDR" then
        local dest, addr = operands:match("(%w+), (%d+)")
        Processor.registers[dest] = Processor.memory[tonumber(addr)]
    elseif opcode == "STR" then
        local src, addr = operands:match("(%w+), (%d+)")
        Processor.memory[tonumber(addr)] = Processor.registers[src]
    elseif opcode == "JMP" then
        local addr = tonumber(operands)
        Processor.registers["PC"] = addr
    else
        print("Неизвестная команда:", opcode)
    end
end

return Processor
