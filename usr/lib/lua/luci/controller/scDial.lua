module("luci.controller.scDial", package.seeall)

function index()
        entry({"admin" , "scDial"}, cbi("scDial"), _("swpuMobile"), 100)
end
