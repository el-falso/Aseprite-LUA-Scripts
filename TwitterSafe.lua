-- Copyright (C) 2018 eL-Falso
--
-- This file is released under the terms of the MIT license.
-- Read LICENSE.txt for more information.

do
    local pc = app.pixelColor
    local imgSrc = app.activeImage
    if imgSrc ~= nil then
        local imgCopy = imgSrc:clone()
        local c = Color(imgSrc:getPixel(0, 0))
        local c = app.pixelColor.rgba(c.red, c.green, c.blue, 254)
        imgCopy:putPixel(0, 0, c)
        local sprNew = Sprite(imgSrc.width, imgSrc.height)
        local imgDest = app.site.image
        local l = sprNew.layers[1]
        l.name = "TwitterSafe_Layer"
        imgDest:putImage(imgCopy)
        app.alert{title="Action: Complete", text="A new document with a TwitterSafe-Layer was created. Now save it!"}
    else
        app.alert{title=tostring(imgSrc) .. " - Error", text="No image found on the current layer."}
    end
end