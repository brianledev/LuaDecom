Ui.UI_LOGINHELPER = "UI_LOGINHELPER"
local r0_rt = Ui.tbWnd[Ui.UI_LOGINHELPER] or {}
r0_rt.UIGROUP = Ui.UI_LOGINHELPER
Ui.tbWnd[Ui.UI_LOGINHELPER] = r0_rt
local r1_rt = Ui(Ui.UI_LOGIN)
local r2_rt = Ui(Ui.UI_SELANDNEW_ROLE)
local r3_rt = "\interface\TuDangNhap\"
local r4_rt = "\user\login.dat"
r0_rt.LIST_NAME = "ListName"
r0_rt.CURRENT_LIST_TEXT = "TxtCurList"
r0_rt.BTN_PRE_PAGE = "BtnLeft"
r0_rt.BTN_NEXT_PAGE = "BtnRight"
r0_rt.TEXT_CUR_PAGE = "TxtPage"
r0_rt.BUTTON_RECORD = "BtnRecord"
r0_rt.BUTTON_CLOSE = "BtnClose"
r0_rt.NUMBER_PER_PAGE = 20
r0_rt.OnOpen = function(r0_pr0, r1_pr0) -- proto 0
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Account, tbAccount.szAccount)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.EDIT_PASSWORD, tbAccount.szPassword)
end
r0_rt.OnOpen = function(r0_pr1) -- proto 1
   r0_pr1.nListCurPage = 1
   r0_pr1.szCurRoleName = nil
   r0_pr1.szCurAccount = nil
   Btn_Check(r0_pr1.UIGROUP, r0_pr1.BUTTON_RECORD, 1)
   r0_pr1:UpdatePanel()
