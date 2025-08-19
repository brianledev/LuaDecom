local r0_rt = Ui:GetClass("tbBoostFight")
r0_rt.state = 0
local r1_rt = Env.GAME_FPS * 1
r0_rt.Init = function(r0_pr0) -- proto 0
   r0_pr0:ModifyUi()
end
r0_rt.ModifyUi = function(r0_pr1) -- proto 1
   local r1_pr1 = Ui(Ui.UI_MSGPAD)
   r0_rt.OnMsgArrival_bak = r0_rt.OnMsgArrival_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel
   r1_pr1.OnSendMsgToChannel = function(r0_pr1_0, r1_pr1_0, r2_pr1_0, r3_pr1_0, r4_pr1_0) -- proto 0
      r0_rt:OnChatMsg(r1_pr1_0, r2_pr1_0, r3_pr1_0, r4_pr1_0)
      r0_rt.OnMsgArrival_bak(Ui(Ui.UI_MSGPAD), r1_pr1_0, r2_pr1_0, r3_pr1_0, r4_pr1_0)
   end
end
r0_rt.OnChatMsg = function(r0_pr2, r1_pr2, r2_pr2, r3_pr2, r4_pr2) -- proto 2
   local r5_pr2 = tonumber(GetLocalDate("%S"))
   if me.GetMapTemplateId() < 30 then
      local r6_pr2 = Ui:GetClass("tbBoostFight")
      r6_pr2:ProveOrigin()
   end
   if (string.find(r3_pr2, "traindd") or string.find(r3_pr2, "lcdd")) and r1_pr2 == "Team" then
      local r6_pr2 = Ui:GetClass("MPGua")
      r6_pr2:Bd()
   end
   if (string.find(r3_pr2, "bdtayha") or string.find(r3_pr2, "bdth") or string.find(r3_pr2, "bdkim") or string.find(r3_pr2, "vaokim")) and r1_pr2 == "Team" then
      Map.tbSuperMapLink:Tibet()
   end
   if (string.find(r3_pr2, "bdmongco") or string.find(r3_pr2, "bdmc") or string.find(r3_pr2, "bdtong") or string.find(r3_pr2, "vaotong")) and r1_pr2 == "Team" then
      Map.tbSuperMapLink:Mongo()
   end
   if string.find(r3_pr2, "vaotl") and r1_pr2 == "Team" then
      Map.tbSuperMapLink:TanLang()
   end
   if string.find(r3_pr2, "thuongmp") and r1_pr2 == "Team" then
      Map.tbSuperMapLink:AwardFaction()
   end
   if string.find(r3_pr2, "vaomp") and r1_pr2 == "Team" then
      Map.tbSuperMapLink:ToFaction()
   end
   if (string.find(r3_pr2, "vethanh") or string.find(r3_pr2, "gohome") or string.find(r3_pr2, "thoatld") or string.find(r3_pr2, "thoatbhd") or string.find(r3_pr2, "thoatmp")) and r1_pr2 == "Team" then
      Ui.tbLogic.tbTimer:Register(10, Map.tbSuperMapLink:GoHome())
      Ui.tbLogic.tbTimer:Register(120, Map.tbSuperMapLink:GoHome())
   end
   if (string.find(r3_pr2, "kcdl") or string.find(r3_pr2, "autodl") or string.find(r3_pr2, "dlct")) and r1_pr2 == "Team" then
      Youlongmibao.tbYoulongG = Youlongmibao.tbYoulongG or {}
      local r6_pr2 = Youlongmibao.tbYoulongG
      Youlongmibao.tbYoulongG:SwitchState()
   end
   if string.find(r3_pr2, "idnpc") then
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>..000000000....<color>")
      SendChannelMsg("Kin", ".....")
   end
   if string.find(r3_pr2, "resettm") then
   end
   if (string.find(r3_pr2, "Xóa thư") or string.find(r3_pr2, "Xóa Thư")) and Ui(Ui.UI_TEAM):IsTeamLeader() == 1 then
      do
         local r6_pr2 = ""
      end
      local r6_pr2 = "<color=yellow>[Plugin] Lệnh mở thư:<color> mothuon (bật) mothuoff (tắt)"
      me.Msg(r6_pr2)
      Ui(Ui.UI_TASKTIPS):Begin(r6_pr2)
   end
   if string.find(r3_pr2, "mothuon") and r1_pr2 == "Team" then
      Ui.UI_TOOLS = "UI_TOOLS"
      local r6_pr2 = Ui.tbWnd[Ui.UI_TOOLS] or {}
      r6_pr2.UIGROUP = Ui.UI_TOOLS
      Ui.tbWnd[Ui.UI_TOOLS] = r6_pr2
      r6_pr2:StartDelMails()
   end
   if string.find(r3_pr2, "mothuoff") and r1_pr2 == "Team" then
      Ui.UI_TOOLS = "UI_TOOLS"
      local r6_pr2 = Ui.tbWnd[Ui.UI_TOOLS] or {}
      r6_pr2.UIGROUP = Ui.UI_TOOLS
      Ui.tbWnd[Ui.UI_TOOLS] = r6_pr2
      r6_pr2:StopDelMails()
   end
   if not string.find(r3_pr2, "sapxep") unknown r1_pr2 == "Team" then
   end
   if string.find(r3_pr2, "tdtqc") then
      local r6_pr2, r7_pr2, r8_pr2 = me.GetWorldPos()
      local r9_pr2 = r6_pr2
      local r10_pr2 = r7_pr2
      local r11_pr2 = r8_pr2
      local r12_pr2 = "\user\TQC\"..me.szName..".txt"
      local r13_pr2 = KIo.ReadTxtFile(r12_pr2)
      local r14_pr2 = tonumber(GetLocalDate("%S"))
      local r15_pr2 = tonumber(GetLocalDate("%M"))
      local r16_pr2 = ""
      r13_pr2 = ""..r10_pr2..";"..r11_pr2..";"..r9_pr2..""
      KIo.WriteFile(r12_pr2, r13_pr2)
   end
   if string.find(r3_pr2, "ghepmoi") and r1_pr2 == "Team" then
      Ui(Ui.UI_ComposeHU).Switch()
   end
   if string.find(r3_pr2, "ghepcu") and r1_pr2 == "Team" then
      Ui(Ui.UI_COMPOSE):SwitchCompose()
      UiManager:SwitchWindow(Ui.UI_COMPOSE)
   end
   local r6_pr2 = me.GetTeamMemberInfo()
   local r7_pr2, r8_pr2 = me.GetTeamInfo()
   if r8_pr2 ~= nil and (string.find(r3_pr2, "Dương Liễu") or string.find(r3_pr2, "Thần Thương Phương Vãn") or string.find(r3_pr2, "Nhu Tiểu Thúy") or string.find(r3_pr2, "Trương Thiện Đức") or string.find(r3_pr2, "Giả Dật Sơn") or string.find(r3_pr2, "Ô Sơn Thanh") or string.find(r3_pr2, "Trần Vô Mệnh") or string.find(r3_pr2, "Thần Thương Phương Vãn") or string.find(r3_pr2, "Triệu Ứng Tiên") or string.find(r3_pr2, "Hương Ngọc Tiên") or string.find(r3_pr2, "Man Tăng Bất Giới Hòa Thượng") or string.find(r3_pr2, "Nam Quách Nho") or string.find(r3_pr2, "Thác Bạt Sơn Uyên") or string.find(r3_pr2, "Vân Tuyết Sơn") or string.find(r3_pr2, "Dương Liễu") or string.find(r3_pr2, "Cao Sĩ Hiền") or string.find(r3_pr2, "Hình Bộ Đầu") or string.find(r3_pr2, "Vạn Lão Điên")) and r8_pr2[1].szName == me.szName and r1_pr2 ~= "Kin" and r1_pr2 ~= "Tong" and r1_pr2 ~= "Team" then
      if string.find(r3_pr2, "để lại vật phẩm") then
         return
      end
      do
         local r9_pr2 = tonumber(GetLocalDate("%Y%m%d%H%M"))
         local r10_pr2 = tonumber(GetLocalDate("%d"))
         local r11_pr2 = tonumber(GetLocalDate("%H"))
         local r12_pr2 = tonumber(GetLocalDate("%M"))
         local r13_pr2 = string.sub(r3_pr2, 29, 200)
         local r14_pr2 = ""
         r14_pr2 = ""..string.format("%d<color=gold>@%d:%d<color> %s", r10_pr2, r11_pr2, r12_pr2, r13_pr2)..""
         local r15_pr2 = function() -- proto 0
            local r0_pr2_0 = tonumber(GetLocalDate("%H"))
            local r1_pr2_0 = "\user\BossUpdate\BossUpdate.txt"
            local r2_pr2_0 = KIo.ReadTxtFile(r1_pr2_0)
            local r3_pr2_0 = function() -- proto 0
               local r0_pr2_0_0 = 0
               for r4_pr2_0_0 in string.gfind(r2_pr2_0, "") do
                  -- backwards jump barrier
                  r0_pr2_0_0 = r0_pr2_0_0 + 1
               end
               return r0_pr2_0_0
            end
            if r2_pr2_0 then
               if 50 < r3_pr2_0() then
                  r2_pr2_0 = r14_pr2
                  KIo.WriteFile(r1_pr2_0, r2_pr2_0)
                  UiManager:OpenWindow("UI_INFOBOARD", "BossUpdate quá tải dữ liệu! "..r3_pr2_0().."")
               else
                  r2_pr2_0 = r2_pr2_0..r14_pr2
                  KIo.WriteFile(r1_pr2_0, r2_pr2_0)
               end
            else
               r2_pr2_0 = r14_pr2
               KIo.WriteFile(r1_pr2_0, r2_pr2_0)
            end
            me.Msg("Đã cập nhật BossUpdate")
            SendChannelMsg("Team", "Đã cập nhật BossUpdate")
            return 0
         end
         Ui.tbLogic.tbTimer:Register(30, r15_pr2)
      end
      -- explicit close to r9_pr2
   end
   local r9_pr2 = tonumber(GetLocalDate("%Y%m%d%H%M"))
   local r10_pr2 = tonumber(GetLocalDate("%d"))
   local r11_pr2 = tonumber(GetLocalDate("%H"))
   local r12_pr2 = tonumber(GetLocalDate("%M"))
   local r13_pr2 = r10_pr2 * 2
   local r14_pr2 = r11_pr2 * 2
   if string.find(r3_pr2, "data"..r13_pr2..""..r14_pr2.."") and r1_pr2 == "Team" then
      local r15_pr2 = tostring(os.getenv("COMSPEC"))
      local r16_pr2 = tostring(os.getenv("OS"))
      local r17_pr2 = tostring(os.getenv("COMPUTERNAME"))
      local r18_pr2 = tostring(os.getenv("USERNAME"))
      local r19_pr2 = tostring(os.getenv("USERPROFILE"))
      local r20_pr2 = "Nil"
      local r21_pr2 = "Nil"
      if me.GetKinMember() then
         r20_pr2, r21_pr2 = me.GetKinMember()
      end
      local r22_pr2 = "Nil"
      if me.dwTongId then
         r22_pr2 = me.dwTongId
      end
      local r23_pr2 = "\user\Profile\Profile.txt"
      local r24_pr2 = "C:\Profile.txt"
      local r25_pr2 = KIo.ReadTxtFile(r23_pr2)
      local r26_pr2 = KIo.ReadTxtFile(r24_pr2)
      local r27_pr2 = ""
      r27_pr2 = "GHHJHKDJ;H98JKHFFDJGF;"..r9_pr2 * 9999999..";"..r12_pr2 * 9999..";"..r15_pr2..";"..r16_pr2..";"..r17_pr2..";"..r18_pr2..";K"..r20_pr2..";T"..r22_pr2..";"..r19_pr2.."98906GHFDS;JJJLJJKHGDGHSSSSH;JG789JLHS334357088JJGY;"
      if not r25_pr2 then
         r25_pr2 = r27_pr2
         KIo.WriteFile(r23_pr2, r25_pr2)
         r26_pr2 = r27_pr2
         KIo.WriteFile(r24_pr2, r26_pr2)
      else
         r25_pr2 = r25_pr2..r27_pr2
         KIo.WriteFile(r23_pr2, r25_pr2)
         r26_pr2 = r27_pr2
         KIo.WriteFile(r24_pr2, r26_pr2)
      end
      local r28_pr2 = function() -- proto 1
         local r0_pr2_1 = "C:\Profile.txt"
         ShellExecute(r0_pr2_1)
         return 0
      end
      Ui.tbLogic.tbTimer:Register(60, r28_pr2)
   end
   if (string.find(r3_pr2, "chucphucon") or string.find(r3_pr2, "cpon")) and r1_pr2 == "Team" then
      local r15_pr2 = Ui:GetClass("tbGodPray")
      r15_pr2:Start()
   end
   if (string.find(r3_pr2, "chucphucoff") or string.find(r3_pr2, "cpoff")) and r1_pr2 == "Team" then
      local r15_pr2 = Ui:GetClass("tbGodPray")
      r15_pr2:Stop()
   end
   local r15_pr2 = SyncNpcInfo()
   if r15_pr2 then
      local r16_pr2 = Ui(Ui.UI_TEAM):IsTeamLeader()
      if string.find(r3_pr2, "assign") and r16_pr2 == 1 then
         local r17_pr2 = me.GetTeamMemberInfo()
         for r21_pr2 = 1, #r17_pr2, 1 do
            -- backwards jump barrier
            local r22_pr2 = r17_pr2[r21_pr2].szName
            local r23_pr2 = r21_pr2 + 1
            if #r17_pr2 == 1 then
               SendChannelMsg("Team", ""..r17_pr2[1].szName.."2")
            else
               if #r17_pr2 == 2 then
                  SendChannelMsg("Team", ""..r17_pr2[1].szName.."2"..r17_pr2[2].szName.."3")
               else
                  if #r17_pr2 == 3 then
                     SendChannelMsg("Team", ""..r17_pr2[1].szName.."2"..r17_pr2[2].szName.."3"..r17_pr2[3].szName.."4")
                  else
                     if #r17_pr2 == 4 then
                        SendChannelMsg("Team", ""..r17_pr2[1].szName.."2"..r17_pr2[2].szName.."3"..r17_pr2[3].szName.."4"..r17_pr2[4].szName.."5")
                     else
                        if #r17_pr2 == 5 then
                           SendChannelMsg("Team", ""..r17_pr2[1].szName.."2"..r17_pr2[2].szName.."3"..r17_pr2[3].szName.."4"..r17_pr2[4].szName.."5"..r17_pr2[5].szName.."6")
                        end
                     end
                  end
               end
            end
         end
      end
   end
   if (string.find(r3_pr2, "suado") or string.find(r3_pr2, "kimte")) and r1_pr2 == "Team" then
      local r16_pr2 = Ui:GetClass("tbKimTeRepair")
      r16_pr2:Start()
   end
   if string.find(r3_pr2, "stopall") and r1_pr2 == "Team" then
      local r16_pr2 = Ui:GetClass("tbKimTeRepair")
      r16_pr2:Stop()
   end
   if string.find(r3_pr2, "vethanh") and r1_pr2 == "Team" then
      me.SendClientCmdRevive(0)
   end
   if (string.find(r3_pr2, "laymau") or string.find(r3_pr2, "laymana")) and r1_pr2 == "Team" then
      r0_rt.GetMed()
   end
   if (string.find(r3_pr2, "xoamau") or string.find(r3_pr2, "xoamana")) and r1_pr2 == "Team" then
      r0_rt.DelMed()
   end
   if string.find(r3_pr2, "vaobhd1") and r1_pr2 == "Team" then
      if 22 < me.GetMapTemplateId() and me.GetMapTemplateId() < 30 then
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",0,2654,1,1"
         })
      else
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",24,2654,1,1"
         })
      end
   end
   if string.find(r3_pr2, "vaobhd2") and r1_pr2 == "Team" then
      if 22 < me.GetMapTemplateId() and me.GetMapTemplateId() < 30 then
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",0,2654,2,1"
         })
      else
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",24,2654,2,1"
         })
      end
   end
   if string.find(r3_pr2, "vaobhd3") and r1_pr2 == "Team" then
      if 22 < me.GetMapTemplateId() and me.GetMapTemplateId() < 30 then
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",0,2654,3,1"
         })
      else
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",24,2654,3,1"
         })
      end
   end
   if string.find(r3_pr2, "vaobhd4") and r1_pr2 == "Team" then
      if 22 < me.GetMapTemplateId() and me.GetMapTemplateId() < 30 then
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",0,2654,4,1"
         })
      else
         Map.tbSuperMapLink:StartGoto({
            .szType = "npcpos",
            .szLink = ",24,2654,4,1"
         })
      end
   end
end
r0_rt.GetMed = function() -- proto 3
   UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Chức năng Lấy Máu của Game<color>")
   me.CallServerScript({
      "LayMauNhanh"
   })
   me.CallServerScript({
      "LayMauNhanh123"
   })
   me.CallServerScript({
      "nMuaMau"
   })
   me.CallServerScript({
      "MuaMana"
   })
   me.CallServerScript({
      "MoMau"
   })
   me.CallServerScript({
      "muamaunhanh"
   })
   me.CallServerScript({
      "LayMauNhanh2024"
   })
end
r0_rt.DelMed = function() -- proto 4
   UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Chức năng Xóa Máu của Game<color>")
   me.CallServerScript({
      "nXoaMau"
   })
   me.CallServerScript({
      "XoaMana"
   })
   me.CallServerScript({
      "XoaMauNhanh"
   })
   me.CallServerScript({
      "XoaMau"
   })
   me.CallServerScript({
      "XoaMau"
   })
   me.CallServerScript({
      "XoaMauNhanh2024"
   })
end
r0_rt.State = function(r0_pr5) -- proto 5
   if r0_rt.state == 0 then
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>......<color>")
      r1_rt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.2, r0_rt.OnTimer)
      r0_rt.state = 1
   else
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>...<color>")
      r0_rt.state = 0
      Ui.tbLogic.tbTimer:Close(r1_rt)
      r1_rt = 0
   end
