local mainMod = "SUPER"

-- Move the current workspace to the left / right monitor
hl.bind(mainMod .. " + ALT + Left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + ALT + Right", hl.dsp.workspace.move({ monitor = "r" }))