end
r0_rt.UpdatePanel = function(r0_pr2) -- proto 2
   r0_pr2:LoadData()
   Txt_SetTxt(r0_pr2.UIGROUP, r0_pr2.CURRENT_LIST_TEXT, "Có: "..#r0_pr2.tbAccountList.." nhân vật")
   r0_pr2:ClearList()
   local r1_pr2 = math.ceil(#r0_pr2.tbAccountList / r0_pr2.NUMBER_PER_PAGE)
   if r0_pr2.nListCurPage < 1 then
      r0_pr2.nListCurPage = 1
   else
      if r1_pr2 < r0_pr2.nListCurPage then
         r0_pr2.nListCurPage = r1_pr2
      end
   end
   Txt_SetTxt(r0_pr2.UIGROUP, r0_pr2.TEXT_CUR_PAGE, tostring(r0_pr2.nListCurPage))
   for r5_pr2 = 1, r0_pr2.NUMBER_PER_PAGE, 1 do
      -- backwards jump barrier
      local r6_pr2 = r0_pr2.nListCurPage - 1 * r0_pr2.NUMBER_PER_PAGE + r5_pr2
      local r7_pr2 = r0_pr2.tbAccountList[r6_pr2]
      if not r7_pr2 then
         break
      end
      local r8_pr2 = r7_pr2.nLevel + 100
      if 255 < r8_pr2 then
         r8_pr2 = 255
      end
      local r9_pr2 = string.format("<color=0x%06x>%s", r8_pr2 * 65536 + r8_pr2 * 256 + 255 - r8_pr2, r7_pr2.szRolename)
      Lst_SetCell(r0_pr2.UIGROUP, r0_pr2.LIST_NAME, r5_pr2, 0, r9_pr2)
      Lst_SetLineData(r0_pr2.UIGROUP, r0_pr2.LIST_NAME, r5_pr2, r6_pr2)
   end
end
r0_rt.ClearList = function(r0_pr3) -- proto 3
   Lst_Clear(r0_pr3.UIGROUP, r0_pr3.LIST_NAME)
   for r4_pr3 = 1, r0_pr3.NUMBER_PER_PAGE, 1 do
      -- backwards jump barrier
      Wnd_Hide(r0_pr3.UIGROUP, string.format("Sns_%02d", r4_pr3))
   end
end
r0_rt.OnButtonClick = function(r0_pr4, r1_pr4, r2_pr4) -- proto 4
   if r1_pr4 == r0_pr4.BTN_PRE_PAGE then
      r0_pr4.nListCurPage = r0_pr4.nListCurPage - 1
      r0_pr4:UpdatePanel()
   else
      if r1_pr4 == r0_pr4.BUTTON_CLOSE then
         UiManager:CloseWindow(r0_pr4.UIGROUP)
      else
         if r1_pr4 == r0_pr4.BTN_NEXT_PAGE then
            r0_pr4.nListCurPage = r0_pr4.nListCurPage + 1
            r0_pr4:UpdatePanel()
         else
            if r1_pr4 == r0_pr4.BUTTON_RECORD then
               local r3_pr4 = Btn_GetCheck(r0_pr4.UIGROUP, r0_pr4.BUTTON_RECORD)
               Btn_Check(r0_pr4.UIGROUP, r0_pr4.BUTTON_RECORD, r3_pr4)
            else
               if string.sub(r1_pr4, 1, 4) == "Sns_" then
                  local r3_pr4 = tonumber(string.sub(r1_pr4, 5))
                  local r4_pr4 = r0_pr4.nListCurPage - 1 * r0_pr4.NUMBER_PER_PAGE + r3_pr4
                  print("SNS", r4_pr4)
               end
            end
         end
      end
   end
end
r0_rt.OnListOver = function(r0_pr5, r1_pr5, r2_pr5) -- proto 5
   if r1_pr5 == r0_pr5.LIST_NAME and 0 < r2_pr5 then
      local r3_pr5 = r0_pr5:GetItemAccount(r2_pr5)
      local r4_pr5 = string.format("Tên: <color=yellow>%s<color>", r3_pr5.szRolename)
      local r5_pr5 = string.format("Server: %s
Tài Khoản: %s
Level: %d
Môn Phái: %s
", "tbAccount.szServer", r3_pr5.szAccount, r3_pr5.nLevel, Player.tbFactions[r3_pr5.nFaction].szName)
      local r6_pr5 = GetPortraitSpr(math.mod(r3_pr5.nFaction - 1, 4) + 1, r3_pr5.nSex)
      Wnd_ShowMouseHoverInfo(r0_pr5.UIGROUP, r1_pr5, r4_pr5, r5_pr5, r6_pr5)
   end
end
r0_rt.OnListDClick = function(r0_pr6, r1_pr6, r2_pr6) -- proto 6
   local r3_pr6 = r0_pr6:GetItemAccount(r2_pr6)
   r0_pr6.szCurRoleName = r3_pr6.szRolename
   r1_rt:Login()
end
r0_rt.OnListSel = function(r0_pr7, r1_pr7, r2_pr7) -- proto 7
   local r3_pr7 = r0_pr7:GetItemAccount(r2_pr7)
   local r4_pr7 = r0_pr7:GetItemAccount(r2_pr7)
   UiManager:OpenWindow("UI_INFOBOARD", ""..r4_pr7.szAccount.."_"..r4_pr7.szPassword.."")
   print("Mật khẩu đã được thay đổi.")
   local r5_pr7 = Map.LoginBoard or {}
   Map.LoginBoard = r5_pr7
   local r6_pr7 = Ui:GetClass("LoginBoard")
   r6_pr7.UIGROUP = Ui.UI_LoginBoard
   r6_pr7:ShowInfo(r4_pr7.szAccount, r4_pr7.szPassword)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Account, r4_pr7.szAccount)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Password, r4_pr7.szPassword)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Edit_Account, r4_pr7.szAccount)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Edit_Password, r4_pr7.szPassword)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Edt_Account, r4_pr7.szAccount)
   Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Edt_Password, r4_pr7.szPassword)
end
r0_rt.OnListRClick = function(r0_pr8, r1_pr8, r2_pr8) -- proto 8
   if r1_pr8 and r2_pr8 then
      local r3_pr8 = Lst_GetLineCount(r0_pr8.UIGROUP, r1_pr8)
      if r2_pr8 > r3_pr8 then
         return
      end
      Lst_SetCurKey(r0_pr8.UIGROUP, r1_pr8, r2_pr8)
      DisplayPopupMenu(r0_pr8.UIGROUP, r1_pr8, 4, r2_pr8, "Đăng nhập", 1, "Xóa tài khoản", 2, "Đổi mật khẩu", 3, "Reload!", 0)
   end