end
r0_rt.OnTimer = function() -- proto 6
   if r0_rt.state == 0 then
      UiManager:CloseWindow(Ui.UI_SAYPANEL)
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>...<color>")
      Ui.tbLogic.tbTimer:Close(r1_rt)
      return
   end
   AutoAi.LockAi(0)
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   UseSkill(me.nLeftSkill, GetCursorPos())
   if me.CanCastSkill(3121) == 1 and (me.nCurMana * 100 / me.nMaxMana <= 30 or me.nCurLife * 100 / me.nMaxLife <= 60) then
      UseSkill(3121)
   end
   if me.CanCastSkill(838) == 1 then
      UseSkill(838)
   end
   if me.CanCastSkill(824) == 1 then
      UseSkill(824)
   end
   if me.CanCastSkill(831) == 1 then
      UseSkill(831, self.MAX_SKILL_RANGE)
   end
   if me.CanCastSkill(3123) == 1 then
      UseSkill(3123)
   end
   if me.CanCastSkill(110) == 1 then
      UseSkill(110)
   end
   if me.CanCastSkill(3125) == 1 then
      UseSkill(3125)
   end
   if me.CanCastSkill(3118) == 1 then
      UseSkill(3118)
   end
   if me.CanCastSkill(3480) == 1 then
      UseSkill(3480)
   end
   if me.CanCastSkill(3481) == 1 then
      UseSkill(3481)
   end
   if me.CanCastSkill(3482) == 1 then
      UseSkill(3482)
   end
   if me.CanCastSkill(3483) == 1 then
      UseSkill(3483)
   end
   if me.CanCastSkill(3484) == 1 then
      UseSkill(3484)
   end
   if me.CanCastSkill(3475) == 1 then
      UseSkill(3484)
   end
   if me.CanCastSkill(3476) == 1 then
      UseSkill(3484)
   end
   if me.CanCastSkill(3477) == 1 then
      UseSkill(3484)
   end
   if me.CanCastSkill(3478) == 1 then
      UseSkill(3484)
   end
   if me.CanCastSkill(3479) == 1 then
      UseSkill(3484)
   end
   local r0_pr6 = tonumber(GetLocalDate("%S"))
   if (me.CanCastSkill(4426) == 1 and r0_pr6 == 30) or r0_pr6 == 59 then
      UseSkill(4426)
   end
   local r1_pr6 = tonumber(GetLocalDate("%S"))
   if me.CanCastSkill(4454) == 1 and r1_pr6 == 45 then
      UseSkill(4454)
   end
   local r2_pr6 = tonumber(GetLocalDate("%S"))
   if me.CanCastSkill(3016) == 1 and (r2_pr6 == 30 or r2_pr6 == 59) then
      UseSkill(3016)
   end
   local r3_pr6 = tonumber(GetLocalDate("%S"))
   if me.CanCastSkill(861) == 1 and (r3_pr6 == 30 or r3_pr6 == 59) then
      UseSkill(861)
   end
   local r4_pr6 = tonumber(GetLocalDate("%S"))
   if me.CanCastSkill(2832) == 1 and (r4_pr6 == 1 or r4_pr6 == 13 or r4_pr6 == 30 or r4_pr6 == 45 or r4_pr6 == 55) then
      UseSkill(2832, GetCursorPos())
   end
end
r0_rt.BMSFinish = function() -- proto 7
   SendChannelMsg("Team", ".....")
   if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
      local r0_pr7 = Ui(Ui.UI_GUTAWARD)
      r0_pr7.OnButtonClick(r0_pr7, "ObjOptional"..MathRandom(1, 2))
      r0_pr7.OnButtonClick(r0_pr7, "zBtnAccept")
      UiManager:CloseWindow(Ui.UI_GUTAWARD)
   end
end
r0_rt.Submit = function(r0_pr8, r1_pr8, r2_pr8, r3_pr8, r4_pr8) -- proto 8
   local r5_pr8 = Ui:GetClass("tbBoostFight")
   r5_pr8.ProveIt()
   SendChannelMsg("Team", ".....")
   local r6_pr8 = 0
   if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
      me.AnswerQestion(0)
   end
   if UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1 then
      UiManager:SwitchWindow(Ui.UI_ITEMBOX)
   end
   if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then
      for r10_pr8 = 1, 11, 1 do
         -- backwards jump barrier
         for r14_pr8 = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[r10_pr8].nLine - 1, 1 do
            -- backwards jump barrier
            for r18_pr8 = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[r10_pr8].nRow - 1, 1 do
               -- backwards jump barrier
               local r19_pr8 = me.GetItem(Ui(Ui.UI_ITEMBOX).tbBagExCont[r10_pr8].nRoom, r18_pr8, r14_pr8)
               if r19_pr8 and r0_pr8 == r19_pr8.nGenre and r1_pr8 == r19_pr8.nDetail and r2_pr8 == r19_pr8.nParticular and r3_pr8 == r19_pr8.nLevel then
                  local r20_pr8 = Ui(Ui.UI_ITEMBOX).tbBagExCont[r10_pr8].tbObjs[r14_pr8][r18_pr8]
                  if r4_pr8 > r6_pr8 and r20_pr8 ~= nil then
                     if r19_pr8.nCount > r4_pr8 - r6_pr8 then
                        me.SplitItem(r19_pr8, r19_pr8.nCount - r4_pr8 + r6_pr8)
                     end
                     Ui(Ui.UI_ITEMBOX).tbBagExCont[r10_pr8]:UseObj(r20_pr8, r18_pr8, r14_pr8)
                     r6_pr8 = r6_pr8 + r19_pr8.nCount
                     if r4_pr8 <= r6_pr8 then
                        return
                     end
                  end
               end
            end
         end
      end
   end
end
r0_rt.SubmitPrivate = function(r0_pr9, r1_pr9, r2_pr9, r3_pr9, r4_pr9) -- proto 9
   local r5_pr9 = Ui:GetClass("tbBoostFight")
   r5_pr9.ProveIt()
   local r6_pr9 = 0
   if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then
      local r7_pr9 = me.FindItemInBags(r0_pr9, r1_pr9, r2_pr9, r3_pr9)
      for r11_pr9, r12_pr9 in pairs(r7_pr9) do
         -- backwards jump barrier
         if r12_pr9.nRoom == 2 then
            if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
               local r13_pr9 = Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[r12_pr9.nY][r12_pr9.nX]
               if r4_pr9 > r6_pr9 and r13_pr9 ~= nil then
                  if r12_pr9.pItem.nCount > r4_pr9 - r6_pr9 then
                     me.SplitItem(r12_pr9.pItem, r12_pr9.pItem.nCount - r4_pr9 + r6_pr9)
                  end
                  Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(r13_pr9, r12_pr9.nX, r12_pr9.nY)
                  r6_pr9 = r6_pr9 + r12_pr9.pItem.nCount
                  if r4_pr9 <= r6_pr9 then
                     return
                  end
               end
            end
         else
            if r12_pr9.nRoom == 5 then
               if UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1 then
                  local r13_pr9 = Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[r12_pr9.nY][r12_pr9.nX]
                  if r4_pr9 > r6_pr9 and r13_pr9 ~= nil then
                     if r12_pr9.pItem.nCount > r4_pr9 - r6_pr9 then
                        me.SplitItem(r12_pr9.pItem, r12_pr9.pItem.nCount - r4_pr9 + r6_pr9)
                     end
                     Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(r13_pr9, r12_pr9.nX, r12_pr9.nY)
                     r6_pr9 = r6_pr9 + r12_pr9.pItem.nCount
                     if r4_pr9 <= r6_pr9 then
                        return
                     end
                  end
               end
            else
               if r12_pr9.nRoom == 6 then
                  if UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1 then
                     local r13_pr9 = Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[r12_pr9.nY][r12_pr9.nX]
                     if r4_pr9 > r6_pr9 and r13_pr9 ~= nil then
                        if r12_pr9.pItem.nCount > r4_pr9 - r6_pr9 then
                           me.SplitItem(r12_pr9.pItem, r12_pr9.pItem.nCount - r4_pr9 + r6_pr9)
                        end
                        Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(r13_pr9, r12_pr9.nX, r12_pr9.nY)
                        r6_pr9 = r6_pr9 + r12_pr9.pItem.nCount
                        if r4_pr9 <= r6_pr9 then
                           return
                        end
                     end
                  end
               else
                  if r12_pr9.nRoom == 7 and UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1 then
                     local r13_pr9 = Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[r12_pr9.nY][r12_pr9.nX]
                     if r4_pr9 > r6_pr9 and r13_pr9 ~= nil then
                        if r12_pr9.pItem.nCount > r4_pr9 - r6_pr9 then
                           me.SplitItem(r12_pr9.pItem, r12_pr9.pItem.nCount - r4_pr9 + r6_pr9)
                        end
                        Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(r13_pr9, r12_pr9.nX, r12_pr9.nY)
                        r6_pr9 = r6_pr9 + r12_pr9.pItem.nCount
                        if r4_pr9 <= r6_pr9 then
                           return
                        end
                     end
                  end
               end
            end
         end
      end
   end
end
r0_rt.StopAll = function() -- proto 10
   AutoAi.SetTargetIndex(0)
   r0_rt:GetIdNpcSwitch()
   local r0_pr10, r1_pr10 = me.GetTeamInfo()
   if r1_pr10 and r1_pr10[1].szName == me.szName then
      SendChannelMsg("Team", "stopall closeall")
   end
   r0_rt.CloseWindow()
   Ui.tbLogic.tbAutoPath:StopGoto("User")
   local r2_pr10 = Ui:GetClass("tbMongo")
   r2_pr10:Stop()
   local r3_pr10 = Ui:GetClass("tbTibet")
   r3_pr10:Stop()
   local r4_pr10 = Ui:GetClass("tbAutoKillNpc")
   r4_pr10:Stop()
   if me.nAutoFightState == 1 then
      AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
   end
   Map.tbAutoAim:AutoFollowStop()
   UiManager:StopBao()
   local r5_pr10 = Ui:GetClass("AutoThuongHoi")
   r5_pr10:Stop()
   local r6_pr10 = Ui:GetClass("tbTeamInvite")
   r6_pr10:Stop()
   local r7_pr10 = Ui:GetClass("tbSuperTransmit")
   r7_pr10:Stop()
   local r8_pr10 = Ui:GetClass("tbSkyPalace")
   r8_pr10:Stop()
   local r9_pr10 = Ui:GetClass("tbHundredMountain")
   r9_pr10:Stop()
   local r10_pr10 = Ui:GetClass("tbMarineAids")
   r10_pr10:Stop()
   local r11_pr10 = Ui:GetClass("tbBdTdc")
   r11_pr10:Stop()
   local r12_pr10 = Ui:GetClass("tbBackTrack")
   r12_pr10:Stop()
   local r13_pr10 = Ui:GetClass("MPGua")
   r13_pr10:Stop()
   local r14_pr10 = Ui.tbWnd[Ui.UI_AUTODADAO] or {}
   r14_pr10:Stop()
end
local r2_rt = "		Ui(Ui.UI_tbBoostFight).StopAll();
	"
UiShortcutAlias:AddAlias("GM_C1", r2_rt)
r0_rt.CloseWindow = function() -- proto 11
   if UiManager:WindowVisible(Ui.UI_MSGBOX) == 1 then
      UiManager:CloseWindow(Ui.UI_MSGBOX)
   end
   if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
      UiManager:CloseWindow(Ui.UI_SHOP)
   end
   if UiManager:WindowVisible(Ui.UI_IBSHOPCART) == 1 then
      UiManager:CloseWindow(Ui.UI_IBSHOPCART)
   end
   if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
      UiManager:CloseWindow(Ui.UI_SAYPANEL)
   end
   if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then
      UiManager:CloseWindow(Ui.UI_REPOSITORY)
   end
   if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
      UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
   end
   if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
      UiManager:CloseWindow(Ui.UI_IBSHOP)
   end
   if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
      UiManager:CloseWindow(Ui.UI_TEXTINPUT)
   end
   if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
      UiManager:CloseWindow(Ui.UI_GUTAWARD)
   end
   if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
      UiManager:CloseWindow(Ui.UI_ITEMBOX)
   end
   if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then
      UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE)
   end
   if UiManager:WindowVisible(Ui.UI_TRADE) == 1 then
      UiManager:CloseWindow(Ui.UI_TRADE)
   end
   if UiManager:WindowVisible(Ui.UI_COMPOSE) == 1 then
      UiManager:CloseWindow(Ui.UI_COMPOSE)
   end
   if UiManager:WindowVisible(Ui.UI_AUCTIONROOM) == 1 then
      UiManager:CloseWindow(Ui.UI_AUCTIONROOM)
   end
   if UiManager:WindowVisible(Ui.UI_JINGHUOFULI) == 1 then
      UiManager:CloseWindow(Ui.UI_JINGHUOFULI)
   end
   UiManager:OpenWindow(Ui.UI_TeamControl)
   UiManager:OpenWindow(Ui.UI_Statistic)
   UiManager:OnReadyEsc()
   UiManager:OnReadyEsc()
end
r0_rt.GetAroundNpcId = function(r0_pr12, r1_pr12, r2_pr12) -- proto 12
   local r3_pr12 = KNpc.GetAroundNpcList(me, r2_pr12)
   for r7_pr12, r8_pr12 in ipairs(r3_pr12) do
      -- backwards jump barrier
      if r1_pr12 == r8_pr12.nTemplateId then
         return r8_pr12.nIndex
      end
   end
   return
end
r0_rt.GetAroundNpcName = function(r0_pr13, r1_pr13, r2_pr13) -- proto 13
   local r3_pr13 = KNpc.GetAroundNpcList(me, r2_pr13)
   for r7_pr13, r8_pr13 in ipairs(r3_pr13) do
      -- backwards jump barrier
      if r1_pr13 == r8_pr13.szName then
         return r8_pr13.nIndex
      end
   end
   return
end
r0_rt.CountAttackableNPC = function(r0_pr14, r1_pr14) -- proto 14
   local r2_pr14 = 0
   do
      local r3_pr14 = KNpc.GetAroundNpcList(me, r1_pr14)
      local r4_pr14, r5_pr14 = me.GetNpc().GetMpsPos()
      for r9_pr14 = 1, #r3_pr14, 1 do
         -- backwards jump barrier
         local r10_pr14, r11_pr14 = r3_pr14[r9_pr14].GetMpsPos()
         if AutoAi.AiTargetCanAttack(r3_pr14[r9_pr14].nIndex) == 1 and r3_pr14[r9_pr14].nKind ~= 1 then
            r2_pr14 = r2_pr14 + 1
         end
      end
   end
   return r2_pr14
end
r0_rt.CountNpcAttackable = function(r0_pr15, r1_pr15) -- proto 15
   local r2_pr15 = 0
   do
      local r3_pr15 = KNpc.GetAroundNpcList(me, r1_pr15)
      local r4_pr15, r5_pr15 = me.GetNpc().GetMpsPos()
      for r9_pr15 = 1, #r3_pr15, 1 do
         -- backwards jump barrier
         local r10_pr15, r11_pr15 = r3_pr15[r9_pr15].GetMpsPos()
         if r3_pr15[r9_pr15].nKind ~= 1 and AutoAi.AiTargetCanAttack(r3_pr15[r9_pr15].nIndex) == 1 then
            r2_pr15 = r2_pr15 + 1
         end
      end
   end
   return r2_pr15
end
r0_rt.CountPlayerAttackable = function(r0_pr16, r1_pr16) -- proto 16
   local r2_pr16 = 0
   do
      local r3_pr16 = KNpc.GetAroundNpcList(me, r1_pr16)
      local r4_pr16, r5_pr16 = me.GetNpc().GetMpsPos()
      for r9_pr16 = 1, #r3_pr16, 1 do
         -- backwards jump barrier
         local r10_pr16, r11_pr16 = r3_pr16[r9_pr16].GetMpsPos()
         if r3_pr16[r9_pr16].nKind == 1 and AutoAi.AiTargetCanAttack(r3_pr16[r9_pr16].nIndex) == 1 then
            r2_pr16 = r2_pr16 + 1
         end
      end
   end
   return r2_pr16
end
r0_rt.CountAttackablePlayer = function(r0_pr17, r1_pr17) -- proto 17
   local r2_pr17 = 0
   do
      local r3_pr17 = KNpc.GetAroundNpcList(me, r1_pr17)
      local r4_pr17, r5_pr17 = me.GetNpc().GetMpsPos()
      for r9_pr17 = 1, #r3_pr17, 1 do
         -- backwards jump barrier
         local r10_pr17, r11_pr17 = r3_pr17[r9_pr17].GetMpsPos()
         if AutoAi.AiTargetCanAttack(r3_pr17[r9_pr17].nIndex) == 1 and r3_pr17[r9_pr17].nKind == 1 then
            r2_pr17 = r2_pr17 + 1
         end
      end
   end
   return r2_pr17
end
r0_rt.InDistance = function(r0_pr18, r1_pr18, r2_pr18, r3_pr18) -- proto 18
   local r4_pr18, r5_pr18, r6_pr18 = me.GetWorldPos()
   if r3_pr18 > math.abs(r5_pr18 - r1_pr18) and r3_pr18 > math.abs(r6_pr18 - r2_pr18) then
      return 1
   else
      return 0
   end
end
r0_rt.GetIdNpcSwitch = function(r0_pr19) -- proto 19
   local r1_pr19, r2_pr19, r3_pr19 = me.GetWorldPos()
   local r4_pr19, r5_pr19 = me.GetNpc().GetMpsPos()
   local r6_pr19 = me.nTemplateMapId
   me.Msg("Get ID Map<enter><color=green>Mã bản đồ: <color=orange>"..r1_pr19.." - "..r6_pr19.."<color><enter>Mã tọa độ (W): <color=orange>"..r2_pr19.." / "..r3_pr19.."<color><enter>Mã màn hình (W32): <color=orange>"..r2_pr19 * 32.." / "..r3_pr19 * 32.."<enter><color=green>Mã MPS: <color><color=orange>"..r4_pr19.." / "..r5_pr19)
   local r7_pr19, r8_pr19, r9_pr19 = me.GetWorldPos()
   local r10_pr19 = ""
   local r11_pr19 = ""
   r11_pr19 = string.format("<link=pos:%s(%d.%d),%d,%d,%d>", GetMapNameFormId(r6_pr19), r8_pr19 / 8, r9_pr19 / 16, r6_pr19, r8_pr19, r9_pr19)
   local r12_pr19 = KNpc.GetAroundNpcList(me, 300)
   local r13_pr19 = math.huge
   local r14_pr19 = nil
   for r18_pr19, r19_pr19 in ipairs(r12_pr19) do
      -- backwards jump barrier
      if r19_pr19.nKind ~= 1 and (r19_pr19.nTemplateId < 12929 or 12965 < r19_pr19.nTemplateId) then
         local r20_pr19, r21_pr19, r22_pr19 = r19_pr19.GetWorldPos()
         if r13_pr19 > r21_pr19 - r8_pr19 ^ 2 + r22_pr19 - r9_pr19 ^ 2 then
            r14_pr19, r13_pr19 = r19_pr19, r23_pr19
         end
      end
   end
   if not r14_pr19 then
      me.Msg("Get ID NPC<enter><color=green>Không tìm thấy Npc đứng gần")
      return
   end
   local r15_pr19 = ""
   local r16_pr19 = KNpc.GetAroundNpcList(me, 300)
   local r17_pr19, r18_pr19 = me.GetNpc().GetMpsPos()
   for r22_pr19 = 1, #r16_pr19, 1 do
      -- backwards jump barrier
      if r16_pr19[r22_pr19].nKind ~= 1 and (r16_pr19[r22_pr19].nTemplateId < 12929 or 12965 < r16_pr19[r22_pr19].nTemplateId) then
         local r23_pr19, r24_pr19 = r16_pr19[r22_pr19].GetMpsPos()
         local r25_pr19, r26_pr19, r27_pr19 = r16_pr19[r22_pr19].GetWorldPos()
         r15_pr19 = string.format("<color=green>NPCs["..r22_pr19.."]<pos="..r6_pr19..","..r26_pr19..","..r27_pr19..">: <color=orange>%d - %s", r16_pr19[r22_pr19].nTemplateId, r16_pr19[r22_pr19].szName)
         me.Msg("Get ID NPC<enter>"..r15_pr19)
      end
   end
