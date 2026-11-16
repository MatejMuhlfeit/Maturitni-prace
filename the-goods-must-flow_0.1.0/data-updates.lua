-- Projít úplně všechny recepty, které ve hře existují
for name, recipe in pairs(data.raw.recipe) do
  -- Zkontrolovat, zda jde o recept do pece (smelting)
  -- (V novém Factoriu 2.0+ se kontroluje tabulka categories, pro jistotu ale ověříme i starší zápis)
  local is_smelting = false

  if recipe.categories then
    for _, cat in pairs(recipe.categories) do
      if cat == "smelting" then
        is_smelting = true
        break
      end
    end
  elseif recipe.category == "smelting" then
    is_smelting = true
  end

  -- Pokud jde o recept do pece a má přesně 1 vstupní surovinu (čistě ruda -> plát)
  if is_smelting and recipe.ingredients and #recipe.ingredients == 1 then
    -- Vyloučíme kamennou cihlu (stone-brick), pokud ji chcete nechat na 2 kamenech,
    -- nebo tento řádek smažte, pokud má stát 5 kamenů i cihla:
    if name ~= "stone-brick" then
      recipe.ingredients[1].amount = 5
    end
  end
end