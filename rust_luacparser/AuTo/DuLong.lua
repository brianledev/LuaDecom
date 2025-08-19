local self = AuToDulong
local AuToDulong = Map.AuToDulong or {}
Map.AuToDulong = AuToDulong
local nState1 = 0
local nBen = 1
AuToDulong.Start = nil
local tbTempItem 		= Ui.tbLogic.tbTempItem;
local uiYoulongmibao 	= Ui:GetClass("youlongmibao");
local DiKhongAnhOi = 1
AuToDulong.tbDate = AuToDulong.tbDate or {};
function AuToDulong:Switch()
	if nState1 == 0 then
		AuToDulong:BatDauTime()
	else
		AuToDulong:KetThuc()
	end
end
function AuToDulong:BatDauTime()
	AuToDulong.Start = Timer:Register(Env.GAME_FPS * 0.5, AuToDulong.OnTime, AuToDulong)
	nState1 = 1
	UiManager:OpenWindow("UI_INFOBOARD", "<color=White><bclr=123,0,182>Bật AuTo du long--NguyễnTNam<color>")
end
function AuToDulong:KetThuc()
	Timer:Close(AuToDulong.Start)
	AuToDulong.Start = nil
	nState1 = 0
	UiManager:OpenWindow("UI_INFOBOARD", "<color=White><bclr=123,0,182>Tắt--NguyễnTNam<color>")
	AuToDulong:Refresh()
end
function AuToDulong:OnTime()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 or Map.ScriptAuto:IsMapLoading() then
		return
	end	
	local nMap = me.GetMapTemplateId()
	local uiGutAward = Ui(Ui.UI_YOULONGMIBAO)
	local nState = 0;
	local nChienThan =  Map.HuyHoang.FindNPCName("Thiên Thiên", 50)
	if nMap > 1692 or nMap < 1665 then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", 1)
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
			return
		else
			Map.HuyHoang:UseItem(18, 1, 524, 1)
		end
	end
	-- AuToDulong:CheckUsefulItem()
	if UiManager:WindowVisible(Ui.UI_YOULONGMIBAO) == 1 then
		if uiGutAward.nState == 1 then
			uiGutAward.OnButtonClick(uiGutAward,"BtnGetAward");
		elseif uiGutAward.nState == 2 then
			AuToDulong:CheckUsefulItem()
			-- me.Msg(""..AuToDulong:CheckUsefulItem().."")
			if AuToDulong:CheckUsefulItem() == 1 then
				uiGutAward.OnButtonClick(uiGutAward,"BtnContinue");
			else
				uiGutAward.OnButtonClick(uiGutAward,"BtnRestart");
			end
		elseif uiGutAward.nState == 3 then
			uiGutAward.OnButtonClick(uiGutAward,"BtnRestart");
		elseif uiGutAward.nState == 4 then
			if AuToDulong:GetAward() == 1 then
				uiGutAward.OnButtonClick(uiGutAward,"BtnConfirmAward");
			else
				uiGutAward.OnButtonClick(uiGutAward,"BtnChangeCoin");
			end
			nState = 1;
		end
	else
		if nChienThan and DiKhongAnhOi == 1 then
			me.CallServerScript({"ApplyYoulongmibaoRestart"});			
			AutoAi.SetTargetIndex(nChienThan.nIndex)
			DiKhongAnhOi = 0
		end
	end

end
function AuToDulong:CheckUsefulItem()
	local tbItemList = {};
	local tbItemObjList = {};
	local uiYoulongmibao = Ui(Ui.UI_YOULONGMIBAO)
	local nNam = 0
	local nNam1 = 0
	local nTraveGiaTri = 0
	for i = 1, uiYoulongmibao.GRID_COUNT - 1 do
		if uiYoulongmibao.tbGridCont[i] and uiYoulongmibao.tbGridCont[i]:GetObj() then
			local pItem = uiYoulongmibao.tbGridCont[i]:GetObj().pItem;
			if pItem then
				local szId = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel);
				tbItemList[szId] = (tbItemList[szId] or 0) + 1;
				tbItemObjList[szId] = pItem
				if string.find(pItem.szName,"Tiểu Du Long Lệnh") then
					nNam = nNam + 1
				end
				if string.find(pItem.szName,"Du Long Danh Vọng Lệnh") then
					nNam1 = nNam1 + 1
				end
			end
		end
	end
	if nNam >= 2 then
		nTraveGiaTri = 1
	end
	if nNam1 >= 1 then
		nTraveGiaTri = 1
	end
	if nNam + nNam1 >= 2 then
		nTraveGiaTri = 1
	end
	return nTraveGiaTri