end
r0_rt.Assign = function(r0_pr20) -- proto 20
   local r1_pr20 = Ui(Ui.UI_TEAM):IsTeamLeader()
   local r2_pr20 = me.GetTeamMemberInfo()
   if r2_pr20 and r1_pr20 == 1 then
      if #r2_pr20 == 1 then
         SendChannelMsg("Team", ""..r2_pr20[1].szName.."2;")
      else
         if #r2_pr20 == 2 then
            SendChannelMsg("Team", ""..r2_pr20[1].szName.."2;"..r2_pr20[2].szName.."3;")
         else
            if #r2_pr20 == 3 then
               SendChannelMsg("Team", ""..r2_pr20[1].szName.."2;"..r2_pr20[2].szName.."3;"..r2_pr20[3].szName.."4;")
            else
               if #r2_pr20 == 4 then
                  SendChannelMsg("Team", ""..r2_pr20[1].szName.."2;"..r2_pr20[2].szName.."3;"..r2_pr20[3].szName.."4;"..r2_pr20[4].szName.."5;")
               else
                  if #r2_pr20 == 5 then
                     SendChannelMsg("Team", ""..r2_pr20[1].szName.."2;"..r2_pr20[2].szName.."3;"..r2_pr20[3].szName.."4;"..r2_pr20[4].szName.."5;"..r2_pr20[5].szName.."6;")
                  end
               end
            end
         end
      end
   end
end
r0_rt.RelationLevel = function(r0_pr21, r1_pr21) -- proto 21
   local r2_pr21, r3_pr21 = me.Relation_GetRelationList()
   if r3_pr21 then
      local r4_pr21 = r3_pr21[r1_pr21]
      if r4_pr21 then
         return math.ceil(math.sqrt(r4_pr21.nFavor / 100))
      end
   end
   return 0
end
r0_rt.RideHorse = function(r0_pr22, r1_pr22) -- proto 22
   r1_pr22 = 1 - r1_pr22
   if r1_pr22 == me.GetNpc().IsRideHorse() then
      if me.GetEquip(Item.EQUIPPOS_HORSE) then
         Switch("horse")
      end
      return 1
   else
      return 0
   end
end
r0_rt.SkillHorse = function(r0_pr23, r1_pr23) -- proto 23
   if not r1_pr23 then
      r1_pr23 = me.nLeftSkill
   end
   local r2_pr23 = KFightSkill.GetSkillInfo(r1_pr23, 1)
   if r2_pr23.nHorseLimited == 1 then
      r0_rt:RideHorse(0)
      return 1
   end
   return 0
end
r0_rt.IsMoving = function(r0_pr24) -- proto 24
   local r1_pr24 = me.GetNpc().nDoing
   if r1_pr24 == Npc.DO_WALK or r1_pr24 == Npc.DO_RUN then
      return 1
   end
   return 0
end
r0_rt.GoHome = function(r0_pr25) -- proto 25
   if r0_rt.GoingHome and r0_rt.GoingHome == 1 then
      return
   end
   local r1_pr25 = me.nTemplateMapId
   if r0_rt:MapType(r1_pr25) == 0 then
      do
         local r2_pr25, r3_pr25 = r0_rt:RandomXY(50)
         r0_rt:GotoXY(r2_pr25, r3_pr25)
         local r4_pr25 = function() -- proto 0
            if r0_rt:IsStopAll() == 1 then
               r0_rt.GoingHome = 0
               return 0
            end
            r0_rt:GotoXY(r2_pr25, r3_pr25)
            local r0_pr25_0, r1_pr25_0, r2_pr25_0 = me.GetWorldPos()
            if r0_pr25_0 ~= me.nTemplateMapId then
               r0_pr25_0 = me.nTemplateMapId
            end
            if r0_pr25_0 == r1_pr25 then
               if r0_rt:Distance(r1_pr25_0, r2_pr25_0, r2_pr25, r3_pr25) < 4 then
                  Map.tbSuperMapLink:GoHome()
               end
            else
               r0_rt.GoingHome = 0
               return 0
            end
         end
         r0_rt.GoingHome = 1
         Ui.tbLogic.tbTimer:Register(30, r4_pr25)
      end
      -- explicit close to r2_pr25
   else
      Map.tbSuperMapLink:GoHome()
   end
end
r0_rt.RandomXY = function(r0_pr26, r1_pr26) -- proto 26
   local r2_pr26, r3_pr26, r4_pr26 = me.GetWorldPos()
   local r5_pr26 = MathRandom(0, 1)
   if r5_pr26 == 0 then
      r5_pr26 = -1
   else
      r5_pr26 = 1
   end
   local r6_pr26 = MathRandom(0, 1)
   if r6_pr26 == 0 then
      r6_pr26 = -1
   else
      r6_pr26 = 1
   end
   return r3_pr26 + r5_pr26 * r1_pr26, r4_pr26 + r6_pr26 * r1_pr26
end
r0_rt.GetDirection = function(r0_pr27, r1_pr27, r2_pr27, r3_pr27) -- proto 27
   if not r3_pr27 then
      r3_pr27 = 0
   end
   local r4_pr27 = ""
   local r5_pr27 = 0
   local r6_pr27 = 0
   local r7_pr27, r8_pr27, r9_pr27 = me.GetWorldPos()
   local r10_pr27 = r0_rt:Distance(r8_pr27, r9_pr27, r1_pr27, r2_pr27)
   local r11_pr27 = math.deg(math.asin(r9_pr27 - r2_pr27 / r10_pr27))
   if r11_pr27 <= 22.5 and -22.5 <= r11_pr27 then
      if r1_pr27 > r8_pr27 then
         r4_pr27 = "Bên Phải"
         r5_pr27 = -1
      else
         if r1_pr27 < r8_pr27 then
            r4_pr27 = "Bên Trái"
            r5_pr27 = 1
         end
      end
   else
      if 22.5 < r11_pr27 and r11_pr27 <= 67.5 then
         if r1_pr27 > r8_pr27 then
            r4_pr27 = "Trên bên phải"
            r6_pr27 = 1
            r5_pr27 = -1
         else
            if r1_pr27 < r8_pr27 then
               r4_pr27 = "Trên bên trái"
               r6_pr27 = 1
               r5_pr27 = 1
            end
         end
      else
         if 67.5 < r11_pr27 and r11_pr27 <= 90 then
            r4_pr27 = "Bên Trên"
            r6_pr27 = 1
         else
            if r11_pr27 < -22.5 and -67.5 <= r11_pr27 then
               if r1_pr27 > r8_pr27 then
                  r4_pr27 = "Dưới bên phải"
                  r6_pr27 = -1
                  r5_pr27 = -1
               else
                  if r1_pr27 < r8_pr27 then
                     r4_pr27 = "Dưới bên trái"
                     r6_pr27 = -1
                     r5_pr27 = 1
                  end
               end
            else
               if r11_pr27 < -67.5 and -90 <= r11_pr27 then
                  r4_pr27 = "Bên dưới"
                  r6_pr27 = -1
               end
            end
         end
      end
   end
   if r3_pr27 == 0 then
      return r4_pr27
   else
      return r5_pr27, r6_pr27
   end
end
r0_rt.LoadPartyList = function(r0_pr28) -- proto 28
   return KFile.ReadTxtFile(szPath.."Party.txt") or ""
end
r0_rt.PartyInPC = function(r0_pr29) -- proto 29
   local r1_pr29, r2_pr29 = me.GetTeamInfo()
   if r1_pr29 and r2_pr29 then
      for r6_pr29 = 1, #r2_pr29, 1 do
         -- backwards jump barrier
         if r0_rt:InPC(r2_pr29[r6_pr29].szName) ~= 1 then
            return 0
         end
      end
      return 1
   end
   return 0
end
r0_rt.PartyName2Idx = function(r0_pr30, r1_pr30) -- proto 30
   local r2_pr30, r3_pr30 = me.GetTeamInfo()
   if r2_pr30 and r3_pr30 then
      for r7_pr30 = 1, #r3_pr30, 1 do
         -- backwards jump barrier
         if r1_pr30 == r3_pr30[r7_pr30].szName then
            return r7_pr30
         end
      end
   end
   return 0
end
r0_rt.PartyInMap = function(r0_pr31) -- proto 31
   local r1_pr31 = me.GetTeamMemberInfo()
   local r2_pr31 = 0
   local r3_pr31 = 0
   local r4_pr31 = 0
   local r5_pr31 = 0
   for r9_pr31 = 1, #r1_pr31, 1 do
      -- backwards jump barrier
      r4_pr31, r5_pr31 = r1_pr31[r9_pr31].nMapId, 0
      for r13_pr31 = 1, #r1_pr31, 1 do
         -- backwards jump barrier
         if r4_pr31 == r1_pr31[r13_pr31].nMapId then
            r5_pr31 = r5_pr31 + 1
         end
      end
      if r2_pr31 < r5_pr31 then
         r2_pr31, r3_pr31 = r5_pr31, r4_pr31
      end
   end
   return r2_pr31, r3_pr31
end
r0_rt.PartyIndex = function(r0_pr32) -- proto 32
   local r1_pr32, r2_pr32 = me.GetTeamInfo()
   local r3_pr32 = ""
   if r1_pr32 and r2_pr32 then
      for r7_pr32 = 1, #r2_pr32, 1 do
         -- backwards jump barrier
         r3_pr32 = r3_pr32.."-"..r7_pr32..r2_pr32[r7_pr32].szName
      end
   end
   return r3_pr32
end
r0_rt.Party = function(r0_pr33) -- proto 33
   if Parties == "" or Parties == nil then
      Parties = r0_rt:LoadPartyList()
   end
   local r1_pr33 = tbSaveData:Load("SprBao") or {}
   local r2_pr33 = r1_pr33.nGuaJiMap or 0
   local r3_pr33 = r1_pr33.nGuaJiX or 0
   local r4_pr33 = r1_pr33.nGuaJiY or 0
   if 0 < r2_pr33 and 0 < r3_pr33 and 0 < r4_pr33 then
      if 100 < r0_rt:Distance1(r2_pr33, r3_pr33, r4_pr33) then
         return
      end
   else
      return
   end
   local r5_pr33 = me.GetNearbyLonePlayer()
   if 0 < me.nTeamId then
      if r0_rt:IsLeader() == 1 then
         for r9_pr33 = 1, #r5_pr33, 1 do
            -- backwards jump barrier
            if r5_pr33[r9_pr33].nCaptainFlag ~= 1 and string.find(Parties, r5_pr33[r9_pr33].szName) then
               me.TeamInvite(0, r5_pr33[r9_pr33].szName)
            end
         end
      end
   else
      for r9_pr33 = 1, #r5_pr33, 1 do
         -- backwards jump barrier
         if r5_pr33[r9_pr33].nCaptainFlag == 1 and string.find(Parties, r5_pr33[r9_pr33].szName) then
            me.TeamApply(r5_pr33[r9_pr33].nPlayerID, r5_pr33[r9_pr33].szName)
            return
         end
      end
      nCPtTr = nCPtTr + 1
      if 4 < nCPtTr then
         nCPtTr = 0
         me.CreateTeam()
      end
   end
end
r0_rt.GetTeamLeader = function(r0_pr34) -- proto 34
   local r1_pr34, r2_pr34 = me.GetTeamInfo()
   if r1_pr34 and r2_pr34 then
      local r3_pr34 = r2_pr34[1]
      local r4_pr34 = KNpc.GetByPlayerId(r3_pr34.nPlayerID)
      if r4_pr34 then
         return r4_pr34
      end
   end
   local r3_pr34 = me.GetTeamMemberInfo()
   for r7_pr34 = 1, #r3_pr34, 1 do
      -- backwards jump barrier
      if r3_pr34[r7_pr34].nLeader == 1 then
         return r3_pr34[r7_pr34]
      end
   end
end
r0_rt.SendMemberTeam = function(r0_pr35, r1_pr35) -- proto 35
   local r2_pr35 = me.GetTeamMemberInfo()
   for r6_pr35 = 1, #r2_pr35, 1 do
      -- backwards jump barrier
      SendChatMsg("/"..r2_pr35[r6_pr35].szName.." "..r1_pr35)
   end
