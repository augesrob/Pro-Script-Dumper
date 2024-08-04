-- Name: Pathfinder
-- Path: game:GetService("Workspace").CustomerAIPaths.Pathfinder
-- Class: ModuleScript
-- Exploit: Wave 
-- Time to decompile: 0.46323340001981705 seconds

-- decompiled using medal by alpaca and jujhar

local v1 = {}
local v_u_2 = nil
function BuildNodes() -- line: 46
    -- upvalues: (ref) v_u_2
    local v3 = workspace.CustomerAIPaths
    local v4 = {}
    local v5 = {}
    for _, v6 in ipairs(v3:GetChildren()) do
        if v6:IsA("Vector3Value") then
            local v7 = {
                ["Position"] = v6.Value,
                ["Neighbors"] = {},
                ["F"] = 0,
                ["G"] = 0,
                ["H"] = 0,
                ["Parent"] = nil
            }
            table.insert(v4, v7)
            v5[v6] = v7
        end
    end
    for _, v8 in ipairs(v3:GetChildren()) do
        if v8:IsA("Vector3Value") then
            local v9 = v5[v8]
            for _, v10 in ipairs(v8:GetChildren()) do
                if v10:IsA("ObjectValue") then
                    local v11 = v5[v10.Value]
                    local v12 = v9.Neighbors
                    table.insert(v12, v11)
                    local v13 = v11.Neighbors
                    table.insert(v13, v9)
                end
            end
        end
    end
    v3:Destroy()
    v_u_2 = v4
end
function FindNearestNode(p14) -- line: 83
    -- upvalues: (ref) v_u_2
    local v15 = (1 / 0)
    local v16 = nil
    for _, v17 in ipairs(v_u_2) do
        local v18 = (p14 - v17.Position).Magnitude
        if v18 < v15 then
            v16 = v17
            v15 = v18
        end
    end
    return v16
end
function v1.FindPath(_, p19, p20) -- line: 95
    -- upvalues: (ref) v_u_2
    local v21 = v_u_2
    assert(v21, "Pathfinder not yet initialized")
    local v22 = {}
    local v23 = false
    local v24 = FindNearestNode(p19)
    local v25 = FindNearestNode(p20)
    local v26 = {
        [v24] = true
    }
    local v27 = {}
    while next(v26) do
        local v28 = (1 / 0)
        local v29 = nil
        for v30 in pairs(v26) do
            if v30.F < v28 then
                v28 = v30.F
                v29 = v30
            end
        end
        v26[v29] = nil
        v27[v29] = true
        if v29 == v25 then
            v23 = true
            break
        end
        for _, v31 in ipairs(v29.Neighbors) do
            if not v27[v31] then
                if v26[v31] then
                    if v31.G < v29.G then
                        v31.Parent = v29
                        v31.G = v29.G + (v31.Position - v29.Position).Magnitude
                        v31.F = v31.G + v31.H
                    end
                else
                    v26[v31] = true
                    v31.Parent = v29
                    v31.G = v29.G + (v31.Position - v29.Position).Magnitude
                    v31.H = (v31.Position - v25.Position).Magnitude
                    v31.F = v31.G + v31.H
                end
            end
        end
    end
    if v23 then
        while v25 do
            local v32 = v25.Position
            table.insert(v22, 1, v32)
            v25 = v25.Parent
        end
    end
    for v33 in pairs(v26) do
        v33.F = 0
        v33.G = 0
        v33.H = 0
        v33.Parent = nil
    end
    for v34 in pairs(v27) do
        v34.F = 0
        v34.G = 0
        v34.H = 0
        v34.Parent = nil
    end
    return v23 and v22 and v22 or nil
end
function v1.Init(_) -- line: 184
    BuildNodes()
end
return v1