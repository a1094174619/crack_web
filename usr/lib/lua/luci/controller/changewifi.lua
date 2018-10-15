module("luci.controller.changewifi", package.seeall)

function index()
        entry({"admin" , "changewifi"}, cbi("changewifi"), _("修改wifi信息"), 100)
end