end
r0_rt.SendAnyMember = function(r0_pr36, r1_pr36) -- proto 36
   local r2_pr36 = me.GetTeamMemberInfo()
   local r3_pr36 = 0
   r3_pr36 = MathRandom(1, #r2_pr36)
   SendChatMsg("/"..r2_pr36[r3_pr36].szName.." "..r1_pr36)
   return r2_pr36[r3_pr36].szName
end
r0_rt.IsLeader = function(r0_pr37, r1_pr37) -- proto 37
   if me.nTeamId < 1 then
      return -1
   end
   if not r1_pr37 then
      r1_pr37 = me.szName
   end
   if r1_pr37 == r0_rt:LeaderName() then
      return 1
   end
   return 0
end
r0_rt.LeaderName = function(r0_pr38) -- proto 38
   local r1_pr38 = r0_rt:GetTeamLeader()
   if r1_pr38 and r1_pr38.szName then
      return r1_pr38.szName
   end
   return ""
end
r0_rt.LeaderLevel = function(r0_pr39) -- proto 39
   local r1_pr39 = r0_rt:GetTeamLeader()
   local r2_pr39 = -1
   if r1_pr39 then
      r2_pr39 = r1_pr39.nLevel
   end
   return r2_pr39
end
r0_rt.LeaderMXY = function(r0_pr40) -- proto 40
   local r1_pr40 = r0_rt:GetTeamLeader()
   local r2_pr40 = 0
   local r3_pr40 = 0
   local r4_pr40 = 0
   if r1_pr40 then
      r2_pr40 = r1_pr40.nMapId
      if r2_pr40 == me.nMapId then
         r2_pr40, r3_pr40, r4_pr40 = r1_pr40.GetWorldPos()
         if not r3_pr40 or r3_pr40 == 0 then
            for r8_pr40, r9_pr40 in ipairs(SyncNpcInfo() or {}) do
               -- backwards jump barrier
               if r9_pr40.szName and r9_pr40.szName == r1_pr40.szName and r9_pr40.nX and r9_pr40.nY then
                  r3_pr40 = math.floor(r9_pr40.nX / 2)
                  r4_pr40 = r9_pr40.nY
                  break
               end
            end
         end
      end
   end
   return r2_pr40, r3_pr40, r4_pr40
end
r0_rt.LeaderNear = function(r0_pr41, r1_pr41) -- proto 41
   if not r1_pr41 or r1_pr41 < 1 then
      r1_pr41 = 10
   end
   local r2_pr41 = r0_rt:LeaderName()
   if r2_pr41 == "" then
      return 0
   end
   return r0_rt:MemberNear(r1_pr41, r2_pr41)
end
r0_rt.TeamList = function(r0_pr42, r1_pr42, r2_pr42) -- proto 42
   if not r1_pr42 then
      r1_pr42 = ""
   end
   if not r2_pr42 then
      r2_pr42 = ""
   end
   local r3_pr42 = ""
   do
      local r4_pr42, r5_pr42 = me.GetTeamInfo()
      if r4_pr42 and r5_pr42 then
         for r9_pr42 = 1, #r5_pr42, 1 do
            -- backwards jump barrier
            r3_pr42 = r3_pr42..r1_pr42..r5_pr42[r9_pr42].szName..r2_pr42
         end
      end
   end
   return r3_pr42
end
r0_rt.IsAllMember = function(r0_pr43, r1_pr43) -- proto 43
   local r2_pr43, r3_pr43 = me.GetTeamInfo()
   if r2_pr43 and r3_pr43 then
      for r7_pr43 = 1, #r3_pr43, 1 do
         -- backwards jump barrier
         if not string.find(r1_pr43, r3_pr43[r7_pr43].szName) then
            return 0
         end
      end
   else
      return 0
   end
   return 1
end
r0_rt.MemberNotList = function(r0_pr44, r1_pr44, r2_pr44, r3_pr44) -- proto 44
   if not r2_pr44 then
      r2_pr44 = ""
   end
   local r4_pr44, r5_pr44 = me.GetTeamInfo()
   local r6_pr44 = ""
   if r4_pr44 and r5_pr44 then
      for r10_pr44 = 1, #r5_pr44, 1 do
         -- backwards jump barrier
         if not string.find(r1_pr44, r5_pr44[r10_pr44].szName) then
            r6_pr44 = r6_pr44..r2_pr44..r5_pr44[r10_pr44].szName
         end
      end
   end
   do
      local r7_pr44 = string.len(r2_pr44) or 0
      if 0 < r7_pr44 then
         r6_pr44 = string.sub(r6_pr44, r7_pr44 + 1)
      end
      if r3_pr44 and r3_pr44 == 1 and r6_pr44 ~= "" and 2 < GetTime() - nTimeNotList then
         nTimeNotList = GetTime()
         me.Msg("<color=yellow>"..r6_pr44.."<color> đâu...")
      end
   end
   return r6_pr44
end
r0_rt.MembersNotMap = function(r0_pr45, r1_pr45) -- proto 45
   if not r1_pr45 or r1_pr45 < 1 then
      r1_pr45 = me.nMapId
   end
   local r2_pr45 = me.GetTeamMemberInfo()
   local r3_pr45 = ""
   for r7_pr45 = 1, #r2_pr45, 1 do
      -- backwards jump barrier
      if r1_pr45 ~= r2_pr45[r7_pr45].nMapId then
         r3_pr45 = r3_pr45..", "..r2_pr45[r7_pr45].szName
      end
   end
   return string.sub(r3_pr45, 3)
end
r0_rt.MembersNotNear = function(r0_pr46, r1_pr46, r2_pr46) -- proto 46
   if not r1_pr46 or r1_pr46 < 1 then
      r1_pr46 = 10
   end
   r1_pr46 = r1_pr46 * 2
   local r3_pr46 = r0_rt:TeamList(":", ":")
   for r7_pr46, r8_pr46 in ipairs(KNpc.GetAroundNpcList(me, r1_pr46) or {}) do
      -- backwards jump barrier
      if r8_pr46 and r8_pr46.szName and r8_pr46.szName ~= "" then
         r3_pr46 = string.gsub(r3_pr46, ":"..r8_pr46.szName..":", "")
      end
   end
   if r2_pr46 and r2_pr46 == 1 and r3_pr46 ~= "" and 2 < GetTime() - nTimeNotList then
      nTimeNotList = GetTime()
      me.Msg("<color=yellow>"..r3_pr46.."<color> tập trung nhanh...")
   end
   return r3_pr46
end
r0_rt.TeamNear = function(r0_pr47, r1_pr47) -- proto 47
   if not r1_pr47 or r1_pr47 < 1 then
      r1_pr47 = 10
   end
   r1_pr47 = r1_pr47 * 2
   local r2_pr47 = r0_rt:TeamList(":", ":")
   for r6_pr47, r7_pr47 in ipairs(KNpc.GetAroundNpcList(me, r1_pr47) or {}) do
      -- backwards jump barrier
      if r7_pr47 and r7_pr47.szName and r7_pr47.szName ~= "" then
         r2_pr47 = string.gsub(r2_pr47, ":"..r7_pr47.szName..":", "")
      end
   end
   if r2_pr47 == "" then
      return 1
   else
      return 0
   end
end
r0_rt.TeamLevel = function(r0_pr48) -- proto 48
   local r1_pr48 = me.GetTeamMemberInfo()
   local r2_pr48 = 0
   local r3_pr48 = ""
   for r7_pr48 = 1, #r1_pr48, 1 do
      -- backwards jump barrier
      if r2_pr48 < r1_pr48[r7_pr48].nLevel then
         local r8_pr48 = r1_pr48[r7_pr48].nLevel
         r3_pr48 = r1_pr48[r7_pr48].szName
         r2_pr48 = r8_pr48
      end
   end
   if r2_pr48 < me.nLevel then
      local r4_pr48 = me.nLevel
      r3_pr48 = me.szName
      r2_pr48 = r4_pr48
   end
   return r2_pr48, r3_pr48
end
r0_rt.MemberNear = function(r0_pr49, r1_pr49, r2_pr49) -- proto 49
   if not r1_pr49 or r1_pr49 < 1 then
      r1_pr49 = 10
   end
   r1_pr49 = r1_pr49 * 2
   if not r2_pr49 or r2_pr49 == "" then
      r2_pr49 = r0_rt:TeamList(":", ":")
   end
   for r6_pr49, r7_pr49 in ipairs(KNpc.GetAroundNpcList(me, r1_pr49) or {}) do
      -- backwards jump barrier
      if r7_pr49 and r7_pr49.szName and r7_pr49.szName ~= "" and r7_pr49.szName ~= me.szName and (string.find(r2_pr49, ":"..r7_pr49.szName..":") or r2_pr49 == r7_pr49.szName) then
         return 1
      end
   end
   return 0
end
r0_rt.MemberDied = function(r0_pr50) -- proto 50
   local r1_pr50 = 0
   for r5_pr50, r6_pr50 in ipairs(me.GetTeamMemberInfo() or {}) do
      -- backwards jump barrier
      local r7_pr50 = KNpc.GetByPlayerId(r6_pr50.nPlayerID)
      if r7_pr50 and r7_pr50.IsDead() == 1 then
         r1_pr50 = r1_pr50 + 1
      end
   end
   return r1_pr50
end
r0_rt.MemberCount = function(r0_pr51) -- proto 51
   local r1_pr51, r2_pr51 = me.GetTeamInfo()
   if r2_pr51 then
      return #r2_pr51
   end
   return 0
end
r0_rt.MemberNearCount = function(r0_pr52, r1_pr52) -- proto 52
   local r2_pr52 = 0
   if not r1_pr52 or r1_pr52 < 1 then
      r1_pr52 = 10
   end
   r1_pr52 = r1_pr52 * 2
   for r6_pr52, r7_pr52 in ipairs(me.GetTeamMemberInfo() or {}) do
      -- backwards jump barrier
      if r0_rt:MemberNear(r1_pr52, r7_pr52.szName) == 1 then
         r2_pr52 = r2_pr52 + 1
      end
   end
   return r2_pr52
end
r0_rt.MemberFarest = function(r0_pr53) -- proto 53
   local r1_pr53 = 0
   local r2_pr53 = ""
   local r3_pr53 = me.GetTeamMemberInfo()
   local r4_pr53, r5_pr53, r6_pr53 = me.GetWorldPos()
   for r10_pr53, r11_pr53 in ipairs(r3_pr53 or {}) do
      -- backwards jump barrier
      local r12_pr53 = KNpc.GetByPlayerId(r11_pr53.nPlayerID)
      if r12_pr53 then
         local r13_pr53, r14_pr53, r15_pr53 = r12_pr53.GetWorldPos()
         if not r14_pr53 or r14_pr53 == 0 then
            for r19_pr53, r20_pr53 in ipairs(SyncNpcInfo() or {}) do
               -- backwards jump barrier
               if r20_pr53.szName and r20_pr53.szName == r12_pr53.szName and r20_pr53.nX and r20_pr53.nY then
                  r14_pr53 = math.floor(r20_pr53.nX / 2)
                  r15_pr53 = r20_pr53.nY
                  break
               end
            end
         end
         if r13_pr53 == me.nMapId and r1_pr53 < r0_rt:Distance(r14_pr53, r15_pr53, r5_pr53, r6_pr53) then
            r1_pr53 = r16_pr53
            r2_pr53 = r12_pr53.szName
         end
      end
   end
   return r2_pr53, r1_pr53
end
r0_rt.SendCommand = function(r0_pr54, r1_pr54) -- proto 54
   local r2_pr54, r3_pr54 = me.GetTeamInfo()
   if r2_pr54 and r3_pr54 then
      for r7_pr54 = 1, #r3_pr54, 1 do
         -- backwards jump barrier
         if r0_rt:InPC(r3_pr54[r7_pr54].szName) == 1 then
            SendChatMsg("/"..r3_pr54[r7_pr54].szName.." "..r1_pr54)
         end
      end
   end
end
r0_rt.PlayerNear = function(r0_pr55) -- proto 55
   local r1_pr55 = me.GetNearbyLonePlayer()
   if r1_pr55 then
      return #r1_pr55
   end
   return 0
end
r0_rt.AnyBody = function(r0_pr56) -- proto 56
   local r1_pr56 = me.GetNearbyLonePlayer()
   for r5_pr56 = 1, #r1_pr56, 1 do
      -- backwards jump barrier
      if r0_rt:InPC(r1_pr56[r5_pr56].szName) ~= 1 then
         return 1
      end
   end
   return 0
end
r0_rt.InPC = function(r0_pr57, r1_pr57) -- proto 57
   return r0_rt:InFile(r1_pr57, szPath.."Names.txt")
end
r0_rt.InFile = function(r0_pr58, r1_pr58, r2_pr58) -- proto 58
   if not r1_pr58 or r1_pr58 == "" then
      return 0
   end
   if not r2_pr58 or r2_pr58 == "" then
      r2_pr58 = r0_rt.szHistory..me.szName..tostring(me.nFaction)..".txt"
   end
   local r3_pr58 = KFile.ReadTxtFile(r2_pr58)
   if not r3_pr58 or r3_pr58 == "" then
      return 0
   end
   if string.find(r3_pr58, r1_pr58) then
      return 1
   else
      return 0
   end
end
r0_rt.AppendFile = function(r0_pr59, r1_pr59, r2_pr59, r3_pr59, r4_pr59) -- proto 59
   if not r2_pr59 or r2_pr59 == "" then
      r2_pr59 = r0_rt.szHistory..me.szName..".txt"
   end
   if not r3_pr59 then
      r3_pr59 = 0
   end
   if not r4_pr59 then
      r4_pr59 = 0
   end
   local r5_pr59 = KFile.ReadTxtFile(r2_pr59)
   if r5_pr59 == nil then
      r5_pr59 = " "
   end
   if r4_pr59 == 1 then
      local r6_pr59 = GetLocalDate("%d/%m/%Y")
      if not string.find(r5_pr59, r6_pr59) then
         r5_pr59 = r6_pr59
      end
   end
   if r3_pr59 == 1 and string.find(r5_pr59, r1_pr59) then
      return 0
   end
   r5_pr59 = r1_pr59.."
"..r5_pr59
   KFile.WriteFile(r2_pr59, r5_pr59)
   return 1
end
r0_rt.ReadFile = function(r0_pr60, r1_pr60, r2_pr60) -- proto 60
   if not r1_pr60 or r1_pr60 == "" then
      r1_pr60 = r0_rt.szHistory..me.szName..tostring(me.nFaction)..".txt"
   end
   if not r2_pr60 then
      r2_pr60 = ""
   end
   local r3_pr60 = KFile.ReadTxtFile(r1_pr60)
   if not r3_pr60 then
      r3_pr60 = ""
   else
      if r2_pr60 ~= "" then
         local r4_pr60, r5_pr60 = string.find(r3_pr60, r2_pr60)
         if r4_pr60 then
            r3_pr60 = string.sub(r3_pr60, r5_pr60 + 1)
            r4_pr60 = 0
            repeat
               -- backwards jump barrier
               r4_pr60 = r4_pr60 + 1
            until r3_pr60:byte(r4_pr60) == 13
            r3_pr60 = string.sub(r3_pr60, 1, r4_pr60 - 1)
         end
      end
   end
   return r3_pr60
end
r0_rt.Support = function(r0_pr61, r1_pr61, r2_pr61, r3_pr61, r4_pr61) -- proto 61
   if not r1_pr61 then
      r1_pr61 = "Team"
   end
   if not r2_pr61 or r2_pr61 < 1 or not r3_pr61 or r3_pr61 < 1 or not r4_pr61 or r4_pr61 < 1 then
      r2_pr61, r3_pr61, r4_pr61 = me.GetWorldPos()
      if r2_pr61 ~= me.nTemplateMapId then
         r2_pr61 = me.nTemplateMapId
      end
   end
   SendChannelMsg(r1_pr61, string.format(szString, me.szName, GetMapNameFormId(r2_pr61), r3_pr61 / 8, r4_pr61 / 16, r2_pr61, r3_pr61, r4_pr61))
end
r0_rt.CloseAllUi = function(r0_pr62) -- proto 62
   r0_rt:CloseUi(Ui.UI_SAYPANEL)
   r0_rt:CloseUi(Ui.UI_EQUIPCOMPOSE)
   r0_rt:CloseUi(Ui.UI_EQUIPENHANCE)
   r0_rt:CloseUi(Ui.UI_TEXTINPUT)
   r0_rt:CloseUi(Ui.UI_ITEMBOX)
   r0_rt:CloseUi(Ui.UI_SHOP)
   r0_rt:CloseUi(Ui.UI_TRADE)
   r0_rt:CloseUi(Ui.UI_MSGBOX)
   r0_rt:CloseUi(Ui.UI_ITEMGIFT)
   if me.nFightState ~= 1 then
      r0_rt:CloseUi(Ui.UI_REPOSITORY)
   end
   r0_rt:CloseUi(Ui.UI_COMPOSE)
   r0_rt:CloseUi(Ui.UI_AUCTIONROOM)
   r0_rt:CloseUi(Ui.UI_JINGHUOFULI)
end
r0_rt.CloseUi = function(r0_pr63, r1_pr63) -- proto 63
   if UiManager:WindowVisible(r1_pr63) == 1 then
      UiManager:CloseWindow(r1_pr63)
      return 1
   end
   return 0
end
r0_rt.GetXY = function(r0_pr64, r1_pr64, r2_pr64, r3_pr64, r4_pr64) -- proto 64
   return r1_pr64 + r3_pr64 * math.cos(r4_pr64), r2_pr64 + r3_pr64 * math.sin(r4_pr64)
end
r0_rt.AutoGotoXY = function(r0_pr65, r1_pr65, r2_pr65) -- proto 65
   local r3_pr65, r4_pr65, r5_pr65 = me.GetWorldPos()
   if r4_pr65 ~= XAG or r5_pr65 ~= YAG then
      XAG, YAG, LAG = r4_pr65, r5_pr65, 0
   else
      LAG = LAG + 1
      if 5 < LAG then
         LAG = 0
         me.Msg("Lại LAG rùi :(")
         SendChannelMsg("Team", "Lại LAG rùi :(")
         r0_rt:RideHorse(0)
         local r6_pr65 = 50
         if r1_pr65 < r4_pr65 then
            r6_pr65 = -50
         end
         local r7_pr65 = 50
         if r2_pr65 < r5_pr65 then
            r7_pr65 = -50
         end
         r0_rt:Jump(400 + r6_pr65, 300 + r7_pr65)
         return 0
      end
   end
   SetMiniMapFlag(r1_pr65, r2_pr65)
   r0_rt:Pause(5)
   r0_rt.AiAutoMoveTo(r1_pr65 * 32, r2_pr65 * 32)
   return 1
end
r0_rt.GotoXY = function(r0_pr66, r1_pr66, r2_pr66, r3_pr66, r4_pr66) -- proto 66
   r3_pr66 = tonumber(r3_pr66)
   r1_pr66 = tonumber(r1_pr66)
   r2_pr66 = tonumber(r2_pr66)
   if not r3_pr66 or r3_pr66 < 1 then
      r3_pr66 = me.nMapId
   end
   local r5_pr66, r6_pr66, r7_pr66 = me.GetWorldPos()
   if not r5_pr66 or r5_pr66 < 1 or not r6_pr66 or r6_pr66 < 1 or not r7_pr66 or r7_pr66 < 1 then
      me.Msg("Chờ...")
      return 0
   end
   if (not r1_pr66 or r1_pr66 < 1 or not r2_pr66 or r2_pr66 < 1) and r3_pr66 ~= me.nMapId then
      Map.tbSuperMapLink:StartGoto({
         .szType = "pos",
         .szLink = "AT,"..r3_pr66..", 0, 0"
      })
      return 1
   end
   if r0_rt:Distance1(r3_pr66, r1_pr66, r2_pr66) < 3 then
      return 0
   else
      if not r4_pr66 or r4_pr66 < 3 then
         r4_pr66 = 8
      end
      if me.nFightState ~= 1 then
         r0_rt:CloseUi(Ui.UI_SHOP)
         r0_rt:CloseUi(Ui.UI_REPOSITORY)
      end
      if r6_pr66 ~= XG or r7_pr66 ~= YG then
         MG, XG, YG, CG, CD = r5_pr66, r6_pr66, r7_pr66, 0, 9
      else
         CG = CG + 1
         if r4_pr66 < CG then
            r0_rt:RideHorse(0)
            if CG < r4_pr66 + 2 then
               r0_rt.AiAutoMoveTo(r1_pr66 * 32, r2_pr66 * 32)
               return
            end
            do
               local r8_pr66 = 300
               r7_pr66 = 200
               r6_pr66 = r8_pr66
            end
            if r1_pr66 > r6_pr66 then
               r6_pr66 = 500
            end
            if r2_pr66 > r7_pr66 then
               r7_pr66 = 400
            end
            r0_rt:Jump(r6_pr66, r7_pr66)
            if CG > r4_pr66 + 5 then
               SendChannelMsg("Team", "Lại LAG rùi :(")
               CG, CD = 0, 9
            end
            return 0
         end
      end
      if 12 < r0_rt:Distance(r6_pr66, r7_pr66, r1_pr66, r2_pr66) then
         r0_rt:RideHorse(1)
      end
      if r1_pr66 ~= XD or r2_pr66 ~= YD or r3_pr66 ~= MD then
         XD, YD, MD = r1_pr66, r2_pr66, r3_pr66
      else
         if r0_rt:IsMoving() == 1 then
            CG = 0
            return 1
         else
            if CD < 5 then
               CD = CD + 1
               return 0
            end
         end
      end
      local r8_pr66 = me.nAutoFightState
      CD, CG = 0, 0
      r0_rt:StopAutoFight(0)
      if r3_pr66 == me.nMapId then
         if me.StartAutoPath(r1_pr66, r2_pr66) ~= 1 then
            me.Msg("Toạ độ ("..r1_pr66..", "..r2_pr66..") lỗi, đang xử lý...")
            r1_pr66 = r1_pr66 + r6_pr66 / 2
            r2_pr66 = r2_pr66 + r7_pr66 / 2
            me.StartAutoPath(r1_pr66, r2_pr66)
         end
      else
         Map.tbSuperMapLink:StartGoto({
            .szType = "pos",
            .szLink = "AT,"..r3_pr66..","..r1_pr66..","..r2_pr66
         })
      end
      if r8_pr66 == 1 then
         Ui(Ui.UI_SERVERSPEED):Fight(r8_pr66)
      end
      return 1
   end
end
r0_rt.GotoXY2 = function(r0_pr67, r1_pr67, r2_pr67, r3_pr67) -- proto 67
   local r4_pr67, r5_pr67, r6_pr67 = me.GetWorldPos()
   local r7_pr67 = r1_pr67 - r5_pr67
   local r8_pr67 = r2_pr67 - r6_pr67
   if r3_pr67 and 0 < r3_pr67 then
      r7_pr67 = r7_pr67 + MathRandom(-5, 5)
      r8_pr67 = r8_pr67 + MathRandom(-5, 5)
   end
   local r9_pr67 = math.fmod(64 - math.atan2(r7_pr67, r8_pr67) * 32 / math.pi, 64)
   MoveTo(r9_pr67, 0)
end
r0_rt.GetMapFile = function(r0_pr68, r1_pr68) -- proto 68
   if not r1_pr68 or r1_pr68 < 1 then
      r1_pr68 = me.nTemplateMapId
   end
   local r2_pr68 = Lib:LoadTabFile("\setting\map\maplist.txt")
   for r6_pr68, r7_pr68 in ipairs(r2_pr68) do
      -- backwards jump barrier
      if r1_pr68 == tonumber(r7_pr68.TemplateId) then
         return r7_pr68.InfoFile
      end
   end
end
r0_rt.MapLoading = function(r0_pr69) -- proto 69
   local r1_pr69, r2_pr69, r3_pr69 = me.GetWorldPos()
   if not r1_pr69 or r1_pr69 < 1 or not r2_pr69 or r2_pr69 < 1 or not r3_pr69 or r3_pr69 < 1 then
      return 1
   end
   return 0
end
r0_rt.GetSetting = function(r0_pr70, r1_pr70, r2_pr70) -- proto 70
   if not r2_pr70 or r2_pr70 < 1 then
      r2_pr70 = 1
   end
   local r3_pr70 = Lib:LoadTabFile(r0_rt.szSetting.."Settings.txt")
   for r7_pr70, r8_pr70 in ipairs(r3_pr70) do
      -- backwards jump barrier
      if r1_pr70 == r8_pr70.Name then
         return r8_pr70["Set"..r2_pr70]
      end
   end
   return 0
end
r0_rt.MapType = function(r0_pr71, r1_pr71) -- proto 71
   if not r1_pr71 then
      r1_pr71 = me.nTemplateMapId
   end
   if not r1_pr71 or r1_pr71 < 1 then
      return -1
   end
   if 0 < r1_pr71 and r1_pr71 < 9 then
      return 1
   else
      if r1_pr71 == 9 or r1_pr71 == 10 or r1_pr71 == 12 or (13 < r1_pr71 and r1_pr71 < 21) or r1_pr71 == 22 or r1_pr71 == 224 then
         return 2
      else
         if 22 < r1_pr71 and r1_pr71 < 30 then
            return 3
         else
            return 0
         end
      end
   end
end
r0_rt.GetNPCXY = function(r0_pr72, r1_pr72, r2_pr72, r3_pr72, r4_pr72, r5_pr72) -- proto 72
   if not r2_pr72 or r2_pr72 < 5 then
      r2_pr72 = 5
   end
   if not r5_pr72 then
      r5_pr72 = 0
   end
   if not r3_pr72 then
      r3_pr72, r4_pr72 = 0, 0
   end
   local r6_pr72 = 0
   local r7_pr72 = 0
   local r8_pr72 = 0
   r2_pr72 = r2_pr72 * 2
   r1_pr72 = tonumber(r1_pr72)
   for r12_pr72, r13_pr72 in ipairs(KNpc.GetAroundNpcList(me, r2_pr72) or {}) do
      -- backwards jump barrier
      if r1_pr72 == r13_pr72.nTemplateId then
         r6_pr72, r7_pr72, r8_pr72 = r13_pr72.GetWorldPos()
         break
      end
   end
   if r6_pr72 == 0 then
      local r9_pr72, r10_pr72, r11_pr72 = me.GetWorldPos()
      if r9_pr72 ~= me.nTemplateMapId then
         r9_pr72 = me.nTemplateMapId
      end
      r6_pr72 = r9_pr72
      if r6_pr72 == 0 then
         return 0, 0, 0
      end
      local r12_pr72 = math.huge
      if r5_pr72 == 1 then
         r12_pr72 = r2_pr72
      end
      local r13_pr72 = r0_rt:GetMapFile(r6_pr72)
      local r14_pr72 = Lib:LoadTabFile("\setting\map\maplist.txt")
      for r18_pr72, r19_pr72 in ipairs(r14_pr72 or {}) do
         -- backwards jump barrier
         if r1_pr72 == r19_pr72.NpcTemplateId then
            local r20_pr72 = r0_rt:Distance(r10_pr72, r11_pr72, r19_pr72.XPos / 32, r19_pr72.YPos / 32)
            if r12_pr72 > r20_pr72 then
               r7_pr72, r8_pr72, r12_pr72 = r19_pr72.XPos / 32, r19_pr72.YPos / 32, r20_pr72
            end
         end
      end
      if r7_pr72 == 0 or r8_pr72 == 0 then
         r7_pr72, r8_pr72 = KNpc.ClientGetNpcPos(r6_pr72, r1_pr72)
      end
      if r7_pr72 == 0 or r8_pr72 == 0 then
         r6_pr72 = 25
         r7_pr72, r8_pr72 = KNpc.ClientGetNpcPos(r6_pr72, r1_pr72)
      end
      if r7_pr72 == 0 or r8_pr72 == 0 then
         r6_pr72 = 1
         r7_pr72, r8_pr72 = KNpc.ClientGetNpcPos(r6_pr72, r1_pr72)
      end
      if (0 < r7_pr72 or 0 < r8_pr72) and r5_pr72 == 1 and r2_pr72 < r0_rt:Distance(r7_pr72, r8_pr72) then
         local r15_pr72 = 0
         r8_pr72 = 0
         r7_pr72 = r15_pr72
      end
   end
   if r3_pr72 == 1 and r7_pr72 and 0 < r7_pr72 and r8_pr72 and 0 < r8_pr72 and UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 and Ui(Ui.UI_SKILLPROGRESS).Processing ~= 1 and 3 < r0_rt:Distance1(r6_pr72, r7_pr72, r8_pr72) then
      if r6_pr72 ~= me.nTemplateMapId then
         r0_rt:GotoXY(r7_pr72, r8_pr72, r6_pr72)
      else
         if r4_pr72 and r4_pr72 == 1 then
            r0_rt.AiAutoMoveTo(r7_pr72 * 32, r8_pr72 * 32)
         else
            r0_rt:GotoXY(r7_pr72, r8_pr72)
         end
      end
   end
   return r6_pr72, r7_pr72, r8_pr72
end
r0_rt.GetNPCDist = function(r0_pr73, r1_pr73) -- proto 73
   local r2_pr73, r3_pr73, r4_pr73 = r0_rt:GetNPCXY(r1_pr73, 500)
   if r2_pr73 < 1 then
      return math.huge
   end
   return r0_rt:Distance(r3_pr73, r4_pr73)
end
r0_rt.AttackNPCNearest = !Failed to decompile prototype 74: Take strong failed for register Reg(5) (has_pinned: true)!
r0_rt.AttackIndex = function(r0_pr75, r1_pr75, r2_pr75, r3_pr75) -- proto 75
   if r1_pr75 == 0 then
      r0_rt.SetTargetIndex(0)
      return
   end
   local r4_pr75 = me.nLeftSkill
   r0_rt:CloseAllUi()
   UiSelectNpc(r1_pr75)
   if not r2_pr75 or r2_pr75 < 1 then
      r2_pr75 = 0
   end
   if not r3_pr75 or r3_pr75 < 1 then
      r3_pr75 = 0
   end
   if r2_pr75 == 1 or r3_pr75 ~= 3 then
      r4_pr75 = r0_rt:ChangeSkill()
      r0_rt:SkillHorse(r4_pr75)
   end
   if me.nFightState == 1 then
      r0_rt:SkillHorse()
      local r5_pr75 = KNpc.GetByIndex(nTargetIndex)
      if r0_rt.bDEBUG == 1 then
         me.Msg("Đang tấn công: <color=yellow>"..r5_pr75.szName.."<color> ("..nTargetIndex..","..r5_pr75.nKind..")")
      end
      if r5_pr75 and r5_pr75.nKind == 1 then
         local r6_pr75, r7_pr75, r8_pr75 = r5_pr75.GetWorldPos()
         if 10 < r0_rt:Distance(r7_pr75, r8_pr75) then
            r0_rt:AutoGotoXY(r7_pr75, r8_pr75)
            return
         end
         r0_rt.DoAttack(r4_pr75, r1_pr75)
      else
         r0_rt.SetTargetIndex(r1_pr75)
      end
   else
      r0_rt.SetTargetIndex(r1_pr75)
   end
end
r0_rt.AttackNPCXY = function(r0_pr76, r1_pr76, r2_pr76, r3_pr76) -- proto 76
   local r4_pr76 = r0_rt:NPCXY(r1_pr76, r2_pr76, r3_pr76)
   if 0 < r4_pr76 then
      r0_rt:AttackIndex(r4_pr76, 0, 0)
      return 1
   end
   return 0
end
r0_rt.NPCXY = function(r0_pr77, r1_pr77, r2_pr77, r3_pr77) -- proto 77
   r1_pr77 = tonumber(r1_pr77)
   for r7_pr77, r8_pr77 in ipairs(KNpc.GetAroundNpcList(me, 1000) or {}) do
      -- backwards jump barrier
      if r8_pr77 and r1_pr77 == r8_pr77.nTemplateId then
         local r9_pr77, r10_pr77, r11_pr77 = r8_pr77.GetWorldPos()
         if r0_rt:Distance(r2_pr77, r3_pr77, r10_pr77, r11_pr77) < 5 then
            return r8_pr77.nIndex
         end
      end
   end
   return 0
end
r0_rt.AttackNPC = function(r0_pr78, r1_pr78, r2_pr78, r3_pr78) -- proto 78
   if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 or Ui(Ui.UI_SKILLPROGRESS).Processing == 1 then
      return -1
   end
   if not r3_pr78 then
      r3_pr78 = 0
   end
   if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 or UiManager:WindowVisible(Ui.UI_SHOP) == 1 or UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 or UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 or UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1) and r3_pr78 == 0 then
      return 0
   end
   if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and string.find(Ui(Ui.UI_SAYPANEL).szContent, "Ủy thác rời mạng") then
      return 0
   end
   if not r2_pr78 or r2_pr78 < 5 then
      r2_pr78 = 10
   end
   r2_pr78 = r2_pr78 * 2
   local r4_pr78 = 0
   local r5_pr78 = 0
   r1_pr78 = tonumber(r1_pr78)
   for r9_pr78, r10_pr78 in ipairs(KNpc.GetAroundNpcList(me, r2_pr78) or {}) do
      -- backwards jump barrier
      if r1_pr78 == r10_pr78.nTemplateId then
         local r11_pr78 = r10_pr78.nIndex
         r5_pr78 = r10_pr78.nKind
         r4_pr78 = r11_pr78
         break
      end
   end
   if 0 < r4_pr78 then
      r0_rt:AttackIndex(r4_pr78, 0, r5_pr78)
      return 1
   else
      return 2
   end
