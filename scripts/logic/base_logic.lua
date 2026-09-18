-- this is the file to put all your custom logic functions into.
-- if you dont want to use the json based logic you can switch to a graph-based logic method.
-- the needed functions for that are in `/scripts/logic/graph_logic/logic_main.lua`.



-- function <name> (<parameters if needed>)
--     <actual code>
--     <indentations are just for readability>
-- end
--
-- (count_Permits moved below: no item carries a bare 'Permit' code, so the old ProviderCountForCode('Permit') always returned 0)

-- Every species permit code in items.json (generated 2026-09-18 from items/items.json; regenerate if permits change).
PERMIT_CODES = {
    "Permit:Aardvark",
    "Permit:Africanbuffalo",
    "Permit:Africanleopard",
    "Permit:Africansavannahelephant",
    "Permit:Africanwilddog",
    "Permit:Aldabragianttortoise",
    "Permit:Amazoniangiantcentipede",
    "Permit:Americanbison",
    "Permit:Bactriancamel",
    "Permit:Bairdstapir",
    "Permit:Bengaltiger",
    "Permit:Blackandwhiteruffedlemur",
    "Permit:Blackwildebeest",
    "Permit:Boaconstrictor",
    "Permit:Bongo",
    "Permit:Bonobo",
    "Permit:Borneanorangutan",
    "Permit:Braziliansalmonpinktarantula",
    "Permit:Brazilianwanderingspider",
    "Permit:Cheetah",
    "Permit:Chinesepangolin",
    "Permit:Collaredpeccary",
    "Permit:Commondeathadder",
    "Permit:Commonostrich",
    "Permit:Commonwarthog",
    "Permit:Easternbrownsnake",
    "Permit:Formosanblackbear",
    "Permit:Galapagosgianttortoise",
    "Permit:Gemsbok",
    "Permit:Gharial",
    "Permit:Giantburrowingcockroach",
    "Permit:Giantdeserthairyscorpion",
    "Permit:Giantforestscorpion",
    "Permit:Giantpanda",
    "Permit:Gianttigerlandsnail",
    "Permit:Gilamonster",
    "Permit:Goldenpoisonfrog",
    "Permit:Goliathbeetle",
    "Permit:Goliathbirdeater",
    "Permit:Goliathfrog",
    "Permit:Greaterflamingo",
    "Permit:Greeniguana",
    "Permit:Grizzlybear",
    "Permit:Himalayanbrownbear",
    "Permit:Hippopotamus",
    "Permit:Indianelephant",
    "Permit:Indianpeafowl",
    "Permit:Indianrhinoceros",
    "Permit:Japanesemacaque",
    "Permit:Lehmannpoisonfrog",
    "Permit:Lesserantilleaniguana",
    "Permit:Malabarrose",
    "Permit:Mandrill",
    "Permit:Mexicanredkneetarantula",
    "Permit:Nilemonitor",
    "Permit:Nyala",
    "Permit:Okapi",
    "Permit:Plainszebra",
    "Permit:Pronghornantelope",
    "Permit:Puffadder",
    "Permit:Reddeer",
    "Permit:Redpanda",
    "Permit:Redruffedlemur",
    "Permit:Reticulatedgiraffe",
    "Permit:Ringtailedlemur",
    "Permit:Sableantelope",
    "Permit:Saltwatercrocodile",
    "Permit:Siberiantiger",
    "Permit:Snowleopard",
    "Permit:Spottedhyena",
    "Permit:Springbok",
    "Permit:Timberwolf",
    "Permit:Titanbeetle",
    "Permit:WestAfricanlion",
    "Permit:Westernchimpanzee",
    "Permit:Westerndiamondbackrattlesnake",
    "Permit:Westernlowlandgorilla",
    "Permit:Yellowanaconda"
}

-- Number of permits currently owned (any species). Milestone rules use "$has_permits|N" =
-- rules.py HasGroup('Permits', N).
function count_Permits()
    local n = 0
    for _, code in ipairs(PERMIT_CODES) do
        if Tracker:ProviderCountForCode(code) > 0 then
            n = n + 1
        end
    end
    return n
end

function has_permits(n)
    return count_Permits() >= tonumber(n)
end