end
function AuToDulong:GetAward()
	local pItem = Ui(Ui.UI_YOULONGMIBAO).tbGridCont[26]:GetObj().pItem;
	if pItem then
		-- if string.find(pItem.szName,"Tiểu Du Long Lệnh") then
			-- return 1
		-- end
		-- if string.find(pItem.szName,"Du Long Danh Vọng Lệnh") then
			-- return 1
		-- end
		-- if pItem.szName == "Hòa Thị Ngọc" then
			-- return 1
		-- end	
		if pItem.szName == "Trứng Du Long" then
			return 1
		end
		if pItem.szName == "Du Long Tu Luyện Phù" then
			return 1
		end
	end
	return 0
end
function AuToDulong:Refresh()
	local fnDoScript = function(szFilePath)
	local szFileData = KFile.ReadTxtFile(szFilePath)
		assert(loadstring(szFileData, szFilePath))()
	end
	fnDoScript("\\interface2\\AuTo\\DuLong.lua")
	me.Msg("<color=White><bclr=123,0,182>Tắt And Load  -Thương Trang 44 <pic=49>")
end

function AuToDulong.ChonAiTDC(szTag)
	if tonumber(szTag) == 1 then
		AuToDulong:Switch()
	elseif tonumber(szTag) == 2 then
		AuToDulong:LuuTenAccChinh()
	elseif tonumber(szTag) == 3 then
	DeleteLocalFile("C:\\TrangThaiXe.txt")
	DeleteLocalFile("C:\\DocFile.txt")
	DeleteLocalFile("C:\\TheoSauSanBox.txt")
		me.Msg("Xóa File")
	end
end
function AuToDulong:ChonDoiEvent()
	local szMsg = "<color=Green>Tool Hoạt Động <enter>NguyễnThừaNam"
	local tbOpt = {
		{
			"Đi Du Long",
			AuToDulong.ChonAiTDC,
			"1"
		},
		{
			"Lưu Chủ Key Sandboxie",
			AuToDulong.ChonAiTDC,
			"2"
		},
		{
			"Fix Lỗi San Box",
			AuToDulong.ChonAiTDC,
			"3"
		},
		{
			"Hủy"
		}
	}
	Dialog:Say(szMsg, tbOpt)
end
function AuToDulong:LuuTenAccChinh()
	if Map.Sandboxie.Leader == "" then
		Map.Libraries:saveFileIni("\\interface2\\setting\\KeySanBox.ini","NguyenThuaNam","TenKeySanBox",me.szName)
		me.Msg("<color=White><bclr=123,0,182>Lưu Tên Key SanBox Thành Công Không Nên Lưu Acc Ở SanBox<pic=49>")
		Map.Sandboxie.Leader = me.szName
		UiManager:OpenWindow("UI_INFOBOARD", "<color=White><bclr=123,0,182>Lưu Tên Chủ Key SanBox Thành Công<color>")
		return
	end
	me.Msg("<color=White><bclr=123,0,182>Đã Có Chủ Key Ở San Box")
	local tbMsg = {}
	if szDataSave ~= "" then
		tbMsg.szMsg = string.format("%s%s", "Bạn Có Muốn Thay Tên Chủ Key Sandboxie", "")
		tbMsg.nOptCount = 2
		function tbMsg:Callback(nOptIndex)
			if nOptIndex == 1 then
			elseif nOptIndex == 2 then
				Map.Libraries:saveFileIni("\\interface2\\setting\\KeySanBox.ini","NguyenThuaNam","TenKeySanBox",me.szName)
				me.Msg("<color=White><bclr=123,0,182>Thay Đổi Chủ Key Thành Công-Out Vào Lại")
				Map.Sandboxie.Leader = me.szName
				UiManager:OpenWindow("UI_INFOBOARD", "<color=White><bclr=123,0,182>Thay Đổi Chủ Key Thành Công Out Vào Lại<color>")
			end
		end
		UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg)
		return
	end
end
UiShortcutAlias.tbDefault["AuToDulong"]={
	tbKey		= {"Shift+N", "Shift+N"},
	szDesc		= "",
	tbExcute	= {"Map.AuToDulong:ChonDoiEvent()"},
	nExcute		= UiShortcutAlias.emDETAIL_EXCUTE_STRING,
	nState		= UiShortcutAlias.emKSTATE_INGAME,
	szBelong	= "",
}
UiShortcutAlias:RegisterAlias(1)