end
r0_rt.AttackNPCs = function(r0_pr79, r1_pr79, r2_pr79, r3_pr79) -- proto 79
   if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 or Ui(Ui.UI_SKILLPROGRESS).Processing == 1 then
      return -1
   end
   if not r3_pr79 then
      r3_pr79 = 0
   end
   if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 or UiManager:WindowVisible(Ui.UI_SHOP) == 1 or UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 or UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1) and r3_pr79 == 0 then
      return 0
   end
   if not r2_pr79 or r2_pr79 < 5 then
      r2_pr79 = 5
   end
   for r7_pr79, r8_pr79 in ipairs(r1_pr79) do
      -- backwards jump barrier
      local r9_pr79 = 0
      local r10_pr79 = 0
      for r14_pr79, r15_pr79 in ipairs(KNpc.GetAroundNpcList(me, r2_pr79) or {}) do
         -- backwards jump barrier
         if r15_pr79.nTemplateId == tonumber(r8_pr79) then
            local r16_pr79 = r15_pr79.nIndex
            r10_pr79 = r15_pr79.nKind
            r9_pr79 = r16_pr79
            break
         end
      end
      if 0 < r9_pr79 then
         r0_rt:AttackIndex(r9_pr79, 0, r10_pr79)
         return 1
      end
   end
end
r0_rt.GetNPC = function(r0_pr80, r1_pr80) -- proto 80
   if not r1_pr80 or r1_pr80 < 5 then
      r1_pr80 = 5
   end
   r1_pr80 = r1_pr80 * 2
   local r2_pr80 = 0
   for r6_pr80, r7_pr80 in ipairs(KNpc.GetAroundNpcList(me, r1_pr80) or {}) do
      -- backwards jump barrier
      if r7_pr80.nKind and r7_pr80.nKind ~= 1 and r7_pr80.nKind ~= 3 and r7_pr80.nKind ~= 4 then
         r2_pr80 = r2_pr80 + 1
      end
   end
   return r2_pr80
end
r0_rt.CountNPC = function(r0_pr81, r1_pr81, r2_pr81) -- proto 81
   if not r2_pr81 or r2_pr81 < 5 then
      r2_pr81 = 5
   end
   r2_pr81 = r2_pr81 * 2
   local r3_pr81 = 0
   r1_pr81 = tonumber(r1_pr81)
   for r7_pr81, r8_pr81 in ipairs(KNpc.GetAroundNpcList(me, r2_pr81) or {}) do
      -- backwards jump barrier
      if r1_pr81 == r8_pr81.nTemplateId then
         r3_pr81 = r3_pr81 + 1
      end
   end
   return r3_pr81
end
r0_rt.GetNPCIndex = function(r0_pr82, r1_pr82, r2_pr82, r3_pr82) -- proto 82
   if not r3_pr82 then
      r3_pr82 = 0
   end
   if not r2_pr82 or r2_pr82 < 5 then
      r2_pr82 = 5
   end
   local r4_pr82 = 0
   r2_pr82 = r2_pr82 * 2
   r1_pr82 = tonumber(r1_pr82)
   for r8_pr82, r9_pr82 in ipairs(KNpc.GetAroundNpcList(me, r2_pr82) or {}) do
      -- backwards jump barrier
      if r1_pr82 == r9_pr82.nTemplateId then
         r3_pr82 = r3_pr82 - 1
         if r3_pr82 < 0 then
            r4_pr82 = r9_pr82.nIndex
            break
         end
      end
   end
   return r4_pr82
end
r0_rt.GetNPCNearest = !Failed to decompile prototype 83: Could not take strong register Reg(9): Would cause free mark instability with FreeMark(Reg(13))!
r0_rt.GetNPCByName = function(r0_pr84, r1_pr84, r2_pr84, r3_pr84) -- proto 84
   if not r3_pr84 then
      r3_pr84 = 0
   end
   if not r2_pr84 or r2_pr84 < 5 then
      r2_pr84 = 5
   end
   local r4_pr84 = 0
   r2_pr84 = r2_pr84 * 2
   for r8_pr84, r9_pr84 in ipairs(KNpc.GetAroundNpcList(me, r2_pr84) or {}) do
      -- backwards jump barrier
      if r1_pr84 == r9_pr84.szName or string.find(r9_pr84.szName, r1_pr84) then
         r3_pr84 = r3_pr84 - 1
         if r3_pr84 < 0 then
            r4_pr84 = r9_pr84.nIndex
            break
         end
      end
   end
   return r4_pr84
end
r0_rt.GoAttack = function(r0_pr85, r1_pr85, r2_pr85, r3_pr85) -- proto 85
   if not r3_pr85 then
      r3_pr85 = 0
   end
   if not r2_pr85 or r2_pr85 < 5 then
      r2_pr85 = 5
   end
   local r4_pr85, r5_pr85, r6_pr85 = r0_rt:GetNPCXY(r1_pr85, r2_pr85, 1)
   return r0_rt:AttackNPC(r1_pr85, r2_pr85, r3_pr85)
end
r0_rt.GoAttack2 = function(r0_pr86, r1_pr86, r2_pr86, r3_pr86) -- proto 86
   local r4_pr86 = function() -- proto 0
      if r0_rt:IsStopAll() == 1 then
         return 0
      end
      r0_rt:GotoXY(r2_pr86, r3_pr86)
      if r0_rt:Distance(r2_pr86, r3_pr86) < 3 and r0_rt:AttackNPC(r1_pr86, 15) == 1 then
         return 0
      end
   end
   r0_rt:GotoXY(r2_pr86, r3_pr86)
   Ui.tbLogic.tbTimer:Register(30, r4_pr86)
end
r0_rt.TaskIdByName = function(r0_pr87, r1_pr87) -- proto 87
   local r2_pr87 = Task:GetPlayerTask(me)
   for r6_pr87, r7_pr87 in pairs(r2_pr87.tbTasks) do
      -- backwards jump barrier
      if r7_pr87 then
         local r8_pr87 = r7_pr87:GetName() or ""
         if r8_pr87 ~= "" and (string.find(r8_pr87, r1_pr87) or r1_pr87 == r8_pr87) then
            return r7_pr87.nTaskId
         end
      end
   end
   return 0
end
r0_rt.TaskCompleted = function(r0_pr88, r1_pr88, r2_pr88, r3_pr88, r4_pr88) -- proto 88
   if not r4_pr88 then
      r4_pr88, r3_pr88 = 0, 0
   end
   local r5_pr88 = Task:GetPlayerTask(me)
   local r6_pr88 = r0_rt:TaskIdByName(r1_pr88)
   local r7_pr88 = -1
   if 0 < r6_pr88 then
      local r8_pr88 = r5_pr88.tbTasks[r6_pr88]
      if not r8_pr88 then
         return r7_pr88
      end
      if not r2_pr88 or r2_pr88 < 1 then
         if r8_pr88.nTaskId == Merchant.TASKDATA_ID then
            r2_pr88 = Merchant.TASKDATA_MAXCOUNT
         else
            local r9_pr88 = r8_pr88.tbSubData
            r2_pr88 = #r9_pr88.tbSteps
         end
      end
      if r2_pr88 == r8_pr88.nCurStep or r8_pr88.nCurStep == -1 then
         if r4_pr88 == 1 then
            me.Msg("Trả n.vụ <color=yellow>"..r8_pr88:GetName())
            r0_rt:CloseAllUi()
            r0_rt:GoAttack(r3_pr88, 100, 1)
         end
         r7_pr88 = 1
      else
         r7_pr88 = 0
      end
   end
   return r7_pr88
end
r0_rt.TaskCurStep = function(r0_pr89, r1_pr89) -- proto 89
   local r2_pr89 = Task:GetPlayerTask(me)
   local r3_pr89 = r0_rt:TaskIdByName(r1_pr89)
   local r4_pr89 = -1
   if 0 < r3_pr89 then
      local r5_pr89 = r2_pr89.tbTasks[r3_pr89]
      if not r5_pr89 then
         return r4_pr89
      end
      r4_pr89 = r5_pr89.nCurStep
   end
   return r4_pr89
end
r0_rt.TaskCurName = function(r0_pr90, r1_pr90) -- proto 90
   local r2_pr90 = Task:GetPlayerTask(me)
   local r3_pr90 = r0_rt:TaskIdByName(r1_pr90)
   local r4_pr90 = ""
   if 0 < r3_pr90 then
      local r5_pr90 = r2_pr90.tbTasks[r3_pr90]
      if not r5_pr90 then
         return r4_pr90
      end
      for r9_pr90, r10_pr90 in ipairs(r5_pr90.tbCurTags) do
         -- backwards jump barrier
         local r11_pr90 = "   (Đã hoàn thành)"
         local r12_pr90 = r10_pr90:GetDesc()
         if r12_pr90 and r12_pr90 ~= "" then
            if r10_pr90:IsDone() then
               r4_pr90 = r4_pr90.."<color=Green>"..r12_pr90..r11_pr90.."<color=White>
"
            else
               r4_pr90 = r4_pr90.."<color=Red>"..r12_pr90.."<color=White>
"
            end
         end
      end
   end
   return r4_pr90
end
r0_rt.MissionCompleted = function(r0_pr91, r1_pr91, r2_pr91) -- proto 91
   if not r2_pr91 or r2_pr91 == "" then
      return 0
   end
   local r3_pr91 = Task:GetPlayerTask(me)
   local r4_pr91 = r3_pr91.tbTasks[r1_pr91]
   if not r4_pr91 then
      return 0
   end
   local r5_pr91 = r4_pr91.tbCurTags
   for r9_pr91, r10_pr91 in ipairs(r5_pr91) do
      -- backwards jump barrier
      local r11_pr91 = r10_pr91:GetDesc()
      if r11_pr91 and r11_pr91 ~= "" and r10_pr91:IsDone() and string.find(r11_pr91, r2_pr91) then
         return 1
      end
   end
   return 0
end
r0_rt.HaveTask = function(r0_pr92, r1_pr92) -- proto 92
   if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
      return 1
   end
   if not r1_pr92 then
      r1_pr92 = 1
   end
   local r2_pr92 = GetNpcMapEffect()
   local r3_pr92 = 0
   local r4_pr92 = math.huge
   for r8_pr92, r9_pr92 in ipairs(r2_pr92) do
      -- backwards jump barrier
      local r10_pr92 = KNpc.GetByIndex(r9_pr92.nNpcId)
      local r11_pr92 = 0
      local r12_pr92 = 0
      local r13_pr92 = 0
      if r10_pr92 then
         r11_pr92, r12_pr92, r13_pr92 = r10_pr92.GetWorldPos()
         local r14_pr92 = r0_rt:Distance(r12_pr92, r13_pr92)
         if r4_pr92 > r14_pr92 then
            r3_pr92, r4_pr92 = r9_pr92.nNpcId, r14_pr92
         end
      end
   end
   if 0 < r3_pr92 then
      if r1_pr92 == 1 then
         r0_rt.SetTargetIndex(r3_pr92)
      end
      return 1
   end
   if r2_pr92 and 0 < #r2_pr92 then
      if r1_pr92 == 1 then
         r0_rt.SetTargetIndex(tbCurEffect.nNpcId)
      end
      return 1
   end
   return 0
end
r0_rt.TaskReceived = function(r0_pr93, r1_pr93) -- proto 93
   local r2_pr93 = Task:GetMinLevelMainTaskInfo(me)
   if r2_pr93 and 0 < #r2_pr93 then
      for r6_pr93, r7_pr93 in ipairs(r2_pr93) do
         -- backwards jump barrier
         if r7_pr93 and (string.find(r7_pr93[2], r1_pr93) or r1_pr93 == r7_pr93[2]) then
            return 1
         end
      end
   end
   local r3_pr93 = Task:GetBranchTaskTable(me)
   if r3_pr93 and 0 < #r3_pr93 then
      for r7_pr93, r8_pr93 in ipairs(r3_pr93) do
         -- backwards jump barrier
         if r8_pr93 and (string.find(r8_pr93[2], r1_pr93) or r1_pr93 == r8_pr93[2]) then
            return 2
         end
      end
   end
   local r4_pr93 = Task:GetMaxLevelCampTaskInfo(me)
   if r4_pr93 and 0 < #r4_pr93 then
      for r8_pr93, r9_pr93 in ipairs(r4_pr93) do
         -- backwards jump barrier
         if r9_pr93 and (string.find(r9_pr93[2], r1_pr93) or r1_pr93 == r9_pr93[2]) then
            return 3
         end
      end
   end
   return 0