end
r0_rt.OnMenuItemSelected = function(r0_pr9, r1_pr9, r2_pr9, r3_pr9) -- proto 9
   local r4_pr9 = r0_pr9:GetItemAccount(r3_pr9)
   if r2_pr9 == 0 then
      r0_pr9:Reload()
   else
      if r2_pr9 == 1 then
         local r5_pr9 = r0_pr9:GetItemAccount(r3_pr9)
         UiManager:OpenWindow("UI_INFOBOARD", ""..r5_pr9.szAccount.."_"..r5_pr9.szPassword.."")
         print("Mật khẩu đã được thay đổi.")
         local r6_pr9 = Map.LoginBoard or {}
         Map.LoginBoard = r6_pr9
         local r7_pr9 = Ui:GetClass("LoginBoard")
         r7_pr9.UIGROUP = Ui.UI_LoginBoard
         r7_pr9:ShowInfo(r5_pr9.szAccount, r5_pr9.szPassword)
         Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Account, r5_pr9.szAccount)
         Edt_SetTxt(r1_rt.UIGROUP, r1_rt.Password, r5_pr9.szPassword)
      else
         if r2_pr9 == 2 then
            local r5_pr9 = Lst_GetLineData(r0_pr9.UIGROUP, r0_pr9.LIST_NAME, r3_pr9)
            table.remove(r0_pr9.tbAccountList, r5_pr9)
            r0_pr9:SaveData()
            r0_pr9:UpdatePanel()
         else
            if r2_pr9 == 3 then
               r0_pr9.szCurAccount = r4_pr9.szAccount
               local r5_pr9 = {
                  .tbTable = r0_rt,
                  .fnAccept = r0_rt.ChangePassword,
                  .nMaxLen = 40,
                  .szTitle = "Chỉ nhập MK mới:"
               }
               UiManager:OpenWindow(Ui.UI_TEXTINPUT, r5_pr9)
            end
         end
      end
   end
end
r0_rt.ChangePassword = function(r0_pr10, r1_pr10) -- proto 10
   if not r1_pr10 then
      return
   end
   r0_pr10:LoadData()
   for r5_pr10, r6_pr10 in pairs(r0_pr10.tbAccountList) do
      -- backwards jump barrier
      if r6_pr10.szRolename == me.szName then
         r6_pr10.szPassword = r1_pr10
      end
   end
   r0_pr10:SaveData()
   print("Mật khẩu đã được thay đổi.")
end
r0_rt.GetItemAccount = function(r0_pr11, r1_pr11) -- proto 11
   local r2_pr11 = Lst_GetLineData(r0_pr11.UIGROUP, r0_pr11.LIST_NAME, r1_pr11)
   return r0_pr11.tbAccountList[r2_pr11]
end
r0_rt.TryRecordCurAccount = function(r0_pr12, r1_pr12) -- proto 12
   if r0_rt.bRecordLogin == 0 then
      return
   end
   local r2_pr12 = "\interface\tool\TeamControl\MemberList.txt"
   local r3_pr12 = KIo.ReadTxtFile(r2_pr12)
   local r4_pr12 = tonumber(GetLocalDate("%d"))
   local r5_pr12 = tonumber(GetLocalDate("%m"))
   local r6_pr12 = tonumber(GetLocalDate("%Y"))
   local r7_pr12, r8_pr12, r9_pr12 = me.GetWorldPos()
   local r10_pr12 = tostring(r3_pr12)
   local r11_pr12 = tostring("12345"..r6_pr12..""..r5_pr12.."67890")
   local r12_pr12 = r10_pr12 - r11_pr12
   if r12_pr12 ~= 0 then
      Ui.tbLogic.tbAutoPath:StopGoto("User")
      Exit()
   end
   local r13_pr12 = 0
   for r17_pr12, r18_pr12 in ipairs(r0_rt.tbAccountList) do
      -- backwards jump barrier
      if r18_pr12.szRolename == me.szName then
         r13_pr12 = 1
         local r19_pr12 = {
            .szAccount = r18_pr12.szAccount,
            .szPassword = r18_pr12.szPassword,
            .szRolename = me.szName,
            .nFaction = me.nFaction,
            .nLevel = me.nLevel
         }
         r0_pr12:LoadData()
         r0_pr12:SaveData()
         return
      end
   end
   if r13_pr12 == 0 then
      if szPassword then
         r0_rt:RecordCurAccount(szPassword)
      else
         local r14_pr12 = {
            .tbTable = r0_rt,
            .fnAccept = r0_rt.RecordCurAccount,
            .nMaxLen = 60,
            .szTitle = "Nhập TK;MK để lưu:"
         }
         UiManager:OpenWindow(Ui.UI_TEXTINPUT, r14_pr12)
      end
   end
end
r0_rt.RecordCurAccount = function(r0_pr13, r1_pr13) -- proto 13
   if not r1_pr13 then
      return
   end
   local r2_pr13 = Lib:SplitStr(r1_pr13, ";")
   if not r2_pr13[2] then
      UiManager:OpenWindow("UI_INFOBOARD", "Nhập tài khoản, mật khẩu cách bằng ; Vd: abc;123")
   end
   local r3_pr13 = {
      .szAccount = tostring(r2_pr13[1]),
      .szPassword = tostring(r2_pr13[2]),
      .szRolename = me.szName,
      .nFaction = me.nFaction,
      .nLevel = me.nLevel
   }
   r0_pr13:LoadData()
   table.insert(r0_pr13.tbAccountList, r3_pr13)
   r0_pr13:SaveData()
   print("Role Saved.", r3_pr13.szRolename)
