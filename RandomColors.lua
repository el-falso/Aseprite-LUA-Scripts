-- Copyright (C) 2018 eL-Falso
--
-- This file is released under the terms of the MIT license.
-- Read LICENSE.txt for more information.

function case(letters)
    for _,v in ipairs(letters) do
        if v == ColorMode.GRAYSCALE or v == ColorMode.INDEXED then
            local cGrey = math.random(data.grmin, data.grmax)
            c = app.pixelColor.graya(cGrey, 255)
        elseif v == ColorMode.RGB then
            local cRed = math.random(data.rmin, data.rmax)
            local cGreen = math.random(data.gmin, data.gmax)
            local cBlue = math.random(data.bmin, data.bmax)
            c = app.pixelColor.rgba(cRed, cGreen, cBlue, 255)
        end
    end
end 

function inBounds()
    local imgSrc = app.activeImage
    if imgSrc.colorMode == ColorMode.GRAYSCALE or imgSrc.colorMode == ColorMode.INDEXED then
        if data.grmin <= data.grmax then
            return true
        else
            app.alert{title="Bounds - Error", text="Incorrect bounds!"}
            return false
        end
    elseif imgSrc.colorMode == ColorMode.RGB then
        if data.rmin <= data.rmax and data.gmin <= data.gmax and data.bmin <= data.bmax then
            return true
        else
            app.alert{title="Bounds - Error", text="Incorrect bounds!"}
            return false
        end
    end
end

do
    local sprSrc = app.activeSprite
    local imgSrc = app.activeImage

    if sprSrc ~= nil then
        if imgSrc ~= nil then
                
            local dlg = Dialog("Random Colors")
            if imgSrc.colorMode == ColorMode.GRAYSCALE or imgSrc.colorMode == ColorMode.INDEXED then
                dlg:separator{ id="string", label="string", text="Gray Range" }
                dlg:slider{ id="grmin", label="Min:", min=0, max=255, value=0 }
                dlg:slider{ id="grmax", label="Max:", min=0, max=255, value=255 }
                dlg:button{ id="ok", text="OK" }
                dlg:button{ id="cancel", text="Cancel" }
            elseif imgSrc.colorMode == ColorMode.RGB then
                dlg:separator{ id="string", label="string", text="Red Range" }
                dlg:slider{ id="rmin", label="Min:", min=0, max=255, value=0 }
                dlg:slider{ id="rmax", label="Max:", min=0, max=255, value=255 }
                dlg:separator{ id="string", label="string", text="Green Range" }
                dlg:slider{ id="gmin", label="Min:", min=0, max=255, value=0 }
                dlg:slider{ id="gmax", label="Max:", min=0, max=255, value=255 }
                dlg:separator{ id="string", label="string", text="Blue Range" }
                dlg:slider{ id="bmin", label="Min:", min=0, max=255, value=0 }
                dlg:slider{ id="bmax", label="Max:", min=0, max=255, value=255 }
                dlg:button{ id="ok", text="OK" }
                dlg:button{ id="cancel", text="Cancel" }
            end
            dlg:show()
            data = dlg.data

            if inBounds() then 
                for x=0, sprSrc.width
                do
                    for y=0, sprSrc.height
                    do
                        case{imgSrc.colorMode}
                        imgSrc:putPixel(x, y, c)
                    end
                end
            end

        else
            app.alert{title=tostring(imgSrc) .. " - Error", text="No image found on the current layer."}
        end
    else
        app.alert{title=tostring(sprSrc) .. " - Error", text="Create a sprite first."}
    end
end