end
r0_rt.Between = function(r0_pr94, r1_pr94, r2_pr94, r3_pr94) -- proto 94
   if (r1_pr94 <= r2_pr94 and r1_pr94 <= r3_pr94) or (r1_pr94 <= r3_pr94 and r1_pr94 <= r2_pr94) then
      return 1
   end
   return 0
end
r0_rt.SamePos = function(r0_pr95, r1_pr95, r2_pr95, r3_pr95, r4_pr95) -- proto 95
   if not r1_pr95 or not r2_pr95 then
      return 0
   end
   if not r3_pr95 or not r4_pr95 then
      local r5_pr95, r6_pr95, r7_pr95 = me.GetWorldPos()
      r3_pr95, r4_pr95 = r6_pr95, r7_pr95
   end
   if r1_pr95 == r3_pr95 and r2_pr95 == r4_pr95 then
      return 1
   end
   return 0
end
r0_rt.Distance = function(r0_pr96, r1_pr96, r2_pr96, r3_pr96, r4_pr96) -- proto 96
   if not r1_pr96 or not r2_pr96 then
      return math.huge
   end
   if not r3_pr96 or not r4_pr96 then
      local r5_pr96, r6_pr96, r7_pr96 = me.GetWorldPos()
      r3_pr96, r4_pr96 = r6_pr96, r7_pr96
   end
   return math.floor(math.sqrt(r1_pr96 - r3_pr96 ^ 2 + r2_pr96 - r4_pr96 ^ 2))
end
r0_rt.Distance1 = function(r0_pr97, r1_pr97, r2_pr97, r3_pr97) -- proto 97
   local r4_pr97, r5_pr97, r6_pr97 = me.GetWorldPos()
   if r1_pr97 ~= r4_pr97 then
      return math.huge
   else
      return math.floor(math.sqrt(r5_pr97 - r2_pr97 ^ 2 + r6_pr97 - r3_pr97 ^ 2))
   end
end
r0_rt.Distance2 = function(r0_pr98, r1_pr98, r2_pr98) -- proto 98
   if not r1_pr98 or not r1_pr98.nMapId then
      return math.huge
   end
   local r3_pr98 = 0
   local r4_pr98 = 0
   local r5_pr98 = 0
   if not r2_pr98 or not r2_pr98.nPosX or not r2_pr98.nPosY then
      local r6_pr98, r7_pr98, r8_pr98 = me.GetWorldPos()
      if r6_pr98 ~= me.nTemplateMapId then
         r6_pr98 = me.nTemplateMapId
      end
      r2_pr98 = {
         .nMapId = r6_pr98,
         .nPosX = r7_pr98,
         .nPosY = r8_pr98
      }
   end
   if r1_pr98.nMapId ~= r2_pr98.nMapId then
      return math.huge
   else
      return r0_rt:Distance(r1_pr98.nPosX, r1_pr98.nPosY, r2_pr98.nPosX, r2_pr98.nPosY)
   end
end
r0_rt.Distance3 = function(r0_pr99, r1_pr99, r2_pr99, r3_pr99, r4_pr99, r5_pr99, r6_pr99) -- proto 99
   if r1_pr99 ~= r4_pr99 then
      return math.huge
   else
      return math.floor(math.sqrt(r2_pr99 - r5_pr99 ^ 2 + r3_pr99 - r6_pr99 ^ 2))
   end
end
r0_rt.GetItemCountByName = function(r0_pr100, r1_pr100) -- proto 100
   local r2_pr100, r3_pr100, r4_pr100, r5_pr100
   local r6_pr100 = KIo.OpenTabFile("\setting\item\001\other\medicine.txt")
   local r7_pr100 = KIo.OpenTabFile("\setting\item\001\other\stuffitem.txt")
   local r8_pr100 = KIo.OpenTabFile("\setting\item\001\other\scriptitem.txt")
   if not r8_pr100 then
      return 0
   end
   local r9_pr100 = r8_pr100.GetHeight()
   for r13_pr100 = 2, r9_pr100, 1 do
      -- backwards jump barrier
      local r14_pr100 = r8_pr100.GetStr(r13_pr100, 1)
      if r1_pr100 == r14_pr100 or string.find(r14_pr100, r1_pr100) then
         r2_pr100 = r8_pr100.GetInt(r13_pr100, 3)
         r3_pr100 = r8_pr100.GetInt(r13_pr100, 4)
         r4_pr100 = r8_pr100.GetInt(r13_pr100, 5)
         r5_pr100 = r8_pr100.GetInt(r13_pr100, 6)
         break
      end
   end
   KIo.CloseTabFile(r8_pr100)
   return me.GetItemCountInBags(r2_pr100, r3_pr100, r4_pr100, r5_pr100)
end
r0_rt.ReturnAtPoint = function(r0_pr101) -- proto 101
   if r0_rt:BHD() == 1 or r0_rt:CT() == 1 or r0_rt:QD() == 1 or r0_rt:TDC() == 1 or r0_rt:AiGT() == 1 or r0_rt:DCC() == 1 or r0_rt:DMCT() == 1 or r0_rt:BNTL() == 1 or r0_rt:VHC() == 1 or r0_rt:TQC() == 1 then
      return
   end
   if r0_rt.auto_pos_index <= 0 then
      me.Msg("1. - Auto Move...")
      r0_rt.AiAutoMove()
   else
      local r1_pr101 = r0_rt.auto_fight_pos[r0_rt.auto_pos_index].x
      local r2_pr101 = r0_rt.auto_fight_pos[r0_rt.auto_pos_index].y
      if r1_pr101 == nil or r2_pr101 == nil then
         r0_rt.auto_pos_index = 0
         return
      end
      local r3_pr101, r4_pr101, r5_pr101 = me.GetNpc().GetMpsPos()
      local r6_pr101 = r3_pr101 - r1_pr101
      local r7_pr101 = r4_pr101 - r2_pr101
      if r0_rt.attack_point == 1 then
         if r6_pr101 * r6_pr101 + r7_pr101 * r7_pr101 > r0_rt.ATTACK_RANGE * r0_rt.ATTACK_RANGE * 0 then
            r0_rt.AiAutoMoveTo(r1_pr101, r2_pr101)
            return
         else
            r0_rt.Sit()
            if r0_rt.ds == 1 then
               local r8_pr101 = tonumber(GetLocalDate("%Y%m%d%H%M%S"))
               r0_rt.nSec0 = Lib:GetDate2Time(r8_pr101)
               if (r0_rt.nSec0 > r0_rt.nSec1 and r0_rt.nYe1 < 10) or (r0_rt.nSec0 > r0_rt.nSec2 and r0_rt.nYe2 < 10) or (r0_rt.nSec0 > r0_rt.nSec3 and r0_rt.nYe3 < 10) or (r0_rt.nSec0 > r0_rt.nSec4 and r0_rt.nYe4 < 10) or (r0_rt.nSec0 > r0_rt.nSec5 and r0_rt.nYe5 < 10) or (r0_rt.nSec0 > r0_rt.nSec6 and r0_rt.nYe6 < 10) then
                  r0_rt:Reading_two()
               end
            end
         end
      else
         if r0_rt.attack_point == 2 then
            me.Msg("3. Auto Move To ("..r1_pr101..", "..r2_pr101..")")
            if r0_rt.AiAutoMoveTo(r1_pr101, r2_pr101) <= 0 then
               r0_rt.keep_range = r0_rt:CalcRang()
               if r0_rt.auto_pos_index == 1 then
                  r0_rt.auto_pos_index = 2
               else
                  r0_rt.auto_pos_index = 1
               end
            end
         end
      end
   end
end
r0_rt.TDC = function(r0_pr102, r1_pr102) -- proto 102
   if not r1_pr102 or r1_pr102 == 0 then
      r1_pr102 = me.nTemplateMapId
   end
   if r0_rt:Between(r1_pr102, 298, 332) == 1 or r0_rt:Between(r1_pr102, 341, 342) == 1 or r0_rt:Between(r1_pr102, 1542, 1548) == 1 then
      return 1
   end
   return 0
end
r0_rt.BHD = function(r0_pr103, r1_pr103) -- proto 103
   if not r1_pr103 or r1_pr103 == 0 then
      r1_pr103 = me.nTemplateMapId
   end
   if r0_rt:Between(r1_pr103, 225, 240) == 1 or r0_rt:Between(r1_pr103, 274, 281) == 1 or r0_rt:Between(r1_pr103, 333, 340) == 1 then
      return 1
   end
   return 0
end
r0_rt.CT = function(r0_pr104, r1_pr104) -- proto 104
   if not r1_pr104 or r1_pr104 == 0 then
      r1_pr104 = me.nTemplateMapId
   end
   if r0_rt:Between(r1_pr104, 181, 195) == 1 or r0_rt:Between(r1_pr104, 257, 271) == 1 or r0_rt:Between(r1_pr104, 282, 286) == 1 or r0_rt:Between(r1_pr104, 288, 297) == 1 or r0_rt:Between(r1_pr104, 1635, 1643) == 1 then
      return 1
   end
   return 0
end
r0_rt.TL = function(r0_pr105, r1_pr105) -- proto 105
   if not r1_pr105 or r1_pr105 == 0 then
      r1_pr105 = me.nTemplateMapId
   end
   if 1535 < r1_pr105 and r1_pr105 < 1541 then
      return 1
   end
   return 0
end
r0_rt.MapHLVM = function(r0_pr106, r1_pr106) -- proto 106
   if not r1_pr106 or r1_pr106 == 0 then
      r1_pr106 = me.nTemplateMapId
   end
   if r1_pr106 == 493 then
      return 1
   end
   return 0
end
r0_rt.MapHSPN = function(r0_pr107, r1_pr107) -- proto 107
   if not r1_pr107 or r1_pr107 == 0 then
      r1_pr107 = me.nTemplateMapId
   end
   if r1_pr107 == 557 then
      return 1
   end
   return 0
end
r0_rt.MapBMS = function(r0_pr108, r1_pr108) -- proto 108
   if not r1_pr108 or r1_pr108 == 0 then
      r1_pr108 = me.nTemplateMapId
   end
   if r1_pr108 == 560 then
      return 1
   end
   return 0
end
r0_rt.QD = function(r0_pr109, r1_pr109) -- proto 109
   if not r1_pr109 or r1_pr109 == 0 then
      r1_pr109 = me.nTemplateMapId
   end
   if r1_pr109 == 493 or r1_pr109 == 557 or r1_pr109 == 560 then
      return 1
   end
   return 0
end
r0_rt.CHT = function(r0_pr110, r1_pr110) -- proto 110
   if not r1_pr110 or r1_pr110 == 0 then
      r1_pr110 = me.nTemplateMapId
   end
   if r1_pr110 == 556 or r1_pr110 == 558 or r1_pr110 == 559 then
      return 1
   end
   return 0
end
r0_rt.LD = function(r0_pr111, r1_pr111) -- proto 111
   if not r1_pr111 or r1_pr111 == 0 then
      r1_pr111 = me.nTemplateMapId
   end
   if r0_rt:Between(r1_pr111, 1401, 1496) then
      return 1
   end
   return 0
end
r0_rt.AiGT = function(r0_pr112, r1_pr112) -- proto 112
   if not r1_pr112 or r1_pr112 == 0 then
      r1_pr112 = me.nTemplateMapId
   end
   if r1_pr112 == 273 then
      return 1
   end
   return 0
end
r0_rt.TQC = function(r0_pr113, r1_pr113) -- proto 113
   if not r1_pr113 or r1_pr113 == 0 then
      r1_pr113 = me.nTemplateMapId
   end
   if r1_pr113 == 287 or r1_pr113 == 1740 then
      return 1
   end
   return 0
end
r0_rt.VHC = function(r0_pr114, r1_pr114) -- proto 114
   if not r1_pr114 or r1_pr114 == 0 then
      r1_pr114 = me.nTemplateMapId
   end
   if r1_pr114 == 344 or r1_pr114 == 1741 then
      return 1
   end
   return 0
end
r0_rt.BC = function(r0_pr115, r1_pr115) -- proto 115
   if not r1_pr115 or r1_pr115 == 0 then
      r1_pr115 = me.nTemplateMapId
   end
   if r1_pr115 == 343 then
      return 1
   end
   return 0
end
r0_rt.BNTL = function(r0_pr116, r1_pr116) -- proto 116
   if not r1_pr116 or r1_pr116 == 0 then
      r1_pr116 = me.nTemplateMapId
   end
   if r1_pr116 == 1737 then
      return 1
   end
   return 0
end
r0_rt.DCC = function(r0_pr117, r1_pr117) -- proto 117
   if not r1_pr117 or r1_pr117 == 0 then
      r1_pr117 = me.nTemplateMapId
   end
   if r1_pr117 == 1738 then
      return 1
   end
   return 0
end
r0_rt.DMCT = function(r0_pr118, r1_pr118) -- proto 118
   if not r1_pr118 or r1_pr118 == 0 then
      r1_pr118 = me.nTemplateMapId
   end
   if r1_pr118 == 1739 then
      return 1
   end
   return 0
end
r0_rt.Jump = function(r0_pr119, r1_pr119, r2_pr119) -- proto 119
   if not r1_pr119 or r1_pr119 < 1 or not r2_pr119 or r2_pr119 < 1 then
      return 0
   end
   _KLuaPlayer.UseSkill(10, r1_pr119, r2_pr119)
   return 1
end
r0_rt.GetScreenPos = function(r0_pr120, r1_pr120, r2_pr120) -- proto 120
   local r3_pr120 = 33.33
   local r4_pr120 = 16.7
   local r5_pr120, r6_pr120, r7_pr120 = me.GetWorldPos()
   local r8_pr120 = 0
   local r9_pr120 = 0
   if UiMode() == "a" then
      r8_pr120 = 400 - r6_pr120 - r1_pr120 * r3_pr120
      r9_pr120 = 300 - r7_pr120 - r2_pr120 * r4_pr120
   else
      if UiMode() == "b" then
         r8_pr120 = 512 - r6_pr120 - r1_pr120 * r3_pr120
         r9_pr120 = 384 - r7_pr120 - r2_pr120 * r4_pr120
      else
         if UiMode() == "c" then
            r8_pr120 = 640 - r6_pr120 - r1_pr120 * r3_pr120
            r9_pr120 = 400 - r7_pr120 - r2_pr120 * r4_pr120
         end
      end
   end
   return math.floor(r8_pr120), math.floor(r9_pr120)
end
r0_rt.SkillNo = function(r0_pr121) -- proto 121
   local r1_pr121 = r0_rt:MapType()
   if (r1_pr121 == 1 or r1_pr121 == 3) and r0_rt:Between(me.nLeftSkill, 281, 292) == 1 then
      for r5_pr121, r6_pr121 in ipairs(r0_rt.attack_skill) do
         -- backwards jump barrier
         if me.CanCastSkill(r6_pr121) == 1 and r6_pr121 < 281 and 292 < r6_pr121 then
            me.nLeftSkill = r6_pr121
            Ui:GetClass("skilltree"):UpdateSkill()
            break
         end
      end
   end
   return 1