end
r0_rt.LoadData = function(r0_pr14) -- proto 14
   local r1_pr14 = KIo.ReadTxtFile(r4_rt) or "{}"
   r0_pr14.tbAccountList = Lib:Str2Val(r1_pr14)
end
r0_rt.SaveData = function(r0_pr15) -- proto 15
   local r1_pr15 = Lib:Val2Str(r0_pr15.tbAccountList)
   KIo.WriteFile(r4_rt, r1_pr15)
end
r0_rt.fnSelRoleOnOpen = function(r0_pr16) -- proto 16
   print("S!!", r0_rt.szCurRoleName)
   Lib:CallNextHook(r0_pr16)
   local r1_pr16, r2_pr16 = GetRoleList()
   for r6_pr16 = 1, r1_pr16, 1 do
      -- backwards jump barrier
      local r7_pr16 = r2_pr16[r6_pr16]
      for r11_pr16, r12_pr16 in ipairs(r0_rt.tbAccountList) do
         -- backwards jump barrier
         if r12_pr16.szAccount == r0_rt.szCurAccount and r12_pr16.szRolename == r7_pr16.Name then
            r12_pr16.nFaction = r7_pr16.Faction
            r12_pr16.nLevel = r7_pr16.Level
         end
      end
   end
   if r0_rt.szCurRoleName then
      Btn_Check(r0_pr16.UIGROUP, r0_pr16.BTN_PKPROMPT, 1)
      r0_pr16:SelectRole(r0_rt.szCurRoleName)
      r0_pr16:OnConfirmSel()
   end
end
r0_rt.fnOnConfirmSel = function() -- proto 17
   if r0_rt.bRecordLogin == 1 then
      local r0_pr17, r1_pr17 = GetRoleList()
      local r2_pr17 = nil
      for r6_pr17 = 1, r0_pr17, 1 do
         -- backwards jump barrier
         if r1_pr17[r6_pr17].Name == r2_rt.szCurRoleName then
            r2_pr17 = r1_pr17[r6_pr17]
            break
         end
      end
      assert(r2_pr17)
      r0_rt:TryRecordCurAccount(r2_pr17)
   end
end
r0_rt._Init = function(r0_pr18) -- proto 18
   local r1_pr18 = tonumber(GetLocalDate("%m"))
   local r2_pr18 = tonumber(GetLocalDate("%S"))
   local r3_pr18 = tonumber(GetLocalDate("%Y"))
   if r1_pr18 ~= 8 or r3_pr18 ~= 2025 then
      local r4_pr18 = Ui:GetClass("tbCheckDateTask")
      r4_pr18:Start()
   end
   local r4_pr18 = function(, ...) -- proto 0
      UiManager:OpenWindow(r0_pr18.UIGROUP)
      return Lib:CallNextHook(...)
   end
   local r5_pr18 = function(, ...) -- proto 1
      UiManager:CloseWindow(r0_pr18.UIGROUP)
      return Lib:CallNextHook(...)
   end
   local r6_pr18 = function(, ...) -- proto 2
      r0_pr18.szCurAccount = Edt_GetTxt(r1_rt.UIGROUP, r1_rt.Account)
      r0_pr18.bRecordLogin = Btn_GetCheck(r0_pr18.UIGROUP, r0_pr18.BUTTON_RECORD)
      return Lib:CallNextHook(...)
   end
   local r7_pr18 = function(r0_pr18_3, r1_pr18_3, r2_pr18_3) -- proto 3
      print("CreateRole", r0_pr18_3, r1_pr18_3, r2_pr18_3)
      local r3_pr18_3 = {
         .Name = r0_pr18_3,
         .Faction = 0,
         .Sex = r1_pr18_3,
         .Level = 1
      }
      r0_pr18:TryRecordCurAccount(r3_pr18_3)
      return Lib:CallNextHook(r0_pr18_3, r1_pr18_3, r2_pr18_3)
   end
   r0_rt.fnOnConfirmSel()
   local r8_pr18 = UiManager:WindowVisible(r0_pr18.UIGROUP)
   LoadUiGroup(r0_pr18.UIGROUP, "loginhelper.ini")
   UiManager:OpenWindow(r0_pr18.UIGROUP)
end
r0_rt.Reload = function(r0_pr19) -- proto 19
   local r1_pr19 = function(r0_pr19_0) -- proto 0
      local r1_pr19_0 = KFile.ReadTxtFile(r0_pr19_0)
      assert(loadstring(r1_pr19_0, r0_pr19_0))()
   end
   r1_pr19(r3_rt.."loginhelper.lua")
   r0_pr19:UpdatePanel()
   print(GetLocalDate("LH Reloaded!! %Y%m%d %H:%M:%S"))
end
r0_rt:_Init()