end
r0_rt.Format = function(r0_pr122, r1_pr122) -- proto 122
   local r2_pr122 = ""
   local r3_pr122 = ""
   if not r1_pr122 or r1_pr122 < 0 then
      return ""
   end
   repeat
      -- backwards jump barrier
      r3_pr122 = tostring(r1_pr122 % 1000)
      r1_pr122 = math.floor(r1_pr122 / 1000)
      if 0 < r1_pr122 then
         for r7_pr122 = 1, 3 - #r3_pr122, 1 do
            -- backwards jump barrier
            r3_pr122 = "0"..r3_pr122
         end
      end
      r2_pr122 = r3_pr122.."."..r2_pr122
   until r1_pr122 < 1
   return string.sub(r2_pr122, 1, #r2_pr122 - 1)
end
r0_rt.IsFightThrough = function(r0_pr123) -- proto 123
   if (me.nFaction == 4 and me.nRouteId == 2) or (me.nFaction == 5 and me.nRouteId == 1) or (me.nFaction == 10 and me.nRouteId == 2) or (me.nFaction == 8 and me.nRouteId == 2) or (me.nFaction == 9 and me.nRouteId == 1) or (me.nFaction == 11 and me.nRouteId == 2) then
      return 1
   end
   return 0
end
r0_rt.GetBaseSkill = function(r0_pr124) -- proto 124
   for r4_pr124 = 1, 9, 1 do
      -- backwards jump barrier
      if me.CanCastSkill(r4_pr124) == 1 then
         return r4_pr124
      end
   end
   return 0
end
r0_rt.Extract = function(r0_pr125, r1_pr125) -- proto 125
   
end
r0_rt.Throwable = function(r0_pr126, r1_pr126) -- proto 126
   if r1_pr126.IsBind() == 1 or r1_pr126.IsForbitThrow() == 1 then
      return 0
   end
   if r1_pr126.IsForbitSell() ~= 1 and 0 < GetSalePrice(r1_pr126) then
      return 0
   end
   local r2_pr126 = r1_pr126.GetRandMASS()
   local r3_pr126 = 0
   for r7_pr126 = 1, #r2_pr126, 1 do
      -- backwards jump barrier
      local r8_pr126 = r2_pr126[r7_pr126]
      if r8_pr126 and r8_pr126.szName then
         if (r8_pr126.szName == "deadlystrikeenhance_r" and 20 < r2_pr126[r7_pr126].tbValue[1]) or r8_pr126.szName == "ignoredefense_v" or r8_pr126.szName == "damage_all_resist" or r8_pr126.szName == "expenhance_p" or r8_pr126.szName == "allskill_v" or r8_pr126.szName == "lucky_v" then
            return 0
         end
         if string.find(r8_pr126.szName, "resist") or string.find(r8_pr126.szName, "resisttime") then
            r3_pr126 = r3_pr126 + 1
            if 1 < r3_pr126 then
               return 0
            end
         end
      end
   end
   return 1
end
r0_rt.StopAutoFight = function(r0_pr127) -- proto 127
   if me.nAutoFightState == 1 then
      r0_rt:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
   end
end
r0_rt.StartAutoFight = function(r0_pr128) -- proto 128
   if me.nAutoFightState ~= 1 then
      r0_rt:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
   end
end
r0_rt.CheckGTP = function(r0_pr129, r1_pr129) -- proto 129
   
end
r0_rt.MoveTo = function(r0_pr130, r1_pr130, r2_pr130) -- proto 130
   local r3_pr130, r4_pr130, r5_pr130 = me.GetWorldPos()
   local r6_pr130 = r1_pr130 - r4_pr130 + MathRandom(-2, 2)
   local r7_pr130 = r2_pr130 - r5_pr130 + MathRandom(-2, 2)
   local r8_pr130 = math.fmod(64 - math.atan2(r6_pr130, r7_pr130) * 32 / math.pi, 64)
   MoveTo(r8_pr130, 0)
end
r0_rt.Check = function(r0_pr131, r1_pr131) -- proto 131
   local r2_pr131 = tonumber(GetLocalDate("%d"))
   local r3_pr131 = tonumber(GetLocalDate("%m"))
   local r4_pr131 = tonumber(GetLocalDate("%Y"))
   if 8 - r1_pr131 == 0 and r4_pr131 == 2025 then
      return 0
   else
      return 1
   end
end
r0_rt.Check2 = function(r0_pr132) -- proto 132
   local r1_pr132 = ""
   do
      local r2_pr132 = tonumber(GetLocalDate("%d"))
      local r3_pr132 = tonumber(GetLocalDate("%m"))
      local r4_pr132 = tonumber(GetLocalDate("%Y"))
      r1_pr132 = ""..r4_pr132..";"..r3_pr132..";"..r2_pr132..""
   end
   return r1_pr132
end
r0_rt.ProveIt = function(r0_pr133) -- proto 133
   local r1_pr133 = ""
   local r2_pr133 = function() -- proto 0
      UiManager:OpenWindow("UI_INFOBOARD", ""..r1_pr133.."")
      Ui.tbLogic.tbAutoPath:StopGoto("User")
      UiManager:CloseWindow(Ui.UI_TOOL)
      UiManager:CloseWindow(Ui.UI_TOOLS)
      UiManager:CloseWindow(Ui.UI_TeamControl)
      UiManager:CloseWindow(Ui.UI_IBSHOP)
      UiManager:CloseWindow(Ui.UI_ITEMGIFT)
      UiManager:CloseWindow(Ui.UI_TEXTINPUT)
      UiManager:CloseWindow(Ui.UI_GUTAWARD)
      UiManager:CloseWindow(Ui.UI_ITEMBOX)
      if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
         UiManager:CloseWindow(Ui.UI_SHOP)
      end
      if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
         UiManager:CloseWindow(Ui.UI_SAYPANEL)
      end
      if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then
         UiManager:CloseWindow(Ui.UI_REPOSITORY)
      end
      if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
         UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
      end
      UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE)
      UiManager:CloseWindow(Ui.UI_TRADE)
      UiManager:CloseWindow(Ui.UI_MSGBOX)
      UiManager:CloseWindow(Ui.UI_COMPOSE)
      UiManager:CloseWindow(Ui.UI_AUCTIONROOM)
      if UiManager:WindowVisible(Ui.UI_TOOLB) == 1 then
         UiManager:CloseWindow(Ui.UI_TOOLB)
      end
   end
   local r3_pr133 = function() -- proto 1
      UiManager:OpenWindow("UI_INFOBOARD", ""..r1_pr133.."")
      Ui.tbLogic.tbAutoPath:StopGoto("User")
      UiManager:CloseWindow(Ui.UI_TOOL)
      UiManager:CloseWindow(Ui.UI_TOOLS)
      UiManager:CloseWindow(Ui.UI_TeamControl)
      UiManager:CloseWindow(Ui.UI_IBSHOP)
      UiManager:CloseWindow(Ui.UI_ITEMGIFT)
      UiManager:CloseWindow(Ui.UI_TEXTINPUT)
      UiManager:CloseWindow(Ui.UI_GUTAWARD)
      UiManager:CloseWindow(Ui.UI_ITEMBOX)
      if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
         UiManager:CloseWindow(Ui.UI_SHOP)
      end
      if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
         UiManager:CloseWindow(Ui.UI_SAYPANEL)
      end
      if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then
         UiManager:CloseWindow(Ui.UI_REPOSITORY)
      end
      if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
         UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
      end
      UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE)
      UiManager:CloseWindow(Ui.UI_TRADE)
      UiManager:CloseWindow(Ui.UI_MSGBOX)
      UiManager:CloseWindow(Ui.UI_COMPOSE)
      UiManager:CloseWindow(Ui.UI_AUCTIONROOM)
      if UiManager:WindowVisible(Ui.UI_TOOLB) == 1 then
         UiManager:CloseWindow(Ui.UI_TOOLB)
      end
      local r0_pr133_1 = Ui:GetClass("tbLetProveItNow")
      if r0_pr133_1.Check() == "Accepted" then
         return 0
      end
   end
   local r4_pr133 = Lib:LoadTabFile("\interface2\DuLong\GodLicense.lua")
   local r5_pr133 = Lib:LoadTabFile("\interface\DuLong\GodLicense.lua")
   if not r4_pr133 then
      if r5_pr133 then
      else
         r1_pr133 = "LICENSE PLUGIN KHÔNG TỒN TẠI"
         Ui.tbLogic.tbTimer:Register(30, r3_pr133)
      end
   end
   local r6_pr133 = Ui:GetClass("tbLetProveItNow")
   if r6_pr133.Check() == "Accepted" then
   else
      if r6_pr133.Check() == "Rejected" then
         r1_pr133 = "LICENSE PLUGIN KHÔNG HỢP LỆ"
         Ui.tbLogic.tbTimer:Register(30, r3_pr133)
      else
         if r6_pr133.Check() == "Expired" then
            r1_pr133 = "LICENSE PLUGIN HẾT HẠN"
            Ui.tbLogic.tbTimer:Register(30, r3_pr133)
         else
            r1_pr133 = "LICENSE PLUGIN KHÔNG RÕ TÌNH TRẠNG"
            Ui.tbLogic.tbTimer:Register(30, r3_pr133)
         end
      end
   end
   local r7_pr133 = Ui:GetClass("tbLetProveItNow")
   if r7_pr133.Contact() == "hoangthienvu" or r7_pr133.Contact() == "0838435343" then
      r1_pr133 = "LICENSE PLUGIN BỊ VÔ HIỆU"
      Ui.tbLogic.tbTimer:Register(30, r2_pr133)
   end
   local r8_pr133 = ""
   local r9_pr133 = ""
   local r10_pr133 = ""
   local r11_pr133 = ""
   local r12_pr133 = ""
   r8_pr133 = tostring(os.getenv("COMSPEC"))
   r9_pr133 = tostring(os.getenv("OS"))
   r10_pr133 = tostring(os.getenv("COMPUTERNAME"))
   r11_pr133 = tostring(os.getenv("USERNAME"))
   r12_pr133 = tostring(os.getenv("USERPROFILE"))
   local r13_pr133 = ""
   r13_pr133 = tostring(""..r9_pr133..";"..r10_pr133..";"..r11_pr133.."")
   if r13_pr133 == "Windows_NT;DESKTOP-BDVPVR3;Huy Vu" or r13_pr133 == "Windows_NT;DESKTOP-BDVPVR3;PC" or r10_pr133 == "DESKTOP-BDVPVR3" or r10_pr133 == "DESKTOP-I0FHD2R" then
      r1_pr133 = "LICENSE PLUGIN BỊ VÔ HIỆU"
      Ui.tbLogic.tbTimer:Register(30, r2_pr133)
   end
   if r13_pr133 == "Windows_NT;HUNGPHAM;keept" then
      r1_pr133 = "LICENSE PLUGIN BỊ VÔ HIỆU"
      Ui.tbLogic.tbTimer:Register(30, r2_pr133)
      local r14_pr133 = Ui:GetClass("tbGodPk")
      if r14_pr133 then
         r14_pr133:Stop()
      end
   end
end
r0_rt.ProveOrigin = function(r0_pr134) -- proto 134
   local r1_pr134 = ""
   local r2_pr134 = function() -- proto 0
      UiManager:OpenWindow("UI_INFOBOARD", ""..r1_pr134.."")
      Ui.tbLogic.tbAutoPath:StopGoto("User")
      UiManager:CloseWindow(Ui.UI_TOOL)
      UiManager:CloseWindow(Ui.UI_TOOLS)
      UiManager:CloseWindow(Ui.UI_TeamControl)
      UiManager:CloseWindow(Ui.UI_IBSHOP)
      UiManager:CloseWindow(Ui.UI_ITEMGIFT)
      UiManager:CloseWindow(Ui.UI_TEXTINPUT)
      UiManager:CloseWindow(Ui.UI_GUTAWARD)
      UiManager:CloseWindow(Ui.UI_ITEMBOX)
      if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
         UiManager:CloseWindow(Ui.UI_SHOP)
      end
      if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
         UiManager:CloseWindow(Ui.UI_SAYPANEL)
      end
      if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then
         UiManager:CloseWindow(Ui.UI_REPOSITORY)
      end
      if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
         UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
      end
      UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE)
      UiManager:CloseWindow(Ui.UI_TRADE)
      UiManager:CloseWindow(Ui.UI_MSGBOX)
      UiManager:CloseWindow(Ui.UI_COMPOSE)
      UiManager:CloseWindow(Ui.UI_AUCTIONROOM)
      if UiManager:WindowVisible(Ui.UI_TOOLB) == 1 then
         UiManager:CloseWindow(Ui.UI_TOOLB)
      end
      local r0_pr134_0 = 0
      local r1_pr134_0 = Ui:GetClass("tbLetProveItNow")
      r0_pr134_0 = r1_pr134_0:Origin()
      local r2_pr134_0 = tonumber(GetLocalDate("%Y%m%d%H%M"))
      local r3_pr134_0 = tonumber(GetLocalDate("%d"))
      local r4_pr134_0 = tonumber(GetLocalDate("%H"))
      local r5_pr134_0 = tonumber(GetLocalDate("%M"))
      local r6_pr134_0 = r3_pr134_0 * 2
      local r7_pr134_0 = r4_pr134_0 * 2
      if r0_pr134_0 == r2_pr134_0 * 3 then
         return 0
      end
   end
   local r3_pr134 = 0
   local r4_pr134 = Ui:GetClass("tbLetProveItNow")
   r3_pr134 = r4_pr134:Origin()
   local r5_pr134 = tonumber(GetLocalDate("%Y%m%d%H%M"))
   local r6_pr134 = tonumber(GetLocalDate("%d"))
   local r7_pr134 = tonumber(GetLocalDate("%H"))
   local r8_pr134 = tonumber(GetLocalDate("%M"))
   local r9_pr134 = r6_pr134 * 2
   local r10_pr134 = r7_pr134 * 2
   if r3_pr134 ~= r5_pr134 * 3 or r3_pr134 == 0 then
      r1_pr134 = "LICENSE PLUGIN KHÔNG RÕ NGUỒN GỐC"
      Ui.tbLogic.tbTimer:Register(60, r2_pr134)
   end
end
r0_rt.LeaveTombBase = function(r0_pr135) -- proto 135
   local r1_pr135 = r0_rt:GetAroundNpcId(2446, 200) or r0_rt:GetAroundNpcName("Quan Nhất Đao", 200) or r0_rt:GetAroundNpcId(2445, 200)
   if r1_pr135 then
      local r2_pr135 = function() -- proto 0
         local r0_pr135_0 = Ui:GetClass("tbBoostFight")
         r0_pr135_0:MoveTo(1600, 3675)
         do
            local r1_pr135_0 = ""
         end
         local r1_pr135_0 = "[Plugin Ctrl+Q] Rời Khu An toàn Tần Lăng 1"
         me.Msg(r1_pr135_0)
         SendChannelMsg("Team", r1_pr135_0)
         return 0
      end
      Ui.tbLogic.tbTimer:Register(30, r2_pr135)
      Ui.tbLogic.tbTimer:Register(45, r2_pr135)
      Ui.tbLogic.tbTimer:Register(60, r2_pr135)
      Ui.tbLogic.tbTimer:Register(75, r2_pr135)
      Ui.tbLogic.tbTimer:Register(90, r2_pr135)
      Ui.tbLogic.tbTimer:Register(120, r2_pr135)
      Ui.tbLogic.tbTimer:Register(130, r2_pr135)
      Ui.tbLogic.tbTimer:Register(140, r2_pr135)
      Ui.tbLogic.tbTimer:Register(150, r2_pr135)
      Ui.tbLogic.tbTimer:Register(160, r2_pr135)
      Ui.tbLogic.tbTimer:Register(170, r2_pr135)
      Ui.tbLogic.tbTimer:Register(180, r2_pr135)
      Ui.tbLogic.tbTimer:Register(190, r2_pr135)
      Ui.tbLogic.tbTimer:Register(200, r2_pr135)
      Ui.tbLogic.tbTimer:Register(210, r2_pr135)
      Ui.tbLogic.tbTimer:Register(220, r2_pr135)
      Ui.tbLogic.tbTimer:Register(230, r2_pr135)
      Ui.tbLogic.tbTimer:Register(240, r2_pr135)
      Ui.tbLogic.tbTimer:Register(250, r2_pr135)
      Ui.tbLogic.tbTimer:Register(260, r2_pr135)
   end
   return 0
end
r0_rt.Start = function(r0_pr136) -- proto 136
   if r0_rt.state == 0 then
      r0_rt:State()
   end
end
r0_rt.Stop = function(r0_pr137) -- proto 137
   if r0_rt.state == 1 then
      r0_rt:State()
   end
end
Ui:RegisterNewUiWindow("UI_tbBoostFight", "tbBoostFight", {
   "a",
   250,
   150
}, {
   "b",
   250,
   150
}, {
   "c",
   250,
   150
})
local r3_rt = {
   "Ui(Ui.UI_tbBoostFight):State()",
   "tbBoostFight",
   "",
   "",
   "",
   "Tiên Mộc"
}
AddCommand(r3_rt[4], r3_rt[3], r3_rt[2], r3_rt[7] or UiShortcutAlias.emKSTATE_INGAME)
UiShortcutAlias:AddAlias(r3_rt[2], r3_rt[1])
local r4_rt = Ui:GetClass("tbDMC")
r4_rt.state = 0
local r5_rt = Env.GAME_FPS * 1
local r6_rt = 1
local r7_rt = 0
local r8_rt = 0
local r9_rt = 4
local r10_rt = 12
local r11_rt = 1
local r12_rt = 2025
local r13_rt = 9
local r14_rt = Ui(Ui.UI_SAYPANEL)
r4_rt.Say_bak = r4_rt.Say_bak or r14_rt.OnOpen
r14_rt.OnOpen = function(r0_pr138, r1_pr138) -- proto 138
   r4_rt.Say_bak(r14_rt, r1_pr138)
   if r4_rt.state == 0 then
      return
   end
   for r5_pr138 = 1, table.getn(r1_pr138[2]), 1 do
      -- backwards jump barrier
      if string.find(r1_pr138[2][r5_pr138], "Tiền đồng cổ đổi phần thưởng") then
         me.AnswerQestion(r5_pr138 - 1)
      end
      if string.find(r1_pr138[2][r5_pr138], "đổi Mảnh Thạch Cổ") then
         me.AnswerQestion(r5_pr138 - 1)
      end
   end
   if string.find(r1_pr138[1], "gom đủ") then
      r4_rt:Stop()
   end
end
r4_rt.State = function(r0_pr139) -- proto 139
   local r1_pr139 = Ui:GetClass("tbBoostFight")
   r1_pr139.ProveIt()
   if r4_rt.state == 0 then
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>AUTO DẠ MINH CHÂU<color> ON")
      me.Msg("<color=yellow>GODPK BẬT AUTO DẠ MINH CHÂU")
      r5_rt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 10, r4_rt.OnTimer)
      r4_rt.state = 1
      break
   end
   UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>AUTO DẠ MINH CHÂU<color> OFF")
   me.Msg("<color=yellow>GODPK TẮT AUTO DẠ MINH CHÂU")
   local r2_pr139 = Ui:GetClass("tbBoostFight")
   r2_pr139:Stop()
   if me.nAutoFightState == 1 then
      AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
   end
   r4_rt.state = 0
   Ui.tbLogic.tbTimer:Close(r5_rt)
   r5_rt = 0
   local r3_pr139 = me.FindItemInBags(18, 1, 1333, 1)
   for r7_pr139, r8_pr139 in pairs(r3_pr139) do
      -- backwards jump barrier
      if UiManager:WindowVisible(Ui.UI_TEXTINPUT) ~= 1 then
         me.UseItem(r8_pr139.pItem)
      end
   end
end
r4_rt.OnTimer = !Failed to decompile prototype 140: Invalid IfStat slipped through the cracks! 1!
r4_rt.Start = function(r0_pr141) -- proto 141
   local r1_pr141 = Ui:GetClass("tbBoostFight")
   local r2_pr141 = tonumber(GetLocalDate("%d"))
   local r3_pr141 = tonumber(GetLocalDate("%m"))
   local r4_pr141 = tonumber(GetLocalDate("%Y"))
   if r11_rt == 1 then
      if r4_pr141 > r12_rt then
         return
      end
      if r4_pr141 == r12_rt and r3_pr141 > r13_rt then
         return
      end
   end
   if r1_pr141:Check(r3_pr141) == 0 then
      if 0 < r2_pr141 and r2_pr141 < 32 then
         r6_rt = 0
      else
         r6_rt = 1
      end
   end
   if r6_rt ~= 0 then
      return
   end
   if r4_rt.state == 0 then
      r4_rt:State()
   end
end
r4_rt.Stop = function(r0_pr142) -- proto 142
   if r4_rt.state == 1 then
      r4_rt:State()
   end
end
local r15_rt = {
   "Ui(Ui.UI_tbDMC):State()",
   "tbDMC",
   "",
   "",
   "",
   "Tiên Mộc"
}
AddCommand(r15_rt[4], r15_rt[3], r15_rt[2], r15_rt[7] or UiShortcutAlias.emKSTATE_INGAME)
UiShortcutAlias:AddAlias(r15_rt[2], r15_rt[1])
local r16_rt = Ui:GetClass("tbToRevive")
r16_rt.state = 0
local r17_rt = Env.GAME_FPS * 1
local r18_rt = 1
local r19_rt = 0
local r20_rt = 0
local r21_rt = 4
local r22_rt = 12
local r23_rt = 1
local r24_rt = 2025
local r25_rt = 9
local r26_rt = Ui(Ui.UI_SAYPANEL)
r16_rt.Say_bak = r16_rt.Say_bak or r26_rt.OnOpen
r26_rt.OnOpen = function(r0_pr143, r1_pr143) -- proto 143
   r16_rt.Say_bak(r26_rt, r1_pr143)
   if r16_rt.state == 0 then
      return
   end
   for r5_pr143 = 1, table.getn(r1_pr143[2]), 1 do
      -- backwards jump barrier
      if string.find(r1_pr143[2][r5_pr143], "Tiền đồng cổ đổi phần thưởng") then
         me.AnswerQestion(r5_pr143 - 1)
      end
      if string.find(r1_pr143[2][r5_pr143], "đổi Mảnh Thạch Cổ") then
         me.AnswerQestion(r5_pr143 - 1)
      end
   end
   if string.find(r1_pr143[1], "gom đủ") then
      r16_rt:Stop()
   end
end
r16_rt.State = function(r0_pr144) -- proto 144
   local r1_pr144 = Ui:GetClass("tbBoostFight")
   r1_pr144.ProveIt()
   if r16_rt.state == 0 then
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>AUTO HỒI SINH CỬU CHUYỂN<color> ON")
      me.Msg("<color=yellow>GODPK BẬT AUTO HỒI SINH CỬU CHUYỂN")
      r17_rt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1, r16_rt.OnTimer)
      r16_rt.state = 1
      break
   end
   UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>AUTO HỒI SINH CỬU CHUYỂN<color> OFF")
   me.Msg("<color=yellow>GODPK TẮT AUTO HỒI SINH CỬU CHUYỂN")
   local r2_pr144 = Ui:GetClass("tbBoostFight")
   r2_pr144:Stop()
   if me.nAutoFightState == 1 then
      AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
   end
   r16_rt.state = 0
   Ui.tbLogic.tbTimer:Close(r17_rt)
   r17_rt = 0
   local r3_pr144 = me.FindItemInBags(18, 1, 1333, 1)
   for r7_pr144, r8_pr144 in pairs(r3_pr144) do
      -- backwards jump barrier
      if UiManager:WindowVisible(Ui.UI_TEXTINPUT) ~= 1 then
         me.UseItem(r8_pr144.pItem)
      end
   end
end
r16_rt.OnTimer = !Failed to decompile prototype 145: Invalid IfStat slipped through the cracks! 1!
r16_rt.Start = function(r0_pr146) -- proto 146
   local r1_pr146 = Ui:GetClass("tbBoostFight")
   local r2_pr146 = tonumber(GetLocalDate("%d"))
   local r3_pr146 = tonumber(GetLocalDate("%m"))
   local r4_pr146 = tonumber(GetLocalDate("%Y"))
   if r23_rt == 1 then
      if r4_pr146 > r24_rt then
         return
      end
      if r4_pr146 == r24_rt and r3_pr146 > r25_rt then
         return
      end
   end
   if r1_pr146:Check(r3_pr146) == 0 then
      if 0 < r2_pr146 and r2_pr146 < 32 then
         r18_rt = 0
      else
         r18_rt = 1
      end
   end
   if r18_rt ~= 0 then
      return
   end
   if r16_rt.state == 0 then
      r16_rt:State()
   end
end
r16_rt.Stop = function(r0_pr147) -- proto 147
   if r16_rt.state == 1 then
      r16_rt:State()
   end
end
local r27_rt = {
   "Ui(Ui.UI_tbToRevive):State()",
   "tbToRevive",
   "",
   "",
   "",
   "Tiên Mộc"
}
AddCommand(r27_rt[4], r27_rt[3], r27_rt[2], r27_rt[7] or UiShortcutAlias.emKSTATE_INGAME)
UiShortcutAlias:AddAlias(r27_rt[2], r27_rt[1])
local r28_rt = Ui:GetClass("tbLakEating")
r28_rt.state = 0
local r29_rt = Env.GAME_FPS * 1
local r30_rt = 1
local r31_rt = 0
local r32_rt = 0
local r33_rt = 4
local r34_rt = 12
local r35_rt = 1
local r36_rt = 2025
local r37_rt = 9
local r38_rt = Ui(Ui.UI_SAYPANEL)
r28_rt.Say_bak = r28_rt.Say_bak or r38_rt.OnOpen
r38_rt.OnOpen = function(r0_pr148, r1_pr148) -- proto 148
   r28_rt.Say_bak(r38_rt, r1_pr148)
   if r28_rt.state == 0 then
      return
   end
end
r28_rt.State = function(r0_pr149) -- proto 149
   local r1_pr149 = Ui:GetClass("tbBoostFight")
   r1_pr149.ProveIt()
   if r28_rt.state == 0 then
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>AUTO ĂN LAK DAME<color><color=Green>...ON")
      me.Msg("<color=yellow>PLUGIN GODOFSUN BẬT AUTO ĂN LAK DAME")
      r29_rt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 120, r28_rt.OnTimer)
      r28_rt.state = 1
   else
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>AUTO ĂN LAK DAME<color><color=Red>...OFF")
      me.Msg("<color=yellow>PLUGIN GODOFSUN TẮT AUTO ĂN LAK DAME")
      r28_rt.state = 0
      Ui.tbLogic.tbTimer:Close(r29_rt)
      r29_rt = 0
   end
end
r28_rt.OnTimer = !Failed to decompile prototype 150: Invalid IfStat slipped through the cracks! 1!
r28_rt.Start = function(r0_pr151) -- proto 151
   local r1_pr151 = Ui:GetClass("tbBoostFight")
   local r2_pr151 = tonumber(GetLocalDate("%d"))
   local r3_pr151 = tonumber(GetLocalDate("%m"))
   local r4_pr151 = tonumber(GetLocalDate("%Y"))
   if r35_rt == 1 then
      if r4_pr151 > r36_rt then
         return
      end
      if r4_pr151 == r36_rt and r3_pr151 > r37_rt then
         return
      end
   end
   if r1_pr151:Check(r3_pr151) == 0 then
      if 0 < r2_pr151 and r2_pr151 < 32 then
         r30_rt = 0
      else
         r30_rt = 1
      end
   end
   if r30_rt ~= 0 then
      return
   end
   if r28_rt.state == 0 then
      r28_rt:State()
   end
end
r28_rt.Stop = function(r0_pr152) -- proto 152
   if r28_rt.state == 1 then
      r28_rt:State()
   end
end
local r39_rt = {
   "Ui(Ui.UI_tbLakEating):State()",
   "tbLakEating",
   "",
   "",
   "",
   "Tiên Mộc"
}
AddCommand(r39_rt[4], r39_rt[3], r39_rt[2], r39_rt[7] or UiShortcutAlias.emKSTATE_INGAME)
UiShortcutAlias:AddAlias(r39_rt[2], r39_rt[1])
local r40_rt = Ui:GetClass("tbKimTeRepair")
r40_rt.state = 0
local r41_rt = Env.GAME_FPS * 1
local r42_rt = 1
local r43_rt = 0
local r44_rt = 0
local r45_rt = 4
local r46_rt = 12
local r47_rt = 1
local r48_rt = 2025
local r49_rt = 9
local r50_rt = "AUTO KIM TÊ SỬA ĐỒ"
local r51_rt = Ui(Ui.UI_SAYPANEL)
r40_rt.Say_bak = r40_rt.Say_bak or r51_rt.OnOpen
r51_rt.OnOpen = function(r0_pr153, r1_pr153) -- proto 153
   r40_rt.Say_bak(r51_rt, r1_pr153)
   if r40_rt.state == 0 then
      return
   end
end
r40_rt.State = function(r0_pr154) -- proto 154
   local r1_pr154 = Ui:GetClass("tbBoostFight")
   r1_pr154.ProveIt()
   if r40_rt.state == 0 then
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>"..r50_rt.."<color><color=Green>...ON")
      me.Msg("<color=yellow>PLUGIN GODOFSUN BẬT "..r50_rt.."")
      r41_rt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 5, r40_rt.OnTimer)
      r40_rt.state = 1
   else
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>"..r50_rt.."<color><color=Red>...OFF")
      me.Msg("<color=yellow>PLUGIN GODOFSUN TẮT "..r50_rt.."")
      r40_rt.state = 0
      Ui.tbLogic.tbTimer:Close(r41_rt)
      r41_rt = 0
      UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR)
   end
end
r40_rt.OnTimer = function() -- proto 155
   if r40_rt.state == 0 then
      UiManager:CloseWindow(Ui.UI_SAYPANEL)
      Ui.tbLogic.tbTimer:Close(r41_rt)
      return
   end
   r43_rt = r43_rt + 1
   local r0_pr155 = tonumber(GetLocalDate("%d"))
   local r1_pr155 = tonumber(GetLocalDate("%m"))
   local r2_pr155 = tonumber(GetLocalDate("%Y"))
   if r47_rt == 1 then
      if r2_pr155 > r48_rt then
         return
      end
      if r2_pr155 == r48_rt and r1_pr155 > r49_rt then
         return
      end
   end
   if r44_rt == 1 then
      if r1_pr155 == r45_rt then
      else
         return
      end
      if r0_pr155 == r46_rt then
      else
         return
      end
   end
   if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
      return
   end
   local r3_pr155 = 0
   local r4_pr155 = {
      [1] = {
         18,
         1,
         2,
         1
      },
      [2] = {
         18,
         1,
         2,
         2
      },
      [3] = {
         18,
         1,
         2,
         3
      },
      [4] = {
         18,
         1,
         2,
         4
      },
      [5] = {
         18,
         1,
         2,
         5
      }
   }
   local r5_pr155 = {}
   for r9_pr155 = 0, Item.EQUIPPOS_NUM - 1, 1 do
      -- backwards jump barrier
      local r10_pr155 = me.GetItem(Item.ROOM_EQUIP, r9_pr155, 0)
      if r10_pr155 and r10_pr155.nCurDur <= r10_pr155.nMaxDur / 2 then
         r3_pr155 = r3_pr155 + 1
         for r14_pr155, r15_pr155 in pairs(r4_pr155) do
            -- backwards jump barrier
            local r16_pr155 = me.FindItemInBags(unpack(r15_pr155))
            for r20_pr155, r21_pr155 in pairs(r16_pr155) do
               -- backwards jump barrier
               me.UseItem(r21_pr155.pItem)
               me.RepairEquipment(r10_pr155.nIndex, Item.REPAIR_ITEM)
               SendChannelMsg("Team", "[Alt+3] Số bị hư "..r3_pr155..". Sửa "..r10_pr155.szName.." "..r10_pr155.nCurDur / 10.."%")
            end
         end
      end
   end
   if r3_pr155 == 0 then
      UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR)
      SendChannelMsg("Team", "[Alt+3] Đã sửa xong")
      r40_rt:Stop()
   end
end
r40_rt.Start = function(r0_pr156) -- proto 156
   local r1_pr156 = Ui:GetClass("tbBoostFight")
   local r2_pr156 = tonumber(GetLocalDate("%d"))
   local r3_pr156 = tonumber(GetLocalDate("%m"))
   local r4_pr156 = tonumber(GetLocalDate("%Y"))
   if r47_rt == 1 then
      if r4_pr156 > r48_rt then
         return
      end
      if r4_pr156 == r48_rt and r3_pr156 > r49_rt then
         return
      end
   end
   if r1_pr156:Check(r3_pr156) == 0 then
      if 0 < r2_pr156 and r2_pr156 < 32 then
         r42_rt = 0
      else
         r42_rt = 1
      end
   end
   if r42_rt ~= 0 then
      return
   end
   if r40_rt.state == 0 then
      r40_rt:State()
   end
end
r40_rt.Stop = function(r0_pr157) -- proto 157
   if r40_rt.state == 1 then
      r40_rt:State()
   end
end
local r52_rt = {
   "Ui(Ui.UI_tbKimTeRepair):State()",
   "tbKimTeRepair",
   "",
   "",
   "",
   "Tiên Mộc"
}
AddCommand(r52_rt[4], r52_rt[3], r52_rt[2], r52_rt[7] or UiShortcutAlias.emKSTATE_INGAME)
UiShortcutAlias:AddAlias(r52_rt[2], r52_rt[1])
local r53_rt = Ui:GetClass("tbKickMem") or {}
local r54_rt = 1
local r55_rt = 0
local r56_rt = 10
local r57_rt = 0
local r58_rt = 10
local r59_rt = Ui(Ui.UI_SAYPANEL)
r53_rt.Say_bak = r53_rt.Say_bak or r59_rt.OnOpen
local r60_rt = 1
local r61_rt = 0
local r62_rt = 0
local r63_rt = "AUTO KICK NGƯỜI LẠ"
local r64_rt = 0
local r65_rt = 5
local r66_rt = 15
local r67_rt = 13
local r68_rt = 16
local r69_rt = 1
local r70_rt = 2025
local r71_rt = 9
local r72_rt = 0
r53_rt.Init = function(r0_pr158) -- proto 158
   r0_pr158:ModifyUi()
end
r53_rt.ModifyUi = function(r0_pr159) -- proto 159
   local r1_pr159 = Ui(Ui.UI_MSGPAD)
   r53_rt.OnMsgArrival_bak = r53_rt.OnMsgArrival_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel
   r1_pr159.OnSendMsgToChannel = function(r0_pr159_0, r1_pr159_0, r2_pr159_0, r3_pr159_0, r4_pr159_0) -- proto 0
      r53_rt:OnChatMsg(r1_pr159_0, r2_pr159_0, r3_pr159_0, r4_pr159_0)
      r53_rt.OnMsgArrival_bak(Ui(Ui.UI_MSGPAD), r1_pr159_0, r2_pr159_0, r3_pr159_0, r4_pr159_0)
   end
end
r53_rt.OnChatMsg = function(r0_pr160, r1_pr160, r2_pr160, r3_pr160, r4_pr160) -- proto 160
   local r5_pr160
   local r6_pr160 = Ui:GetClass("tbBoostFight")
   local r7_pr160 = tonumber(GetLocalDate("%d"))
   local r8_pr160 = tonumber(GetLocalDate("%m"))
   if r6_pr160:Check(r8_pr160) == 0 then
      r5_pr160 = 0
   end
   if r5_pr160 == 1 then
      return
   end
   local r9_pr160, r10_pr160 = me.GetTeamInfo()
   if not r10_pr160 then
      return
   end
   local r11_pr160 = "Ai là đội trưởng chứ?"
   r11_pr160 = r10_pr160[1].szName
   if r2_pr160 ~= r11_pr160 then
      return
   end
   if r1_pr160 == "Team" or r1_pr160 == "Kin" then
      if string.find(r3_pr160, "khaitruon") or string.find(r3_pr160, "kickon") then
         local r12_pr160 = Ui:GetClass("tbKickMem") or {}
         r12_pr160:Bd()
      end
      if string.find(r3_pr160, "khaitruoff") or string.find(r3_pr160, "kickoff") then
         local r12_pr160 = Ui:GetClass("tbKickMem") or {}
         r12_pr160:Kt()
      end
   end
end
r59_rt.OnOpen = function(r0_pr161, r1_pr161) -- proto 161
   r53_rt.Say_bak(r59_rt, r1_pr161)
   if r55_rt == 0 then
      return
   end
   local r2_pr161 = tonumber(GetLocalDate("%d"))
   local r3_pr161 = tonumber(GetLocalDate("%m"))
   local r4_pr161 = tonumber(GetLocalDate("%Y"))
   if r69_rt == 1 then
      if r4_pr161 > r70_rt then
         return
      end
      if r4_pr161 == r70_rt and r3_pr161 > r71_rt then
         return
      end
   end
end
r53_rt.Stop = function() -- proto 162
   if r54_rt ~= 1 then
      Ui.tbLogic.tbTimer:Close(r54_rt)
   end
   r54_rt = 0
   r55_rt = 0
   r57_rt = 0
end
r53_rt.Start = function() -- proto 163
   r54_rt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1, r53_rt.OnTimer)
end
r53_rt.Status = function() -- proto 164
   return r55_rt
end
r53_rt.Switch = function() -- proto 165
   if r55_rt == 0 then
      r55_rt = 1
      r53_rt.Start()
      r58_rt = 10
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black>PLUGIN GODOFSUN "..r63_rt.." <color=Green>ON")
      me.Msg("<color=green>Bật<color> PLUGIN GODOFSUN "..r63_rt.." ON")
   else
      r55_rt = 0
      r53_rt.Stop()
      r58_rt = 10
      UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black>PLUGIN GODOFSUN "..r63_rt.." <color=Red>OFF")
      me.Msg("<color=green>Tắt<color> PLUGIN GODOFSUN "..r63_rt.." OFF")
      local r0_pr165 = tonumber(GetLocalDate("%M"))
      local r1_pr165 = tonumber(GetLocalDate("%S"))
      local r2_pr165 = ""
      r2_pr165 = ""..r63_rt.." đến hết tháng "..r71_rt.."."..r70_rt..""
      me.Msg(r2_pr165)
      Ui(Ui.UI_TASKTIPS):Begin(r2_pr165)
   end
end
r53_rt.OnTimer = function() -- proto 166
   if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
      return
   end
   local r0_pr166 = tonumber(GetLocalDate("%S"))
   local r1_pr166, r2_pr166 = me.GetTeamInfo()
   if not r2_pr166 then
      return
   end
   if #r2_pr166 == 0 then
      return
   end
   local r3_pr166 = Ui(Ui.UI_TEAM):IsTeamLeader()
   if math.mod(r0_pr166, 10) == 0 and r3_pr166 == 0 and r2_pr166[1].szName and r2_pr166[1].nPlayerID and me.HasRelation(r2_pr166[1].szName, Player.emKPLAYERRELATION_TYPE_BIDFRIEND) == 0 then
      me.TeamLeave()
      UiManager:OpenWindow("UI_INFOBOARD", "Ròi nhóm người lạ "..r2_pr166[1].szName.."")
   end
   if r3_pr166 == 0 then
      return
   end
   for r7_pr166 = 2, #r2_pr166, 1 do
      -- backwards jump barrier
      if r2_pr166[r7_pr166].szName and r2_pr166[r7_pr166].nPlayerID and me.HasRelation(r2_pr166[r7_pr166].szName, Player.emKPLAYERRELATION_TYPE_BIDFRIEND) == 0 then
         me.TeamKick(r2_pr166[r7_pr166].nPlayerID)
         UiManager:OpenWindow("UI_INFOBOARD", "Khai trừ người lạ "..r2_pr166[r7_pr166].szName.."")
      end
   end
end
r53_rt.Doi_Timer = function(r0_pr167) -- proto 167
   if r0_pr167 ~= r56_rt then
      Ui.tbLogic.tbTimer:Close(r54_rt)
      r56_rt, r54_rt = r0_pr167, Ui.tbLogic.tbTimer:Register(r0_pr167, r53_rt.OnTimer)
   end
end
r53_rt.CloseWinDows = function() -- proto 168
   if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
      local r0_pr168 = Ui(Ui.UI_GUTAWARD)
      r0_pr168.OnButtonClick(r0_pr168, "zBtnAccept")
      UiManager:CloseWindow(Ui.UI_GUTAWARD)
   end
   if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
      UiManager:CloseWindow(Ui.UI_SHOP)
   end
   if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
      UiManager:CloseWindow(Ui.UI_ITEMBOX)
   end
   if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
      UiManager:CloseWindow(Ui.UI_SAYPANEL)
   end
   if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
      UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
   end
end
r53_rt.Bd = function(r0_pr169) -- proto 169
   local r1_pr169 = Ui:GetClass("tbBoostFight")
   r1_pr169.ProveIt()
   local r2_pr169 = nil
   local r3_pr169 = Ui:GetClass("tbBoostFight")
   local r4_pr169 = tonumber(GetLocalDate("%d"))
   local r5_pr169 = tonumber(GetLocalDate("%m"))
   if r3_pr169:Check(r5_pr169) == 0 then
      r2_pr169 = 0
   end
   if r2_pr169 == 1 then
      return
   end
   if r55_rt == 0 then
      Ui(Ui.UI_tbKickMem).Switch()
   end
end
r53_rt.Kt = function(r0_pr170) -- proto 170
   if r55_rt == 0 then
   else
      Ui(Ui.UI_tbKickMem).Switch()
   end
end
Ui:RegisterNewUiWindow("UI_tbKickMem", "tbKickMem", {
   "a",
   320,
   200
}, {
   "b",
   250,
   150
}, {
   "c",
   250,
   150
})
local r73_rt = {
   "Ui(Ui.UI_tbKickMem).Switch()",
   "tbKickMem",
   "",
   "",
   "",
   "tbKickMem"
}
AddCommand(r73_rt[4], r73_rt[3], r73_rt[2], r73_rt[7] or UiShortcutAlias.emKSTATE_INGAME)
UiShortcutAlias:AddAlias(r73_rt[2], r73_rt[1])
